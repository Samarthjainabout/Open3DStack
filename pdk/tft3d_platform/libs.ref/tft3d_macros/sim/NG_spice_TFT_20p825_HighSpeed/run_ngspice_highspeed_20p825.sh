#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
ngspice -b -o highspeed_20p825_replay_ngspice.log highspeed_20p825_replay_ngspice.sp
printf 'Wrote %s, %s, and %s
'   "highspeed_20p825_replay_ngspice.log"   "highspeed_20p825_replay_ngspice.dat"   "highspeed_20p825_replay_ngspice.raw"
