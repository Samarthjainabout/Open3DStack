# NG_spice_Preisach_FeCAP

This folder contains a stock-ngspice AC check for the ferroelectric capacitor
portion of a Preisach FeFET model. The equations are derived from the FE
saturation-loop and switching-delay blocks described by Ni, Jerry, Smith, and
Datta in "A Circuit Compatible Accurate Compact Model for Ferroelectric-FETs"
(2018), and were cross-checked against the public PFECAP Verilog-A repository
by Alexey Leushin.

The PFECAP repository cites the Ni/Jerry/Smith/Datta paper, but it is not the
authors' original released simulator. The PDF itself does not name
ngspice/HSPICE/Spectre as the implementation target; it describes BSIM4 plus a
Preisach FE block "implemented by solver."

What is included:

- `preisach_fecap_major_loop_ngspice.inc`: native ngspice behavioral helper for
  the paper's FE major-loop saturation equation, RC switching-delay unit, and
  AC-linearized branch admittance.
- `preisach_fecap_ac_tb.sp`: a small-signal AC admittance testbench around one
  selected FE major-loop branch.
- `run_ngspice_preisach_fecap.sh`: convenience runner.

## Comparison With Existing Models

| Model | Where | What it represents | Best use | What it lacks |
| --- | --- | --- | --- | --- |
| Existing lookup-table FeTFT/FeFET model | `../NG_spice_FeTFT_V2/fetft_nf1_nf2_vds0p1_ngspice_V2.inc` | A frozen HVT/LVT device state selected from measured/interpolated conductance tables | Id-Vg checks, LVT/HVT read-current estimates, and bitcell AC with fixed stored states | Ferroelectric polarization physics, Preisach history, partial switching, program/erase dynamics, and FE capacitance/admittance |
| New Preisach FeCAP AC model | `preisach_fecap_major_loop_ngspice.inc` and `preisach_fecap_ac_tb.sp` | The ferroelectric capacitor block only, linearized around one selected major-loop branch | FE small-signal capacitance/admittance versus frequency | MOSFET channel current, Id-Vg curves, threshold shift, memory window, BSIM4 charge coupling, and minor-loop turning-point history |
| Full paper-level FeFET solver | Not present in this repo | BSIM4 MOSFET charge coupled self-consistently to Preisach FE charge using `QMOS(VMOS)=QFE(VFE)` and `VGS=VMOS+VFE` | Program/read prediction, memory-window simulation, history-aware FeFET behavior | Requires a charge-aware MOSFET wrapper, calibrated parameters, and the unpublished/unspecified solver flow |

The lookup-table model and the new FeCAP model answer different questions. The
lookup-table model behaves like a read-current model for an already-programmed
FeTFT. The FeCAP model behaves like a ferroelectric admittance model. Neither
one alone is the complete FeFET compact model from the paper.

Model limitations:

- Missing the full paper FeFET solver. The paper couples this FE block to a BSIM4
  MOSFET by solving `QMOS(VMOS)=QFE(VFE)` and `VGS=VMOS+VFE`.
- Missing the full turning-point stack for Preisach minor loops. This deck
  explicitly selects the rising or falling major-loop branch with the `branch`
  pin.
- Missing the authors' original simulator and calibrated 10 nm HZO/FeFET
  parameter set. The PDF does not name a released simulator or provide a
  netlist.
- AC analysis is a small-signal linearization around the chosen DC bias and
  selected branch. It does not switch polarization state, traverse minor loops,
  or predict a full FeFET Id-Vg memory window.

Run:

```sh
cd pdk/tft3d_platform/libs.ref/tft3d_macros/sim/NG_spice_Preisach_FeCAP
./run_ngspice_preisach_fecap.sh
```

Outputs:

- `preisach_fecap_ac_tb.dat`: AC frequency table with input admittance,
  effective capacitance from `imag(Yin)/omega`, VFE, and FE-source current.
- `preisach_fecap_ac_tb.raw`: AC ngspice raw output.
- `preisach_fecap_ac_tb.log`: AC ngspice run log.

Current AC result with the default deck (`Vbias=1 V`, rising branch,
`area=25 um^2`):

- low-frequency effective capacitance: approximately 13.16 pF,
- effective capacitance at 1 GHz: approximately 0.616 pF,
- -3 dB capacitance rolloff: approximately 77.5 MHz.

For a full FeFET implementation in ngspice, use this FE helper as the starting
point, then add either a charge-output BSIM4 wrapper or an OSDI/OpenVAF
Verilog-A path for a model such as the public PFECAP implementation.

References:

- K. Ni, M. Jerry, J. A. Smith, and S. Datta, "A Circuit Compatible Accurate
  Compact Model for Ferroelectric-FETs," 2018 IEEE Symposium on VLSI
  Technology, DOI: `10.1109/VLSIT.2018.8510622`.
- Alexey Leushin, `supadupaplex/pfecap`, "Verilog-A Preisach ferroelectric cap
  (PFECAP) simulation model for FET", https://github.com/supadupaplex/pfecap.
