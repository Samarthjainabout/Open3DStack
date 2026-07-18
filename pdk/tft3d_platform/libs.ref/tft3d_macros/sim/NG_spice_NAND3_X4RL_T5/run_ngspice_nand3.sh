#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
ngspice -b -o nand3_x4rl_t5_measured_ngspice_tb.log nand3_x4rl_t5_measured_ngspice_tb.sp
