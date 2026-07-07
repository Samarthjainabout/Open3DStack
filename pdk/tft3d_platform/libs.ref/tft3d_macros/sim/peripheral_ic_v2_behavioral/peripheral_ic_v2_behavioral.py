#!/usr/bin/env python3
"""High-level behavioral model for the Peripheral_IC v2 TFT/FeFET macro.

This model is intentionally architectural.  It keeps the useful behavior for
system studies: programming, row readout, BCAM-style masked search, latency, and
energy estimates.  Detailed analog bias rails from the extracted SPICE macro are
collapsed into configurable timing, capacitance, and voltage parameters.
"""

from __future__ import annotations

import argparse
import json
import math
from dataclasses import asdict, dataclass, field
from typing import Dict, Iterable, List, Optional, Sequence, Tuple, Union


ROWS = 32
COLS = 8
WORD_MASK = (1 << COLS) - 1


BitLike = Union[int, bool]
WordLike = Union[int, Sequence[BitLike]]


@dataclass(frozen=True)
class TimingModel:
    """Nominal timing knobs for the macro-level operation model.

    Defaults are conservative and map to the bundled SPICE deck's stimulus:
    10 us precharge/equalize pulses and 5 us word-line/evaluate windows.  The
    smaller decode/driver terms are placeholders to keep the latency breakdown
    visible until calibrated measurements replace them.
    """

    row_decode_s: float = 0.25e-6
    column_decode_s: float = 0.15e-6
    wl_driver_s: float = 0.25e-6
    mux_s: float = 0.10e-6
    precharge_equalize_s: float = 10.0e-6
    bitline_eval_s: float = 5.0e-6
    sense_s: float = 0.50e-6
    program_switch_s: float = 10.0e-6
    bcam_reduce_per_bit_s: float = 0.03e-6

    def row_read_latency(self, active_cols: int = COLS) -> float:
        reduce_s = max(active_cols - 1, 0) * self.bcam_reduce_per_bit_s
        return (
            self.precharge_equalize_s
            + self.row_decode_s
            + self.wl_driver_s
            + self.mux_s
            + self.bitline_eval_s
            + self.sense_s
            + reduce_s
        )

    def program_bit_latency(self) -> float:
        return (
            self.row_decode_s
            + self.column_decode_s
            + self.wl_driver_s
            + self.program_switch_s
        )


@dataclass(frozen=True)
class EnergyModel:
    """Capacitance and voltage knobs used by the energy estimator.

    The explicit source-line bitcell capacitance and FeFET polarization
    capacitance come from the bundled SPICE/model files:

    * `BitCell`: `c0 sl 0 c=2e-12`, `c16 slb 0 c=2e-12`
    * `fetft_nf1_vds0p1_ngspice.inc`: `pol_c=1e-12`
    """

    v_read: float = 3.0
    v_program: float = 3.0
    v_wl: float = 1.2
    cell_sl_cap_f: float = 2.0e-12
    cell_bitline_cap_f: float = 0.20e-12
    cell_wl_gate_cap_f: float = 0.04e-12
    fetft_pol_cap_f: float = 1.0e-12
    decoder_energy_j: float = 2.0e-12
    write_driver_energy_j: float = 2.0e-12
    sense_energy_per_col_j: float = 1.0e-12
    mux_energy_per_col_j: float = 0.5e-12
    mismatch_discharge_factor: float = 1.0

    @property
    def column_sl_cap_f(self) -> float:
        return ROWS * self.cell_sl_cap_f

    @property
    def column_bitline_cap_f(self) -> float:
        return ROWS * self.cell_bitline_cap_f

    @property
    def row_wl_cap_f(self) -> float:
        return COLS * self.cell_wl_gate_cap_f


