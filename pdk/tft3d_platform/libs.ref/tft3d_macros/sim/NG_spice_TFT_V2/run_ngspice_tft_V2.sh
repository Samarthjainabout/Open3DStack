#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
ngspice -b -o id_vg_tft_n1_n2_ngspice_V2.log id_vg_tft_n1_n2_ngspice_V2.sp
printf 'Wrote %s, %s, and %s
' \
  "id_vg_tft_n1_n2_ngspice_V2.log" \
  "id_vg_tft_n1_n2_ngspice_V2.dat" \
  "id_vg_tft_n1_n2_ngspice_V2.raw"
