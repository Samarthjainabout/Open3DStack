#!/usr/bin/env sh
set -eu

ngspice -b -o preisach_fecap_ac_tb.log preisach_fecap_ac_tb.sp

printf '%s\n' \
  'Wrote:' \
  '  preisach_fecap_ac_tb.log' \
  '  preisach_fecap_ac_tb.dat' \
  '  preisach_fecap_ac_tb.raw'
