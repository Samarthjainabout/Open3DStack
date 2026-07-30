#!/usr/bin/env sh
set -eu

ngspice -b -o bitcell_4t_diff_ac.log bitcell_4t_diff_ac.sp

printf '%s\n' \
  'Wrote:' \
  '  bitcell_4t_diff_ac.log' \
  '  bitcell_4t_diff_ac.dat' \
  '  bitcell_4t_diff_ac.raw'
