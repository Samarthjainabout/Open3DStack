* NAND3_X4RL_T5 measured-PWL ngspice transient check.
* First-cycle full-swing operation at the selected measured-data bias.

.include "nand3_x4rl_t5_measured_ngspice.inc"
.temp 25

.param VDD=2.0
.param VIH=4.25
.param CLOAD=10f

VSUP vdd 0 {VDD}
VA1 a1 0 PULSE(0 {VIH} 10u 0.1u 0.1u 90u 1m)
VA2 a2 0 PULSE(0 {VIH} 10u 0.1u 0.1u 90u 1m)
VA3 a3 0 PULSE(0 {VIH} 10u 0.1u 0.1u 90u 1m)

XNAND a1 a2 a3 vdd 0 y nand3_x4rl_t5_measured_ngspice
CLOAD y 0 {CLOAD}
RLEAK y 0 1e15

.control
set filetype=ascii
tran 0.05u 0.2m
let isup=-i(vsup)
meas tran y_low_111  avg v(y) from=65u to=98u
meas tran y_high_000 avg v(y) from=150u to=190u
meas tran isup_on_avg avg isup from=65u to=98u
wrdata nand3_x4rl_t5_measured_ngspice_tb.dat time v(a1) v(y) isup
quit
.endc

.end
