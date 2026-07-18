* NAND3_X4RL_T5 measured-PWL ngspice model.
*
* Pin order follows pdk/tft3d_platform/libs.ref/tft3d_macros/spice/peripheral_ic_v2.spice:
*   a1 a2 a3 vdd vss y
*
* Data basis:
* - 25 C NAND pull-up diode and 3-TFT series pull-down measurements from
*   nand_test_170726.csv.
* - NAND pull-up diode current is scaled to Wpu ~= 0.75 mm.
* - Trap/contact/hysteresis dynamics are explicit surrogate terms constrained
*   around the measured PWL data. Static contact behavior remains embedded in
*   the measured PWL tables, so the RC terms below are small dynamic terms.
*
* Recommended operating point found from measured-PWL shmoo:
*   VDD = 2.0 V, VIL = 0 V, VIH = 4.25 V, Cload = 10 fF.
*
* Canonical subckts:
*   nand3_x4rl_t5_measured_ngspice         a1 a2 a3 vdd vss y
*   nand3_x4rl_t5_measured_ngspice_scaled  a1 a2 a3 vdd vss y pdscale
*
* The scaled variant multiplies each NAND pull-down branch by V(pdscale), which
* is useful for replaying measured pulse cycle-to-cycle ON/OFF variation.

.options reltol=1e-5 abstol=1e-15 vntol=1e-9 gmin=1e-15 method=gear

.param CMEM=1.000000000e-12
.param NAND_PD_SCALE=1

.param NAND_TAU_TRAP=6.000000000e-06
.param NAND_TAU_LAG=3.000000000e-06
.param NAND_MEM_FLOOR=0.08
.param NAND_MEM_TH=1.9
.param NAND_MEM_HYS=0.45
.param NAND_DIR_HYS=0.22
.param NAND_HYS_SLOPE=0.06
.param NAND_RCONTACT=5000
.param NAND_CCONTACT=5.000000000e-15

.param PU_TAU_TRAP=8.000000000e-06
.param PU_TAU_LAG=4.000000000e-06
.param PU_MEM_FLOOR=0.2
.param PU_MEM_TH=1.2
.param PU_MEM_HYS=0.3
.param PU_DIR_HYS=0.16
.param PU_HYS_SLOPE=0.06
.param PU_RCONTACT=2000
.param PU_CCONTACT=5.000000000e-15

