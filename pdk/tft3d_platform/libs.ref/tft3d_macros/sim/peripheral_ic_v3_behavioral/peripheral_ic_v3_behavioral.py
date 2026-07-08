#!/usr/bin/env python3
"""Peripheral_IC v3 behavioral model.

V3 is a BEOL search experiment built on the v2 behavioral model:

* keep the v2 programming, readout, Hamming-distance, and energy equations
* reduce search/read precharge and bitline-evaluate timing windows
* expose BCAM search as row-parallel only
* apply the ngspice Monte Carlo calibrated read/search swing target

The intent is to isolate research direction #2 without changing the v2 model or
claiming any lower-node scaling benefit.  V3 does not bake in SL/BL capacitance
roadmap recommendations; those remain energy-model inputs.
"""

from __future__ import annotations

import argparse
import json
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, Iterable, Optional, Sequence, Tuple

try:
    from peripheral_ic_v2_behavioral.peripheral_ic_v2_behavioral import (
        COLS,
        ROWS,
        WORD_MASK,
        BitLike,
        DeviceReadModel,
        EnergyModel,
        OperationReport,
        PeripheralICV2Behavioral,
        SearchHit,
        SearchReport,
        TimingModel,
        WordLike,
        bits_to_word,
        decode_rows_from_d_pins,
        encode_d_pins_for_row,
        normalize_mask,
        normalize_word,
        word_to_bits,
    )
except ModuleNotFoundError:
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
    from peripheral_ic_v2_behavioral.peripheral_ic_v2_behavioral import (
        COLS,
        ROWS,
        WORD_MASK,
        BitLike,
        DeviceReadModel,
        EnergyModel,
        OperationReport,
        PeripheralICV2Behavioral,
        SearchHit,
        SearchReport,
        TimingModel,
        WordLike,
        bits_to_word,
        decode_rows_from_d_pins,
        encode_d_pins_for_row,
        normalize_mask,
        normalize_word,
        word_to_bits,
    )


@dataclass(frozen=True)
class TimingModelV3(TimingModel):
    """Timing knobs for the v3 row-parallel BEOL search target.

    The v2 model uses 10 us precharge/equalize and 5 us evaluate windows.  V3
    keeps all smaller decode/WL/mux/sense/reduction terms unchanged and only
    tightens the two dominant pulse windows to 0.5 us each.
    """

    precharge_equalize_s: float = 0.50e-6
    bitline_eval_s: float = 0.50e-6


@dataclass(frozen=True)
class EnergyModelV3(EnergyModel):
    """Energy knobs for the v3 read/search swing target.

    Capacitance values intentionally inherit from v2.  Only the read/search
    swing default changes, based on the remote ngspice sense-amp Monte Carlo
    result that showed the 0.3-0.6 V range is usable.
    """

    v_read: float = 0.30


