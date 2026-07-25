* Layer 2 TFT native ngspice V2 model generated from measured Id-Vg data.
* Source workbook: experimental_idvg_data_N1_N2_Layer2.xlsx.
* Vd = 0.1 V. PWL tables store conductance G = mean(Forward, Reverse Id) / 0.1 V.
* Pin order follows the original Verilog-A model: d s g.

.func tft_g_n1_v2(vg) {pwl(vg,
+ -4, 4.5e-11,
+ -3.8, 4.05e-11,
+ -3.6, 2.75e-11,
+ -3.4, 2.7e-11,
+ -3.2, 2.9e-11,
+ -3, 2.7e-11,
+ -2.8, 1.9e-11,
+ -2.6, 1.45e-11,
+ -2.4, 7.5e-12,
+ -2.2, 1.45e-11,
+ -2, 2.05e-11,
+ -1.8, 1.55e-11,
+ -1.6, 1.1e-11,
+ -1.4, 9.5e-12,
+ -1.2, 9.5e-12,
+ -1, 7e-12,
+ -0.8, 5e-12,
+ -0.6, 1.15e-11,
+ -0.4, 1.05e-11,
+ -0.2, 1.05e-11,
+ 0, 1.8e-11,
+ 0.2, 1.65e-11,
+ 0.4, 7e-11,
+ 0.6, 7.815e-10,
+ 0.8, 4.171e-9,
+ 1, 1.3619e-8,
+ 1.2, 3.41845e-8,
+ 1.4, 7.7581e-8,
+ 1.6, 1.80349e-7,
+ 1.8, 4.47744e-7,
+ 2, 1.03435e-6,
+ 2.2, 2.0932e-6,
+ 2.4, 3.6849e-6,
+ 2.6, 5.8092e-6,
+ 2.8, 8.4249e-6,
+ 3, 1.14275e-5,
+ 3.2, 1.4836e-5,
+ 3.4, 1.85155e-5,
+ 3.6, 2.2414e-5,
+ 3.8, 2.64765e-5,
+ 4, 3.06545e-5)}

.func tft_g_n2_v2(vg) {pwl(vg,
+ -4, 4.05e-11,
+ -3.8, 3.25e-11,
+ -3.6, 2.75e-11,
+ -3.4, 3.05e-11,
+ -3.2, 2.65e-11,
+ -3, 1.5e-11,
+ -2.8, 1.75e-11,
+ -2.6, 1.15e-11,
+ -2.4, 9.5e-12,
+ -2.2, 4e-12,
+ -2, 9.5e-12,
+ -1.8, 6.5e-12,
+ -1.6, 1e-12,
+ -1.4, 1.15e-11,
+ -1.2, 1.25e-11,
+ -1, 6e-12,
+ -0.8, 3.5e-12,
+ -0.6, 2e-12,
+ -0.4, 4e-12,
+ -0.2, 4.5e-12,
+ 0, 7e-12,
+ 0.2, 2.5e-12,
+ 0.4, 3.2e-11,
+ 0.6, 5.78e-10,
+ 0.8, 3.671e-9,
+ 1, 1.2662e-8,
+ 1.2, 3.27465e-8,
+ 1.4, 7.50555e-8,
+ 1.6, 1.77179e-7,
+ 1.8, 4.46021e-7,
+ 2, 1.045109e-6,
+ 2.2, 2.1213e-6,
+ 2.4, 3.7393e-6,
+ 2.6, 5.8898e-6,
+ 2.8, 8.5324e-6,
+ 3, 1.1566e-5,
+ 3.2, 1.49925e-5,
+ 3.4, 1.86875e-5,
+ 3.6, 2.2595e-5,
+ 3.8, 2.66455e-5,
+ 4, 3.08195e-5)}

.subckt tft_n1_ngspice_v2 d s g w=8e-6 l=3e-6 m=1
Bch d s I={m*(w/8e-6)*(3e-6/l)*V(d,s)*tft_g_n1_v2(((V(s)<V(d)) ? V(g,s) : V(g,d)))}
.ends tft_n1_ngspice_v2

.subckt tft_n2_ngspice_v2 d s g w=8e-6 l=3e-6 m=1
Bch d s I={m*(w/8e-6)*(3e-6/l)*V(d,s)*tft_g_n2_v2(((V(s)<V(d)) ? V(g,s) : V(g,d)))}
.ends tft_n2_ngspice_v2

* Macro pin-order wrappers use d g s and the N1 V2 measured table by default.
.subckt nfet_w6u_l5_v2 d g s l=5e-6 w=6e-6 m=1
X0 d s g tft_n1_ngspice_v2 w={w} l={l} m={m}
.ends nfet_w6u_l5_v2

.subckt nfet_w20p825_l5_v2 d g s l=5e-6 w=20.825e-6 m=1
X0 d s g tft_n1_ngspice_v2 w={w} l={l} m={m}
.ends nfet_w20p825_l5_v2

.subckt nfet_w24u_l5_v2 d g s l=5e-6 w=24e-6 m=1
X0 d s g tft_n1_ngspice_v2 w={w} l={l} m={m}
.ends nfet_w24u_l5_v2
