# Peripheral_IC v2 Behavioral Model

This folder contains a high-level behavioral model for:

```text
../../spice/peripheral_ic_v2.spice
```

The model is intended for architectural studies, not transistor-level signoff.
It keeps the useful behavior for future CNN, vector-search, and RAG-style
system experiments:

- program one selected FeFET/TFT bit through the macro column-driver path
- program an 8-bit row as sequential selected-column writes
- read an 8-bit row through precharge, selected WL, mux, and sense timing
- run BCAM-style masked search and return Hamming distance per row
- estimate latency and energy for program, read, and search operations

Detailed bias rails from the SPICE macro are intentionally collapsed into
configurable timing, capacitance, and voltage parameters.

## Macro Mapping

`peripheral_ic_v2.spice` instantiates:

- 32 word-line drivers connected to `stack_sram_array_f5`
- four `row_decoder_3to8_nmos` instances
- one `column_decoder_3to8_nmos`
- eight write drivers, precharge/equalizers, mux paths, and sense amps
- a `32 x 8` differential FeFET/TFT bitcell array

The raw top-level row pins are grouped as four independent 3-bit decoders:

| Pins | Rows |
| --- | --- |
| `d0 d1 d2` | `0..7` |
| `d3 d4 d5` | `8..15` |
| `d6 d7 d8` | `16..23` |
| `d9 d10 d11` | `24..31` |

The Python model exposes direct `row` APIs for higher-level use.  It also keeps
`decode_rows_from_d_pins()` and `program_rows_from_d_pins()` to document the raw
SPICE pin grouping.

## BCAM Mode

The BCAM abstraction is binary, differential, and maskable:

1. Program each stored row using `program_word(row, word)`.
2. During search, drive each query bit and complement onto the corresponding
   `SL/SLB` search rails.
3. Precharge/equalize the sensed BL/BLB path.
4. Assert the selected WL and let mismatch cells create larger differential
   discharge.
5. Sense each column and popcount mismatches to get Hamming distance.
6. Treat a row as matched when `distance <= max_distance`.

In the current macro interface this is modeled as a selected-row operation.
`bcam_search(..., parallel_rows=False)` scans selected rows sequentially.
`parallel_rows=True` is included for future architectural studies where row
match-line support or additional row-parallel periphery is added above this
macro.

## Delay Model

Default timing terms are conservative and tied to the available macro testbench:

- `precharge_equalize_s = 10 us`
- `bitline_eval_s = 5 us`
- `program_switch_s = 10 us`

Smaller row decode, column decode, WL driver, mux, sense, and Hamming-reduction
terms are exposed in `TimingModel` and should be calibrated with measured or
ngspice macro simulations when those are available.

The model also includes a first-order cell RC lower bound through
`estimate_cell_read_delay_s()`.  Its defaults use:

- FeFET LVT/HVT conductance values near `Vds=0.1 V`, `Vg=3 V` from
  `../FeTFT HSPICE/g_nf1_lvt_tbl.tbl` and
  `../FeTFT HSPICE/g_nf1_hvt_tbl.tbl`
- a W/L-scaled estimate of the access TFT from `../TFT HSPICE/g_n1_tbl.tbl`

The macro-level read latency is the larger of the configured pulse-style timing
and this cell RC estimate.

## Energy Model

The energy model uses first-order dynamic capacitance estimates:

```text
E = 0.5 * C * V^2
```

Repo-anchored default parameters:

- bitcell `SL` and `SLB` capacitors: `2 pF` each from the `BitCell` subckt
- FeFET polarization capacitance: `1 pF` from
  `../NG_spice_FeTFT/fetft_nf1_vds0p1_ngspice.inc`

Other caps and fixed periphery terms are intentionally configurable placeholders:

- bitline cap per cell
- WL gate cap per cell
- decoder energy
- write-driver energy
- mux and sense energy per column
- mismatch-discharge scaling

## Usage

Run the built-in demo:

```sh
cd pdk/tft3d_platform/libs.ref/tft3d_macros/sim/peripheral_ic_v2_behavioral
python3 peripheral_ic_v2_behavioral.py --demo
```

Use from Python:

```python
from peripheral_ic_v2_behavioral import PeripheralICV2Behavioral

macro = PeripheralICV2Behavioral()
macro.program_word(0, 0b10101100)
macro.program_word(1, 0b10100100)

read = macro.read_row(0)
search = macro.bcam_search(query=0b10101100, mask=0xff, rows=range(2), max_distance=1)

print(read.to_dict())
print(search.to_dict())
```

For nearest-neighbor style retrieval:

```python
hits = macro.top_k_search(query=0b10101000, k=4)
for hit in hits.hits:
    print(hit.row, hit.distance, format(hit.stored_word, "08b"))
```

Column bit `0` is the least-significant bit of the Python word and maps to macro
column `0`.

## Limitations

- This is not a replacement for `peripheral_ic_v2.spice`.
- Exact programming windows, disturb, retention, sense margins, analog biasing,
  and FeFET history beyond binary HVT/LVT state are not modeled.
- Multi-row BCAM search is sequential by default because the current macro is
  exposed as selected-WL peripheral circuitry, not a full row-parallel CAM
  match-line array.
- Defaults are meant to be easy to replace once extracted parasitics or measured
  macro waveforms are available.
