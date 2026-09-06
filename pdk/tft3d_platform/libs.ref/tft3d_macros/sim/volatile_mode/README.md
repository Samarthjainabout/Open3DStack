# FeTFT DRAM-Like Dynamic Cell Simulink Model

This folder contains MATLAB/Simulink models for the 2T-2FeTFT DRAM-like dynamic-cell concept described in the reference document `FeTFT_DRAM_Like_Dynamic_Cell_Concept_and_Transfer_Function.docx`.

It is located in `tft3d_macros/sim/volatile_mode` so it can live alongside the existing TFT HSPICE and ngspice simulation assets without mixing generated volatile-mode files into the top-level `sim` folder.

The model is intentionally circuit-level and compact. It is not a replacement for the FeTFT Verilog-A/HSPICE device model. Its purpose is to make the proposed transfer-function assumptions executable and easy to sweep.

The NLS/detrapping retention mechanism is adapted from F. Mo et al., "Efficient Erase Operation by GIDL Current for 3D Structure FeFETs With Gate Stack Engineering and Compact Long-Term Retention Model," IEEE Journal of the Electron Devices Society, vol. 10, pp. 115-122, 2022, doi: 10.1109/JEDS.2022.3142046.

## Source References Used

- `FeTFT_DRAM_Like_Dynamic_Cell_Concept_and_Transfer_Function.docx`: source for the 2T-2FeTFT bitcell topology, branch transfer functions, loop-gain condition, write/hold/read operating sequence, and retention-margin equation.
- F. Mo et al., "Efficient Erase Operation by GIDL Current for 3D Structure FeFETs With Gate Stack Engineering and Compact Long-Term Retention Model," IEEE Journal of the Electron Devices Society, vol. 10, pp. 115-122, 2022, doi: `10.1109/JEDS.2022.3142046`: source for the NLS-style time-dependent depolarization/back-switching retention mechanism and charge-detrapping acceleration concept.

## Files

- `build_fetft_dynamic_cell_model.m`: creates the Simulink model, sets simulation parameters, optionally runs the transient simulation, and saves results.
- `build_fetft_transfer_function_diagram.m`: creates a Simulink transfer-function block diagram for the cross-coupled FeTFT branches.
- `fetft_cell_vector.m`: equation helper called by the generated Simulink model.
- `run_fetft_dynamic_cell_equations.py`: runs the same equations without MATLAB/Simulink for license-independent validation.
- `fetft_dram_like_dynamic_cell.slx`: generated Simulink model. Rebuild it by rerunning the MATLAB script.
- `fetft_transfer_function_block_diagram.slx`: generated transfer-function block-diagram model.
- `fetft_transfer_function_block_diagram.png`: exported image of the transfer-function block diagram.
- `fetft_transfer_function_results.mat`: generated transfer-function diagram simulation output.
- `fetft_dynamic_cell_results.mat`: generated simulation output when the script is run.
- `fetft_dynamic_cell_response.png`: generated plot of differential polarization, differential output voltage, and read margin.
- `fetft_dynamic_cell_equation_results.csv`: generated Python fallback output.
- `fetft_dynamic_cell_equation_response.png`: generated Python fallback plot when `matplotlib` is available.
- `fetft_dynamic_cell_equation_response.svg`: generated dependency-free fallback plot when `matplotlib` is not available.

## Modeled Equations

The stored state is normalized differential polarization:

```text
dP = P17 - P18 = P_NF2 - P_NF1
P17 = P_EQ + dP/2
P18 = P_EQ - dP/2
```

The WRITE phase creates a partial polarization difference:

```text
dP(t) = dP0 * (1 - exp(-t/tauWrite))
```

The HOLD and READ phases use an effective NLS-style depolarization/back-switching law based on the retention-model paper. The paper models retention by repeatedly updating the ferroelectric voltage and applying field-dependent NLS depolarization over short time steps. In this cell-level model, that mechanism is reduced to the stored differential polarization state:

```text
dP(t) = dP_write_end * exp(-Atrap(t) * ((t - tWrite)/tauNLS)^betaRetention)
Atrap(t) = 1 + trapAccel * (1 - exp(-(t - tWrite)/tauTrap))
```

This is not a full FeFET compact model. It is only an equivalent time-dependent state-decay mechanism for relaxation/back-switching/depolarization. The optional `Atrap(t)` multiplier captures the paper's observation that charge detrapping can accelerate retention degradation.

The symmetric gain-cell approximation is represented as:

```text
DeltaV_Q = Gp * dP
Gp = B / (1 - a)
```

Here `a` is the effective regenerative factor, kept below one in every phase. `aHold` demonstrates the required `|L_FE(0)| < 1` hold condition. `aRead` is closer to one, representing `|L_FE(0)| -> 1-` for read amplification.

The retention estimate follows the reference margin equation:

```text
tR ~= tauNLS * [ln(Gp_read * |dP0| / V_MIN)]^(1/betaRetention)
```

The script computes this with the actual post-write `dP_write_end`.

## Default Demonstration Parameters

The defaults are normalized, illustrative values chosen to show the intended behavior:

- Write duration: `2 us`
- Read starts at: `22 us`
- Effective NLS retention time scale: `11 us`
- NLS shape factor: `betaRetention = 0.62`
- Detrapping acceleration: `trapAccel = 0.18`
- Detrapping time scale: `tauTrap = 25 us`
- Hold regenerative factor: `aHold = 0.35`
- Read regenerative factor: `aRead = 0.88`
- Read conversion coefficient: `bRead = 0.12 V`
- Sense threshold: `V_MIN = 0.12 V`

These are placeholders until extracted from FeTFT Verilog-A/HSPICE characterization.

## How To Run

From MATLAB:

```matlab
cd('D:\gitt\Open3DStack\pdk\tft3d_platform\libs.ref\tft3d_macros\sim\volatile_mode')
build_fetft_dynamic_cell_model
open_system('fetft_dram_like_dynamic_cell')
```

To rebuild the `.slx` without running the simulation:

```matlab
build_fetft_dynamic_cell_model(false)
```

To create the transfer-function block diagram:

```matlab
build_fetft_transfer_function_diagram
open_system('fetft_transfer_function_block_diagram')
```

If MATLAB licensing is unavailable, run the equation-level fallback from PowerShell:

```powershell
python D:\gitt\Open3DStack\pdk\tft3d_platform\libs.ref\tft3d_macros\sim\volatile_mode\run_fetft_dynamic_cell_equations.py
```

## Expected Output

The simulation should show:

- During WRITE, `dP` rises toward a partial differential polarization state.
- During HOLD, `dP` follows stretched-exponential NLS-style depolarization/back-switching.
- During READ, `DeltaV_Q` is amplified by the larger read gain while the loop gain remains below unity.
- `senseMargin` becomes negative when the remaining differential polarization can no longer support the chosen `V_MIN`.

The important causality check is that `DeltaV_Q` follows `dP`. If a future detailed circuit simulation shows `Q - Qbar` decaying while `P_NF2 - P_NF1` does not, the decay is likely electrical/RC-driven rather than ferroelectric-polarization-driven.
