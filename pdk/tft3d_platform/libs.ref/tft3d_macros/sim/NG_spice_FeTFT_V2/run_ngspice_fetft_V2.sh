#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
ngspice -b -o id_vg_fetft_nf1_nf2_ngspice_V2.log id_vg_fetft_nf1_nf2_ngspice_V2.sp
printf 'Wrote %s, %s, and %s
' \
  "id_vg_fetft_nf1_nf2_ngspice_V2.log" \
  "id_vg_fetft_nf1_nf2_ngspice_V2.dat" \
  "id_vg_fetft_nf1_nf2_ngspice_V2.raw"
