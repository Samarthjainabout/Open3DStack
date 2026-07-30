4T cross-coupled FeTFT/TFT bitcell differential AC response - stock ngspice

.include "bitcell_4t_ac_ngspice.inc"

.param Vwl=3
.param Cbl=2p
.param Rbleed=1e12

.options reltol=1e-5 abstol=1e-14 chgtol=1e-16
.temp 27

* Differential source-line excitation: V(sl)-V(slb) = 1 V AC.
Vsl sl 0 DC 0 AC 0.5
Vslb slb 0 DC 0 AC -0.5

* Selected read word-line. The bitline nodes are otherwise floating apart from
* their capacitance and a very weak DC bleed for the operating point.
Vwl wl 0 DC {Vwl}
Cbl bl 0 {Cbl}
Cblb blb 0 {Cbl}
Rbl bl 0 {Rbleed}
Rblb blb 0 {Rbleed}

Xcell bl blb p_nf1 p_nf2 sl slb wl bitcell_4t_ngspice

.ac dec 50 1 1e9

.control
run
set filetype=ascii
set wr_singlescale
set wr_vecnames
let vout_diff = v(bl)-v(blb)
let vout_cm = 0.5*(v(bl)+v(blb))
let gain_mag = mag(vout_diff)
let gain_db = 20*log10(gain_mag)
wrdata bitcell_4t_diff_ac.dat gain_mag gain_db vout_diff vout_cm v(bl) v(blb)
write bitcell_4t_diff_ac.raw
quit
.endc

.end
