* Layer 2 TFT V2 Id-Vg remote ngspice validation deck.
.include "tft_n1_n2_ngspice_V2.inc"

.param Vd=0.1
.param Wtft=8e-6
.param Ltft=3e-6
.param Mtft=1
.temp 27.0

Vd1 d1 0 dc={Vd}
Vd2 d2 0 dc={Vd}
Vgsrc vg 0 dc=0
Xn1 d1 0 vg tft_n1_ngspice_v2 w={Wtft} l={Ltft} m={Mtft}
Xn2 d2 0 vg tft_n2_ngspice_v2 w={Wtft} l={Ltft} m={Mtft}

.dc Vgsrc -4.0 4.0 0.2
.print dc v(vg) i(Vd1) i(Vd2)

.control
run
set filetype=ascii
set wr_singlescale
set wr_vecnames
let id_n1 = -i(vd1)
let id_n2 = -i(vd2)
wrdata id_vg_tft_n1_n2_ngspice_V2.dat v(vg) id_n1 id_n2
write id_vg_tft_n1_n2_ngspice_V2.raw
.endc

.end