@dataclass(frozen=True)
class DeviceReadModel:
    """First-order RC lower-bound for cell-level read development.

    The FeFET defaults are taken from the bundled Vds=0.1 V, Vg=3 V conductance
    tables.  The access TFT conductance is a scaled estimate from the measured
    TFT W=8, L=3 model to the macro's W=6, L=5 access device.  The full macro
    latency normally remains dominated by the pulse-based timing model.
    """

    fetft_lvt_conductance_s: float = 268e-6
    fetft_hvt_conductance_s: float = 225e-6
    access_tft_on_conductance_s: float = 40e-6
    sense_delta_v: float = 0.20

    def effective_cell_conductance(self, stored_bit: int, query_bit: Optional[int]) -> float:
        if query_bit is None:
            fetft_g = (
                self.fetft_lvt_conductance_s
                if stored_bit
                else self.fetft_hvt_conductance_s
            )
        elif stored_bit == query_bit:
            fetft_g = self.fetft_hvt_conductance_s
        else:
            fetft_g = self.fetft_lvt_conductance_s

        access_g = self.access_tft_on_conductance_s
        return 1.0 / ((1.0 / max(access_g, 1e-30)) + (1.0 / max(fetft_g, 1e-30)))


@dataclass
class OperationReport:
    operation: str
    latency_s: float
    energy_j: float
    details: Dict[str, object] = field(default_factory=dict)

    def to_dict(self) -> Dict[str, object]:
        return {
            "operation": self.operation,
            "latency_s": self.latency_s,
            "energy_j": self.energy_j,
            "details": self.details,
        }


@dataclass
class SearchHit:
    row: int
    stored_word: int
    query_word: int
    mask_word: int
    distance: int
    matched: bool
    mismatch_cols: List[int]

    def to_dict(self) -> Dict[str, object]:
        return asdict(self)


@dataclass
class SearchReport(OperationReport):
    hits: List[SearchHit] = field(default_factory=list)

    def to_dict(self) -> Dict[str, object]:
        payload = super().to_dict()
        payload["hits"] = [hit.to_dict() for hit in self.hits]
        return payload


def _check_index(name: str, value: int, limit: int) -> None:
    if not 0 <= value < limit:
        raise ValueError(f"{name} must be in [0, {limit - 1}], got {value}")


def bits_to_word(bits: Sequence[BitLike]) -> int:
    if len(bits) != COLS:
        raise ValueError(f"expected {COLS} bits, got {len(bits)}")
    word = 0
    for col, bit in enumerate(bits):
        word |= (1 if bit else 0) << col
    return word


def word_to_bits(word: WordLike) -> List[int]:
    if isinstance(word, int):
        if not 0 <= word <= WORD_MASK:
            raise ValueError(f"word must fit in {COLS} bits, got {word}")
        return [(word >> col) & 1 for col in range(COLS)]
    return [(1 if bit else 0) for bit in word]


def normalize_word(word: WordLike) -> int:
    return bits_to_word(word_to_bits(word))


def normalize_mask(mask: WordLike = WORD_MASK) -> int:
    return normalize_word(mask)


def decode_3bit(a0: BitLike, a1: BitLike, a2: BitLike) -> int:
    return (1 if a0 else 0) | ((1 if a1 else 0) << 1) | ((1 if a2 else 0) << 2)


def decode_rows_from_d_pins(d_bits: Sequence[BitLike]) -> Tuple[int, int, int, int]:
    """Return the four row indexes selected by the macro's four 3-to-8 decoders.

    `peripheral_ic_v2.spice` has four independent row decoder instances:
    `d0..d2 -> rows 0..7`, `d3..d5 -> rows 8..15`,
    `d6..d8 -> rows 16..23`, and `d9..d11 -> rows 24..31`.
    """

    if len(d_bits) != 12:
        raise ValueError(f"expected 12 d-pins, got {len(d_bits)}")
    return (
        decode_3bit(d_bits[0], d_bits[1], d_bits[2]),
        8 + decode_3bit(d_bits[3], d_bits[4], d_bits[5]),
        16 + decode_3bit(d_bits[6], d_bits[7], d_bits[8]),
        24 + decode_3bit(d_bits[9], d_bits[10], d_bits[11]),
    )


def encode_d_pins_for_row(row: int) -> List[int]:
    """Encode one row into the 12 d-pins while clearing other row banks.

    The actual SPICE macro has no explicit bank enable in the top-level pin list,
    so this helper is mainly documentation for high-level flows.
    """

    _check_index("row", row, ROWS)
    bits = [0] * 12
    bank = row // 8
    offset = row % 8
    base = bank * 3
    bits[base + 0] = offset & 1
    bits[base + 1] = (offset >> 1) & 1
    bits[base + 2] = (offset >> 2) & 1
    return bits


