# Peripheral_IC v3 Behavioral Model

This folder contains the v3 behavioral model for the TFT/FeFET Peripheral_IC
macro.  V3 is built on top of the v2 behavioral model and is meant to isolate a
row-parallel BEOL search direction with a calibrated read/search swing target.

## Difference From V2

V2 is the baseline architectural model.  It keeps the macro-level operations
from `peripheral_ic_v2.spice`: program, row read, masked BCAM-style search,
latency estimates, and energy estimates.  Its default timing and voltage values
are conservative and close to the original SPICE stimulus assumptions.

V3 keeps the v2 programming behavior, row read behavior, Hamming-distance search
logic, and energy equations, but changes these items:

| Area | V2 default | V3 default |
| --- | --- | --- |
| Precharge/equalize window | 10 us | 0.5 us |
| Bitline evaluate window | 5 us | 0.5 us |
| Read/search swing, `v_read` | 3.0 V | 0.30 V |
| BCAM search architecture | row scan or parallel | row-parallel only |
| Sense-margin reporting | not included | MC-calibrated guardrail |

## V3 Sense-Margin Guardrail

`SenseMarginModelV3` adds a report-only guardrail based on the remote ngspice
Monte Carlo sense-amp sweep:

- recommended read/search swing range: 0.3 V to 0.6 V
- conservative MC output separation at 0.3 V: about 76 mV
- conservative MC output separation at 0.6 V: about 228 mV
- minimum observed non-overlap point in that sweep: about 0.15 V

The guardrail is attached to `read_row()` and `bcam_search()` results under
`details["v3_sense_margin"]`.  It reports whether the selected swing is
`overlap_risk`, `marginal`, `target`, or `above_target`.

## What V3 Does Not Change

V3 does not bake in future SL/BL capacitance scaling targets.  The source-line,
bitline, word-line, FeFET polarization, decoder, mux, and sense energy terms
still come from the inherited v2 energy model unless the caller overrides them.

This is intentional: the 0.3 V to 0.6 V swing target is supported by the
sense-amp Monte Carlo run, while lower SL/BL capacitance targets still require
future layout/device extraction before they should be treated as achieved model
defaults.

## Run

From the repository root:

```sh
python3 pdk/tft3d_platform/libs.ref/tft3d_macros/sim/peripheral_ic_v3_behavioral/peripheral_ic_v3_behavioral.py --demo
```

Run the local checks:

```sh
python3 pdk/tft3d_platform/libs.ref/tft3d_macros/sim/peripheral_ic_v3_behavioral/test_peripheral_ic_v3_behavioral.py
```

