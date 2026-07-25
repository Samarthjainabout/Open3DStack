* High-speed TFT W=20.825um measured transient replay validation.
.include "tft_w20p825_highspeed_ngspice.inc"

.param Tstop=10m
.temp 27.0

Bvd d 0 V={tft_w20p825_highspeed_vd_force(time)}
Bvg g 0 V={tft_w20p825_highspeed_vg_force(time)}
Bvmeas vg_meas 0 V={tft_w20p825_highspeed_vmeas(time)}
Vidprobe d dint 0
Xhs dint g 0 tft_w20p825_highspeed_ngspice
Bid_expected id_expected 0 V={tft_w20p825_highspeed_id(time)}

.tran 0.5u {Tstop} 0 0.25u
.print tran v(d) v(g) v(vg_meas) v(id_expected) i(Vidprobe)

.control
run
set filetype=ascii
set wr_singlescale
set wr_vecnames
let id_model = i(vidprobe)
wrdata highspeed_20p825_replay_ngspice.dat time id_model v(id_expected) v(d) v(g) v(vg_meas)
write highspeed_20p825_replay_ngspice.raw
.endc

.end
