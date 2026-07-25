* Layer 1 FeTFT V2 Id-Vg remote ngspice validation deck.
* Uses V=Id probe nodes for the generated HVT/LVT PWL functions at Vd=0.1 V.
.include "fetft_nf1_nf2_vds0p1_ngspice_V2.inc"

Vgsrc vg 0 dc=0
Bid_nf1_hvt id_nf1_hvt 0 V={0.1*fetft_g_nf1_hvt_vds0p1_v2(V(vg))}
Bid_nf1_lvt id_nf1_lvt 0 V={0.1*fetft_g_nf1_lvt_vds0p1_v2(V(vg))}
Bid_nf2_hvt id_nf2_hvt 0 V={0.1*fetft_g_nf2_hvt_vds0p1_v2(V(vg))}
Bid_nf2_lvt id_nf2_lvt 0 V={0.1*fetft_g_nf2_lvt_vds0p1_v2(V(vg))}

.dc Vgsrc -5.5 5.5 0.1
.print dc v(vg) v(id_nf1_hvt) v(id_nf1_lvt) v(id_nf2_hvt) v(id_nf2_lvt)

.control
run
set filetype=ascii
set wr_singlescale
set wr_vecnames
wrdata id_vg_fetft_nf1_nf2_ngspice_V2.dat v(vg) v(id_nf1_hvt) v(id_nf1_lvt) v(id_nf2_hvt) v(id_nf2_lvt)
write id_vg_fetft_nf1_nf2_ngspice_V2.raw
.endc

.end