class PeripheralICV2Behavioral:
    """Behavioral model for a 32-row by 8-bit Peripheral_IC v2 macro."""

    rows = ROWS
    cols = COLS

    def __init__(
        self,
        initial_words: Optional[Sequence[WordLike]] = None,
        timing: Optional[TimingModel] = None,
        energy: Optional[EnergyModel] = None,
        device: Optional[DeviceReadModel] = None,
    ) -> None:
        self.timing = timing or TimingModel()
        self.energy = energy or EnergyModel()
        self.device = device or DeviceReadModel()
        self._mem = [[0 for _ in range(COLS)] for _ in range(ROWS)]
        if initial_words is not None:
            self.load_words(initial_words)

    def load_words(self, words: Sequence[WordLike]) -> None:
        if len(words) > ROWS:
            raise ValueError(f"at most {ROWS} rows can be loaded")
        for row, word in enumerate(words):
            bits = word_to_bits(word)
            self._mem[row] = bits[:]

    def dump_words(self) -> List[int]:
        return [bits_to_word(row) for row in self._mem]

    def word(self, row: int) -> int:
        _check_index("row", row, ROWS)
        return bits_to_word(self._mem[row])

    def bit(self, row: int, col: int) -> int:
        _check_index("row", row, ROWS)
        _check_index("col", col, COLS)
        return self._mem[row][col]

    def _active_cols(self, mask_word: int) -> List[int]:
        return [col for col in range(COLS) if (mask_word >> col) & 1]

    def _wl_energy(self) -> float:
        return 0.5 * self.energy.row_wl_cap_f * self.energy.v_wl**2

    def _precharge_energy(self, active_cols: int) -> float:
        cap = 2.0 * active_cols * self.energy.column_bitline_cap_f
        return 0.5 * cap * self.energy.v_read**2

    def _search_drive_energy(self, active_cols: int) -> float:
        cap = 2.0 * active_cols * self.energy.column_sl_cap_f
        return 0.5 * cap * self.energy.v_read**2

    def _program_line_energy(self) -> float:
        switched_cap = 2.0 * (
            self.energy.column_bitline_cap_f + self.energy.column_sl_cap_f
        )
        return 0.5 * switched_cap * self.energy.v_program**2

    def _fetft_switch_energy(self, changed: bool) -> float:
        if not changed:
            return 0.0
        cap = 2.0 * self.energy.fetft_pol_cap_f
        return 0.5 * cap * self.energy.v_program**2

    def estimate_cell_read_delay_s(
        self,
        row: int,
        col: int,
        query_bit: Optional[int] = None,
    ) -> float:
        """Return first-order RC cell-development delay before macro overhead."""

        stored_bit = self.bit(row, col)
        if query_bit is not None:
            query_bit = 1 if query_bit else 0
        conductance = self.device.effective_cell_conductance(stored_bit, query_bit)
        cap = self.energy.column_bitline_cap_f + self.energy.cell_sl_cap_f
        tau = cap / max(conductance, 1e-30)
        target = min(max(self.device.sense_delta_v / self.energy.v_read, 1e-9), 0.95)
        return -math.log(1.0 - target) * tau

    def program_bit(self, row: int, col: int, value: BitLike) -> OperationReport:
        """Program one selected row/column bit through the column driver path."""

        _check_index("row", row, ROWS)
        _check_index("col", col, COLS)
        new_bit = 1 if value else 0
        old_bit = self._mem[row][col]
        changed = old_bit != new_bit
        self._mem[row][col] = new_bit

        line_energy = self._program_line_energy()
        switch_energy = self._fetft_switch_energy(changed)
        energy_j = (
            self.energy.decoder_energy_j
            + self.energy.write_driver_energy_j
            + self._wl_energy()
            + line_energy
            + switch_energy
        )
        return OperationReport(
            operation="program_bit",
            latency_s=self.timing.program_bit_latency(),
            energy_j=energy_j,
            details={
                "row": row,
                "col": col,
                "old_bit": old_bit,
                "new_bit": new_bit,
                "changed": changed,
                "line_energy_j": line_energy,
                "fetft_switch_energy_j": switch_energy,
                "note": "single-column program path; bias rail detail ignored",
            },
        )

    def program_word(
        self,
        row: int,
        word: WordLike,
        mask: WordLike = WORD_MASK,
    ) -> OperationReport:
        """Program masked bits of an 8-bit row.

        The extracted macro has one 3-to-8 column decoder and one data input, so
        masked word programming is modeled as sequential selected-column writes.
        """

        _check_index("row", row, ROWS)
        word_bits = word_to_bits(word)
        mask_word = normalize_mask(mask)
        reports = []
        for col in self._active_cols(mask_word):
            reports.append(self.program_bit(row, col, word_bits[col]))

        return OperationReport(
            operation="program_word",
            latency_s=sum(report.latency_s for report in reports),
            energy_j=sum(report.energy_j for report in reports),
            details={
                "row": row,
                "word": bits_to_word(word_bits),
                "mask_word": mask_word,
                "programmed_cols": self._active_cols(mask_word),
                "bit_reports": [report.to_dict() for report in reports],
            },
        )

    def program_rows_from_d_pins(
        self,
        d_bits: Sequence[BitLike],
        col_bits: Sequence[BitLike],
        value: BitLike,
    ) -> OperationReport:
        """Program the rows selected by the macro's four row decoders.

        This mirrors the top-level SPICE pin grouping.  Because the macro has no
        explicit bank-enable pin, four rows are selected by the raw `d0..d11`
        decode.  Higher-level applications often call `program_bit` instead.
        """

        rows = decode_rows_from_d_pins(d_bits)
        col = decode_3bit(*col_bits)
        reports = [self.program_bit(row, col, value) for row in rows]
        return OperationReport(
            operation="program_rows_from_d_pins",
            latency_s=max(report.latency_s for report in reports),
            energy_j=sum(report.energy_j for report in reports),
            details={
                "rows": list(rows),
                "col": col,
                "value": 1 if value else 0,
                "row_reports": [report.to_dict() for report in reports],
            },
        )

    def read_row(self, row: int, mask: WordLike = WORD_MASK) -> OperationReport:
        _check_index("row", row, ROWS)
        mask_word = normalize_mask(mask)
        active_cols = self._active_cols(mask_word)
        word = self.word(row) & mask_word

        cell_delays = {
            col: self.estimate_cell_read_delay_s(row, col)
            for col in active_cols
        }
        energy_j = (
            self.energy.decoder_energy_j
            + self._wl_energy()
            + self._precharge_energy(len(active_cols))
            + len(active_cols) * self.energy.sense_energy_per_col_j
            + len(active_cols) * self.energy.mux_energy_per_col_j
        )
        return OperationReport(
            operation="read_row",
            latency_s=max(
                self.timing.row_read_latency(len(active_cols)),
                max(cell_delays.values(), default=0.0),
            ),
            energy_j=energy_j,
            details={
                "row": row,
                "word": word,
                "mask_word": mask_word,
                "active_cols": active_cols,
                "cell_rc_delay_s": cell_delays,
                "note": "latency includes precharge, WL decode/drive, mux, evaluate, sense",
            },
        )

    def bcam_search(
        self,
        query: WordLike,
        mask: WordLike = WORD_MASK,
        rows: Optional[Iterable[int]] = None,
        max_distance: int = 0,
        parallel_rows: bool = False,
    ) -> SearchReport:
        """Perform BCAM-style masked search using Hamming distance.

        `parallel_rows=False` models scanning rows through the selected-WL macro
        interface.  `parallel_rows=True` is useful for architectural what-if
        studies where row match lines are added above this macro.
        """

        query_word = normalize_word(query)
        mask_word = normalize_mask(mask)
        active_cols = self._active_cols(mask_word)
        selected_rows = list(range(ROWS) if rows is None else rows)
        for row in selected_rows:
            _check_index("row", row, ROWS)

        hits: List[SearchHit] = []
        total_mismatches = 0
        worst_cell_delay = 0.0
        for row in selected_rows:
            stored_word = self.word(row)
            diff = (stored_word ^ query_word) & mask_word
            mismatch_cols = self._active_cols(diff)
            total_mismatches += len(mismatch_cols)
            for col in active_cols:
                worst_cell_delay = max(
                    worst_cell_delay,
                    self.estimate_cell_read_delay_s(row, col, (query_word >> col) & 1),
                )
            distance = len(mismatch_cols)
            hits.append(
                SearchHit(
                    row=row,
                    stored_word=stored_word,
                    query_word=query_word,
                    mask_word=mask_word,
                    distance=distance,
                    matched=distance <= max_distance,
                    mismatch_cols=mismatch_cols,
                )
            )

        per_row_latency = max(
            self.timing.row_read_latency(len(active_cols)),
            worst_cell_delay,
        )
        latency_s = per_row_latency if parallel_rows else per_row_latency * len(selected_rows)

        per_row_energy = (
            self.energy.decoder_energy_j
            + self._wl_energy()
            + self._precharge_energy(len(active_cols))
            + self._search_drive_energy(len(active_cols))
            + len(active_cols) * self.energy.sense_energy_per_col_j
            + len(active_cols) * self.energy.mux_energy_per_col_j
        )
        mismatch_energy = (
            total_mismatches
            * 0.5
            * self.energy.column_bitline_cap_f
            * self.energy.v_read**2
            * self.energy.mismatch_discharge_factor
        )
        energy_j = len(selected_rows) * per_row_energy + mismatch_energy

        return SearchReport(
            operation="bcam_search",
            latency_s=latency_s,
            energy_j=energy_j,
            details={
                "query_word": query_word,
                "mask_word": mask_word,
                "rows": selected_rows,
                "active_cols": active_cols,
                "max_distance": max_distance,
                "parallel_rows": parallel_rows,
                "per_row_latency_s": per_row_latency,
                "per_row_energy_j": per_row_energy,
                "mismatch_energy_j": mismatch_energy,
                "total_mismatches": total_mismatches,
                "note": "BCAM search drives query/complement on SL/SLB and popcounts sensed mismatches",
            },
            hits=hits,
        )

    def top_k_search(
        self,
        query: WordLike,
        k: int,
        mask: WordLike = WORD_MASK,
        rows: Optional[Iterable[int]] = None,
    ) -> SearchReport:
        """Return the k nearest BCAM rows by Hamming distance."""

        report = self.bcam_search(query=query, mask=mask, rows=rows, max_distance=COLS)
        report.hits.sort(key=lambda hit: (hit.distance, hit.row))
        report.hits = report.hits[:k]
        report.operation = "top_k_search"
        report.details["k"] = k
        return report


