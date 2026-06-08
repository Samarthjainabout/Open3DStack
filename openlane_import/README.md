# 3D_TFT OpenLane Import Views

This folder contains the OpenLane-facing views for the 3D_TFT layout blocks.

## Contents

- `gds/`: extracted source-layout GDS files.
- `gds_platform/`: GDS files remapped to the neutral platform layer numbers.
- `lef/`: LEF abstracts using FreePDK45-style layer names.
- `lef_platform/`: LEF abstracts using neutral platform layer names.
- `lib/3d_tft_placeholders.lib`: Liberty placeholders for OpenLane/OpenSTA loading.
- `src/3d_tft_blackboxes.v`: Verilog black-box modules for synthesis/elaboration.
- `spice/3d_tft_macros.spice`: basic SPICE placeholders for the imported hard macros.
- `metadata/cells.json`: size and placeholder-port metadata for the available cells.
- `reports/gds_audit.txt`: audited top cells, dimensions, layers, child refs, and label status.
- `tech/freepdk45.layermap`: retained source-layout layer map.
- `tech/freepdk45.def2gds.map`: OpenLane/KLayout DEF-to-GDS map for FreePDK45-numbered stream-out.
- `config.tcl.example`: snippet for importing these blocks into another OpenLane design.

## Limitation

The available GDS files do not contain named pin labels. The LEF pin shapes,
Verilog port lists, Liberty timing, and SPICE macro views are placeholders for
OpenLane integration and basic circuit bring-up only. Replace them with
authoritative pin-labeled and extracted views before signoff or LVS.