.func ipu_nand(x) {pwl(x, -1, 0.000000000e+00, 0, 0.000000000e+00, 0.15, 4.875000000e-10, 0.3, 9.656250000e-10, 0.45, 1.653125000e-09, 0.6, 2.150000000e-09, 0.75, 2.959375000e-09, 0.9, 4.287500000e-09, 1.05, 5.743750000e-09, 1.2, 7.790625000e-09, 1.35, 1.020937500e-08, 1.5, 1.369687500e-08, 1.65, 1.799375000e-08, 1.8, 2.303437500e-08, 1.95, 2.966875000e-08, 2.1, 3.768437500e-08, 2.25, 4.709687500e-08, 2.4, 5.904062500e-08, 2.55, 7.298125000e-08, 2.7, 8.939687500e-08, 2.85, 1.087875000e-07, 3, 1.314218750e-07, 3.15, 1.579937500e-07, 3.3, 1.884125000e-07, 3.45, 2.238375000e-07, 3.6, 2.656781250e-07, 3.75, 3.123406250e-07, 3.9, 3.616875000e-07, 4.05, 4.164000000e-07, 4.2, 4.769593750e-07, 4.35, 5.436062500e-07, 4.5, 6.161250000e-07, 4.65, 6.949500000e-07, 4.8, 7.801656250e-07, 4.95, 8.702593750e-07, 5.1, 9.659781250e-07, 5.25, 1.066534375e-06, 5.4, 1.169059375e-06, 5.55, 1.271503125e-06, 5.7, 1.371056250e-06, 5.85, 1.462218750e-06, 6, 1.531556250e-06, 8, 1.531556250e-06)}
.func gpd_nand(x) {pwl(x, -8, 5.300000000e-11, -6, 5.300000000e-11, -5.838, 5.500000000e-11, -5.675, 5.500000000e-11, -5.513, 6.700000000e-11, -5.35, 6.700000000e-11, -5.187, 6.700000000e-11, -5.025, 6.700000000e-11, -4.862, 6.700000000e-11, -4.7, 6.700000000e-11, -4.537, 6.700000000e-11, -4.375, 6.700000000e-11, -4.213, 6.700000000e-11, -4.05, 6.700000000e-11, -3.888, 6.700000000e-11, -3.725, 6.700000000e-11, -3.562, 6.700000000e-11, -3.4, 6.700000000e-11, -3.237, 6.700000000e-11, -3.075, 6.700000000e-11, -2.913, 6.700000000e-11, -2.75, 6.700000000e-11, -2.587, 6.700000000e-11, -2.425, 6.700000000e-11, -2.263, 6.700000000e-11, -2.1, 6.700000000e-11, -1.937, 6.700000000e-11, -1.775, 6.700000000e-11, -1.613, 6.700000000e-11, -1.45, 6.700000000e-11, -1.288, 6.700000000e-11, -1.125, 6.700000000e-11, -0.963, 6.700000000e-11, -0.8, 6.700000000e-11, -0.637, 6.700000000e-11, -0.475, 6.700000000e-11, -0.312, 6.700000000e-11, -0.15, 6.700000000e-11, 0.013, 6.700000000e-11, 0.175, 6.700000000e-11, 0.338, 6.700000000e-11, 0.5, 6.700000000e-11, 0.662, 6.700000000e-11, 0.825, 6.700000000e-11, 0.988, 6.700000000e-11, 1.15, 6.700000000e-11, 1.312, 6.700000000e-11, 1.475, 6.700000000e-11, 1.637, 1.780000000e-10, 1.8, 6.320000000e-10, 1.962, 1.963000000e-09, 2.125, 3.677000000e-09, 2.288, 5.882000000e-09, 2.45, 8.158000000e-09, 2.612, 1.300600000e-08, 2.775, 1.458900000e-08, 2.937, 2.083500000e-08, 3.1, 2.741200000e-08, 3.263, 3.172900000e-08, 3.425, 3.345200000e-08, 3.587, 4.458000000e-08, 3.75, 4.682500000e-08, 3.913, 6.011700000e-08, 4.075, 6.783500000e-08, 4.237, 7.256000000e-08, 4.4, 8.000600000e-08, 4.562, 9.514200000e-08, 4.725, 1.089800000e-07, 4.888, 1.177660000e-07, 5.05, 1.272800000e-07, 5.213, 1.272800000e-07, 5.375, 1.272800000e-07, 5.537, 1.640700000e-07, 5.7, 1.640700000e-07, 5.862, 1.826280000e-07, 6.025, 1.826280000e-07, 6.187, 2.425300000e-07, 6.35, 2.425300000e-07, 6.513, 3.721100000e-07, 6.675, 3.777620000e-07, 6.838, 5.619520000e-07, 7, 5.619520000e-07, 8, 5.619520000e-07)}
.func memt(vg, vlag, th, vh, slope) {0.5*(1+tanh((vg-(th+vh*tanh((vg-vlag)/slope)))/slope))}
.func geff(vraw, vlag, vh, slope) {vraw-vh*tanh((vraw-vlag)/slope)}

.subckt ntft_nand_x4rl_t5_mem d g s
RCD d di {NAND_RCONTACT}
RCS si s {NAND_RCONTACT}
CCD di s {NAND_CCONTACT}
CCS si s {NAND_CCONTACT}
BGLAGDRV glagdrv 0 v={v(g,s)}
RGLAG glagdrv glag {NAND_TAU_LAG/CMEM}
CGLAG glag 0 {CMEM} ic=0
BMDRV mdrv 0 v={memt(v(g,s), v(glag), NAND_MEM_TH, NAND_MEM_HYS, NAND_HYS_SLOPE)}
RMEM mdrv mem {NAND_TAU_TRAP/CMEM}
CMEMNODE mem 0 {CMEM} ic=0
BCH di si i={NAND_PD_SCALE*(NAND_MEM_FLOOR+(1-NAND_MEM_FLOOR)*v(mem))*gpd_nand(geff(v(g,s), v(glag), NAND_DIR_HYS, NAND_HYS_SLOPE))*v(di,si)}
RDS di si 1e15
.ends ntft_nand_x4rl_t5_mem

