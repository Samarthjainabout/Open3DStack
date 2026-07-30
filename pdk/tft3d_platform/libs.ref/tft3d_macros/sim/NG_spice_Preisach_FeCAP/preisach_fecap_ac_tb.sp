Preisach FeCAP small-signal AC admittance check - stock ngspice

.include "preisach_fecap_major_loop_ngspice.inc"

.options method=gear maxord=2 reltol=1e-5 abstol=1e-14 chgtol=1e-16
.param AcVbias=1
.param AcBranch=1
.param AcArea=25e-12
.temp 27

* AC analysis linearizes the selected FE branch around this DC bias.
Vfe fe 0 DC {AcVbias} AC 1

Xfe_ac fe 0 preisach_fecap_branch_ac_ngspice
+ tfe=10n epsfe_r=20 qs=0.32 vc=1.05 slope=1.6 area={AcArea}
+ tau_inf=1n v0=0.55 tau_m=2 vfloor=50m vbias={AcVbias} branch={AcBranch}

.ac dec 50 1 1e9

.control
run
set filetype=ascii
set wr_singlescale
set wr_vecnames
let yin = -i(vfe)/v(fe)
let ymag = mag(yin)
let cap_eff = imag(yin)/(2*3.141592653589793*frequency)
wrdata preisach_fecap_ac_tb.dat ymag cap_eff yin v(fe) i(vfe)
write preisach_fecap_ac_tb.raw
quit
.endc

.end
