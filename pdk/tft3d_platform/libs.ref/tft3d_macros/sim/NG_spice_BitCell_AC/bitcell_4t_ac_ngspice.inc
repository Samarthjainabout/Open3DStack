* Stock-ngspice 4T cross-coupled FeTFT/TFT bitcell include.
*
* Topology copied from:
*   ../../spice/peripheral_ic_v2.spice, subckt bitcell
*
* Device behavior maps the original HSPICE/Verilog-A primitive names to the
* local native-ngspice V2 TFT and FeTFT conductance-table models.

.include "../NG_spice_TFT_V2/tft_n1_n2_ngspice_V2.inc"
.include "../NG_spice_FeTFT_V2/fetft_nf1_nf2_vds0p1_ngspice_V2.inc"

.subckt tft_n1 d s g w=8e-6 l=3e-6 m=1
X0 d s g tft_n1_ngspice_v2 w={w} l={l} m={m}
.ends tft_n1

.subckt tft_n2 d s g w=8e-6 l=3e-6 m=1
X0 d s g tft_n2_ngspice_v2 w={w} l={l} m={m}
.ends tft_n2

* AC analysis linearizes around the DC operating point. Freeze the FeTFT state
* from pinit instead of relying on transient polarization ICs.
.subckt fetft_nf1_debug g d s p pinit=1 scale=1 hvt_vshift=0 lvt_vshift=0 hvt_scale=1 lvt_scale=1 hvt_tilt=0 lvt_tilt=0
Bvgeff vgeff 0 V={((V(s)<V(d)) ? V(g,s) : V(g,d))}
Bghvt ghvt 0 V={hvt_scale*(1+hvt_tilt*V(vgeff)/5.5)*fetft_g_nf1_hvt_vds0p1_v2(V(vgeff)-hvt_vshift)}
Bglvt glvt 0 V={lvt_scale*(1+lvt_tilt*V(vgeff)/5.5)*fetft_g_nf1_lvt_vds0p1_v2(V(vgeff)-lvt_vshift)}
Bp p 0 V={pinit}
Bch d s I={scale*V(d,s)*((pinit>0.5) ? V(glvt) : V(ghvt))}
.ends fetft_nf1_debug

.subckt fetft_nf2_debug g d s p pinit=0 scale=1 hvt_vshift=0 lvt_vshift=0 hvt_scale=1 lvt_scale=1 hvt_tilt=0 lvt_tilt=0
Bvgeff vgeff 0 V={((V(s)<V(d)) ? V(g,s) : V(g,d))}
Bghvt ghvt 0 V={hvt_scale*(1+hvt_tilt*V(vgeff)/5.5)*fetft_g_nf2_hvt_vds0p1_v2(V(vgeff)-hvt_vshift)}
Bglvt glvt 0 V={lvt_scale*(1+lvt_tilt*V(vgeff)/5.5)*fetft_g_nf2_lvt_vds0p1_v2(V(vgeff)-lvt_vshift)}
Bp p 0 V={pinit}
Bch d s I={scale*V(d,s)*((pinit>0.5) ? V(glvt) : V(ghvt))}
.ends fetft_nf2_debug

.subckt bitcell_4t_ngspice bl blb p_nf1 p_nf2 sl slb wl
Cslb slb 0 2p
Csl sl 0 2p
Xacc_l bl net011 wl tft_n1
Xacc_r blb net025 wl tft_n2
Xfe_r net011 net025 slb p_nf2 fetft_nf2_debug pinit=0
Xfe_l net025 net011 sl p_nf1 fetft_nf1_debug pinit=1
.ends bitcell_4t_ngspice