def demo() -> Dict[str, object]:
    model = PeripheralICV2Behavioral()
    program_reports = [
        model.program_word(0, 0b1010_1100),
        model.program_word(1, 0b1010_0100),
        model.program_word(2, 0b0010_1100),
        model.program_word(3, 0b1111_0000),
    ]
    read_report = model.read_row(0)
    search_report = model.bcam_search(
        query=0b1010_1100,
        mask=0b1111_1111,
        rows=range(4),
        max_distance=1,
    )
    topk_report = model.top_k_search(query=0b1010_1000, k=2, rows=range(4))
    return {
        "program": [report.to_dict() for report in program_reports],
        "read": read_report.to_dict(),
        "bcam_search": search_report.to_dict(),
        "top_k_search": topk_report.to_dict(),
        "final_words": model.dump_words()[:4],
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--demo", action="store_true", help="run a small program/read/search demo")
    parser.add_argument("--query", type=lambda x: int(x, 0), help="8-bit query word")
    parser.add_argument("--mask", type=lambda x: int(x, 0), default=WORD_MASK, help="8-bit mask")
    parser.add_argument("--words", nargs="*", type=lambda x: int(x, 0), help="initial row words")
    parser.add_argument("--top-k", type=int, default=0, help="return k nearest rows")
    args = parser.parse_args()

    if args.demo:
        print(json.dumps(demo(), indent=2, sort_keys=True))
        return

    if args.query is None:
        parser.error("provide --demo or --query")

    model = PeripheralICV2Behavioral(initial_words=args.words or [])
    if args.top_k:
        report = model.top_k_search(args.query, args.top_k, mask=args.mask)
    else:
        report = model.bcam_search(args.query, mask=args.mask)
    print(json.dumps(report.to_dict(), indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
