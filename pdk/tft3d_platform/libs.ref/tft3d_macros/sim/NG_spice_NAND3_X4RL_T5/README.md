# NG_spice_NAND3_X4RL_T5

Measured-data-derived ngspice model for `NAND3_X4RL_T5`.

## Model

`nand3_x4rl_t5_measured_ngspice.inc` provides a portable stock-ngspice NAND3
model with the same pin order as `peripheral_ic_v2.spice`:

```spice
.subckt nand3_x4rl_t5_measured_ngspice a1 a2 a3 vdd vss y
```

The model uses:

- 25 C measured NAND pull-up diode and 3-TFT series pull-down PWL tables.
- NAND pull-up diode scaled to `Wpu ~= 0.75 mm`.
- Explicit trap lag, gate/output lag, hysteresis, and small dynamic contact RC.
- The `peripheral_ic_v2.spice` NAND topology: one diode-connected pull-up and
  three `W24/L5` pull-down TFTs in series.

Recommended bias from the measured-PWL shmoo:

```text
VDD = 2.0 V
VIL = 0 V
VIH = 4.25 V
Cload = 10 fF
```

For pulse-derived cycle variation, use the extra-scale-pin variant:

```spice
.subckt nand3_x4rl_t5_measured_ngspice_scaled a1 a2 a3 vdd vss y pdscale
```

`V(pdscale)` multiplies the NAND pull-down branch conductance.

## Run with ngspice

```bash
./run_ngspice_nand3.sh
```

Direct command:

```bash
ngspice -b -o nand3_x4rl_t5_measured_ngspice_tb.log nand3_x4rl_t5_measured_ngspice_tb.sp
```

Output files:

- `nand3_x4rl_t5_measured_ngspice_tb.dat`
- `nand3_x4rl_t5_measured_ngspice_tb.log`

The transient deck writes time, common input voltage, output voltage, and supply
current for the first `0.2 ms` switching window.

Last local ngspice-46 check:

| Metric | Value |
|---|---:|
| `Y_LOW(111)` average, 65-98 us | 0.559 V |
| `Y_HIGH(000)` average, 150-190 us | 2.005 V |
| `I_SUP` average during `111` | 12.3 nA |