@dataclass(frozen=True)
class SenseMarginModelV3:
    """Remote-ngspice calibrated sense-margin guardrail for v3 reports."""

    recommended_min_swing_v: float = 0.30
    recommended_max_swing_v: float = 0.60
    minimum_nonoverlap_swing_v: float = 0.15
    calibration_points: Tuple[Tuple[float, float], ...] = (
        (0.15, 0.0174),
        (0.20, 0.0249),
        (0.30, 0.0762),
        (0.40, 0.1367),
        (0.50, 0.1784),
        (0.60, 0.2278),
    )

    def estimate_margin_v(self, swing_v: float) -> float:
        points = self.calibration_points
        if swing_v <= points[0][0]:
            x0, y0 = points[0]
            x1, y1 = points[1]
        elif swing_v >= points[-1][0]:
            x0, y0 = points[-2]
            x1, y1 = points[-1]
        else:
            for left, right in zip(points, points[1:]):
                if left[0] <= swing_v <= right[0]:
                    x0, y0 = left
                    x1, y1 = right
                    break
            else:
                x0, y0 = points[-2]
                x1, y1 = points[-1]

        slope = (y1 - y0) / (x1 - x0)
        return y0 + slope * (swing_v - x0)

    def assess(self, swing_v: float) -> Dict[str, object]:
        if swing_v < self.minimum_nonoverlap_swing_v:
            status = "overlap_risk"
            note = "below the MC non-overlap point; not reliable for search"
        elif swing_v < self.recommended_min_swing_v:
            status = "marginal"
            note = "MC distributions separate, but this is below the recommended guardrail"
        elif swing_v <= self.recommended_max_swing_v:
            status = "target"
            note = "inside the calibrated 0.3-0.6 V read/search swing target"
        else:
            status = "above_target"
            note = "margin should improve, but dynamic energy and stress increase"

        return {
            "search_swing_v": swing_v,
            "estimated_output_margin_v": self.estimate_margin_v(swing_v),
            "minimum_nonoverlap_swing_v": self.minimum_nonoverlap_swing_v,
            "recommended_min_swing_v": self.recommended_min_swing_v,
            "recommended_max_swing_v": self.recommended_max_swing_v,
            "mc_nonoverlap_expected": swing_v >= self.minimum_nonoverlap_swing_v,
            "meets_recommended_swing": (
                self.recommended_min_swing_v <= swing_v <= self.recommended_max_swing_v
            ),
            "status": status,
            "note": note,
        }


class PeripheralICV3Behavioral(PeripheralICV2Behavioral):
    """V3 behavioral variant with row-parallel BCAM search and swing guardrails."""

    def __init__(
        self,
        initial_words: Optional[Sequence[WordLike]] = None,
        timing: Optional[TimingModel] = None,
        energy: Optional[EnergyModel] = None,
        device: Optional[DeviceReadModel] = None,
        sense_margin: Optional[SenseMarginModelV3] = None,
    ) -> None:
        super().__init__(
            initial_words=initial_words,
            timing=timing or TimingModelV3(),
            energy=energy or EnergyModelV3(),
            device=device,
        )
        self.sense_margin = sense_margin or SenseMarginModelV3()

    def _sense_margin_details(self) -> Dict[str, object]:
        return self.sense_margin.assess(self.energy.v_read)

    def read_row(self, row: int, mask: WordLike = WORD_MASK) -> OperationReport:
        report = super().read_row(row, mask=mask)
        report.details["v3_sense_margin"] = self._sense_margin_details()
        return report

    def bcam_search(
        self,
        query: WordLike,
        mask: WordLike = WORD_MASK,
        rows: Optional[Iterable[int]] = None,
        max_distance: int = 0,
        parallel_rows: bool = True,
    ) -> SearchReport:
        """Perform v3 BCAM search.

        V3 intentionally models only the row-parallel search architecture.  A
        selected-WL row-scan call is rejected so scripts cannot accidentally mix
        v2 and v3 assumptions.
        """

        if not parallel_rows:
            raise ValueError("PeripheralICV3Behavioral models row-parallel search only")

        report = super().bcam_search(
            query=query,
            mask=mask,
            rows=rows,
            max_distance=max_distance,
            parallel_rows=True,
        )
        report.operation = "bcam_search_v3_row_parallel"
        report.details["v3_timing_update"] = {
            "precharge_equalize_s": self.timing.precharge_equalize_s,
            "bitline_eval_s": self.timing.bitline_eval_s,
            "note": (
                "v3 changes timing/search architecture and uses the calibrated "
                "read/search swing target; energy equations otherwise match "
                "PeripheralICV2Behavioral"
            ),
        }
        report.details["v3_sense_margin"] = self._sense_margin_details()
        return report


def demo() -> Dict[str, object]:
    model = PeripheralICV3Behavioral()
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

    model = PeripheralICV3Behavioral(initial_words=args.words or [])
    if args.top_k:
        report = model.top_k_search(args.query, args.top_k, mask=args.mask)
    else:
        report = model.bcam_search(args.query, mask=args.mask)
    print(json.dumps(report.to_dict(), indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
