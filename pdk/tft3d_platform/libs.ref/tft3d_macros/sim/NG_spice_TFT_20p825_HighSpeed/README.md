# NG_spice_TFT_20p825_HighSpeed

Measured high-speed transient replay model for the `nfet_W20p825_L5` TFT macro.

Source CSV: `highspeed_20p825.csv`  
Target: `test_20_825u_pulse`  
Record time: `07/17/2026 05:15:32`  
Iteration: `3`

## Files

- `highspeed_20p825_tbl.tbl`: measured current table, `time(s) Id(A)`. The first and last measured values are held to 0 s and 10 ms to avoid PWL extrapolation.
- `highspeed_20p825_vmeas_tbl.tbl`: measured WGFMU channel-2 voltage table, `time(s) V(V)`, also endpoint-held.
- `highspeed_20p825_drive_tbl.tbl`: source pulse table, `time(s) Vd_force(V) Vg_force(V)`.
- `tft_w20p825_highspeed_ngspice.inc`: stock-ngspice PWL replay include.
- `highspeed_20p825_replay_ngspice.sp`: validation deck using the measured drive waveforms.
- `run_ngspice_highspeed_20p825.sh`: convenience runner.

## Model

```spice
.subckt tft_w20p825_highspeed_ngspice d g s scale=1 rleak=1e12
```

The subckt replays the measured channel-1 current as a time-domain current
source from `d` to `s`. It is meant for reproducing the measured pulse
experiment and comparing high-speed timing/current behavior. It is not a
standalone compact model for arbitrary bias, geometry, temperature, or waveform
conditions.

Helper PWL functions:

- `tft_w20p825_highspeed_vd_force(time)`
- `tft_w20p825_highspeed_vg_force(time)`
- `tft_w20p825_highspeed_vmeas(time)`
- `tft_w20p825_highspeed_id(time)`

## Run

```bash
./run_ngspice_highspeed_20p825.sh
```

The remote validation run writes:

- `highspeed_20p825_replay_ngspice.dat`
- `highspeed_20p825_replay_ngspice.raw`
- `highspeed_20p825_replay_ngspice.log`
