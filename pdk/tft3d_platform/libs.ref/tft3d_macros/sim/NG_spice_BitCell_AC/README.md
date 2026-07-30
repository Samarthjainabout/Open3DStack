# NG_spice_BitCell_AC

This folder runs a stock-ngspice AC frequency response for the local
cross-coupled 4T FeTFT/TFT bitcell.

Derivation/provenance:

- The bitcell topology is copied from the local generated HSPICE netlist
  `../../spice/peripheral_ic_v2.spice`, cell `BitCell`.
- The access TFT and FeTFT primitives are mapped to the repo's native-ngspice
  V2 conductance-table includes in `../NG_spice_TFT_V2` and
  `../NG_spice_FeTFT_V2`.
- The earlier Preisach FeCAP/PFECAP model work in `../NG_spice_Preisach_FeCAP`
  is derived from Ni/Jerry/Smith/Datta's 2018 FeFET paper and the public
  `supadupaplex/pfecap` Verilog-A model. That PFECAP repository cites the
  paper, but it is not the authors' original released simulator.

The simulated cell topology is copied from
`../../spice/peripheral_ic_v2.spice`:

- two access TFTs from `BL/BLB` to the internal storage nodes,
- two cross-coupled FeTFTs from those internal nodes to `SL/SLB`,
- 2 pF capacitors on `SL` and `SLB`.

The original generated SPICE uses HSPICE `.hdl` Verilog-A device models. For
local ngspice, `bitcell_4t_ac_ngspice.inc` maps those primitive names onto the
repo's native-ngspice V2 TFT/FeTFT conductance-table models.

The AC deck freezes the stored state as:

- left FeTFT: `pinit=1` / LVT,
- right FeTFT: `pinit=0` / HVT.

It then measures the differential small-signal read/search transfer:

```text
gain(f) = (V(BL)-V(BLB)) / (V(SL)-V(SLB))
```

with `V(SL)-V(SLB) = 1 V AC`, `WL = 3 V`, and `Cbl = Cblb = 2 pF`.

Model limitations:

- AC analysis is small-signal only; it linearizes around the frozen stored
  state and does not simulate write/program pulses.
- The FeTFT states are fixed as LVT/HVT. No Preisach minor-loop history,
  partial polarization, or transient ferroelectric switching is included here.
- The deck measures the isolated cell with ideal SL/SLB drive, ideal WL bias,
  and simple bitline capacitors. It does not include column drivers,
  precharge/equalization, muxes, or the sense amplifier.
- This is not the full paper-level FeFET solver. It does not solve
  `QMOS(VMOS)=QFE(VFE)` with BSIM4 voltage division.

Run:

```sh
cd pdk/tft3d_platform/libs.ref/tft3d_macros/sim/NG_spice_BitCell_AC
./run_ngspice_bitcell_ac.sh
```

Outputs:

- `bitcell_4t_diff_ac.dat`: frequency, gain magnitude, gain dB, differential
  output, common-mode output, BL, and BLB.
- `bitcell_4t_diff_ac.raw`: ngspice raw output.
- `bitcell_4t_diff_ac.log`: ngspice run log.

Current result with the default deck:

- low-frequency differential gain: approximately 1 V/V,
- -3 dB frequency: approximately 0.78 MHz,
- gain at 1 MHz: approximately -4.20 dB.