.subckt ntft_nand_x4rl_t5_mem_scaled d g s pdscale
RCD d di {NAND_RCONTACT}
RCS si s {NAND_RCONTACT}
CCD di s {NAND_CCONTACT}
CCS si s {NAND_CCONTACT}
BGLAGDRV glagdrv 0 v={v(g,s)}
RGLAG glagdrv glag {NAND_TAU_LAG/CMEM}
CGLAG glag 0 {CMEM} ic=0
BMDRV mdrv 0 v={memt(v(g,s), v(glag), NAND_MEM_TH, NAND_MEM_HYS, NAND_HYS_SLOPE)}
RMEM mdrv mem {NAND_TAU_TRAP/CMEM}
CMEMNODE mem 0 {CMEM} ic=0
BCH di si i={v(pdscale)*(NAND_MEM_FLOOR+(1-NAND_MEM_FLOOR)*v(mem))*gpd_nand(geff(v(g,s), v(glag), NAND_DIR_HYS, NAND_HYS_SLOPE))*v(di,si)}
RDS di si 1e15
.ends ntft_nand_x4rl_t5_mem_scaled

.subckt diode_nand_x4rl_t5_wpu_mem vdd y
RCD vdd vd {PU_RCONTACT}
RCY yi y {PU_RCONTACT}
CVD vd y {PU_CCONTACT}
CYI yi y {PU_CCONTACT}
BVLAGDRV vlagdrv 0 v={v(vd,yi)}
RVLAG vlagdrv vlag {PU_TAU_LAG/CMEM}
CVLAG vlag 0 {CMEM} ic=0
BMDRV mdrv 0 v={memt(v(vd,yi), v(vlag), PU_MEM_TH, PU_MEM_HYS, PU_HYS_SLOPE)}
RMEM mdrv mem {PU_TAU_TRAP/CMEM}
CMEMNODE mem 0 {CMEM} ic=0
BPU vd yi i={(PU_MEM_FLOOR+(1-PU_MEM_FLOOR)*v(mem))*ipu_nand(geff(v(vd,yi), v(vlag), PU_DIR_HYS, PU_HYS_SLOPE))}
RPU vd yi 1e15
.ends diode_nand_x4rl_t5_wpu_mem

.subckt nand3_x4rl_t5_measured_ngspice a1 a2 a3 vdd vss y
XPU vdd y diode_nand_x4rl_t5_wpu_mem
XPD1 y a1 n1 ntft_nand_x4rl_t5_mem
XPD2 n1 a2 n2 ntft_nand_x4rl_t5_mem
XPD3 n2 a3 vss ntft_nand_x4rl_t5_mem
Rn1 n1 vss 1e14
Rn2 n2 vss 1e14
Cn1 n1 vss 5f
Cn2 n2 vss 5f
.ends nand3_x4rl_t5_measured_ngspice

.subckt nand3_x4rl_t5_measured_ngspice_scaled a1 a2 a3 vdd vss y pdscale
XPU vdd y diode_nand_x4rl_t5_wpu_mem
XPD1 y a1 n1 pdscale ntft_nand_x4rl_t5_mem_scaled
XPD2 n1 a2 n2 pdscale ntft_nand_x4rl_t5_mem_scaled
XPD3 n2 a3 vss pdscale ntft_nand_x4rl_t5_mem_scaled
Rn1 n1 vss 1e14
Rn2 n2 vss 1e14
Cn1 n1 vss 5f
Cn2 n2 vss 5f
.ends nand3_x4rl_t5_measured_ngspice_scaled

* Compatibility alias used by earlier measured-analysis decks.
.subckt nand3_measured_memory a1 a2 a3 vdd vss y
X0 a1 a2 a3 vdd vss y nand3_x4rl_t5_measured_ngspice
.ends nand3_measured_memory
