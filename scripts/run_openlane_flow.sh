#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
openlane_root=${OPENLANE_ROOT:-$HOME/OpenLane}
design_dir=${OPENLANE_DESIGN_DIR:-"$repo_root/openlane/tft3d_macro_layout"}
tag=${OPENLANE_TAG:-layout}
extra_args=${OPENLANE_EXTRA_ARGS:--no_lvs -no_drc -no_antennacheck}

if [[ "$design_dir" != /* ]]; then
    design_dir="$repo_root/$design_dir"
fi

require_file() {
    if [[ ! -f "$1" ]]; then
        echo "missing required file: $1" >&2
        exit 1
    fi
}

require_glob() {
    local pattern=$1
    local matches=()
    shopt -s nullglob
    matches=($pattern)
    shopt -u nullglob
    if (( ${#matches[@]} == 0 )); then
        echo "missing required files matching: $pattern" >&2
        exit 1
    fi
}

require_file "$design_dir/config.tcl"
require_file "$repo_root/pdk/tft3d_platform/libs.tech/openlane/config.tcl"
require_file "$repo_root/pdk/tft3d_platform/libs.tech/openlane/tft3d_sc_t5/config.tcl"
require_file "$repo_root/pdk/tft3d_platform/libs.ref/tft3d_sc_t5/techlef/tft3d_platform.tlef"
require_file "$repo_root/openlane_import/src/3d_tft_blackboxes.v"
require_file "$repo_root/openlane_import/lib/3d_tft_placeholders.lib"
require_file "$repo_root/openlane_import/spice/3d_tft_macros.spice"
require_file "$repo_root/pdk/tft3d_platform/libs.tech/ngspice/tft3d_platform.spice"
require_glob "$repo_root/openlane_import/lef_platform/*.lef"
require_glob "$repo_root/openlane_import/gds_platform/*.gds"

export PDK_ROOT="${PDK_ROOT:-$repo_root/pdk}"
export PDK="${PDK:-tft3d_platform}"
export STD_CELL_LIBRARY="${STD_CELL_LIBRARY:-tft3d_sc_t5}"

if [[ -x /openlane/flow.tcl ]]; then
    cd /openlane
    # shellcheck disable=SC2086
    exec ./flow.tcl -design "$design_dir" -tag "$tag" -overwrite $extra_args
fi

if [[ ! -d "$openlane_root" ]]; then
    echo "OPENLANE_ROOT does not exist: $openlane_root" >&2
    exit 1
fi

image_tag=$(cd "$openlane_root" && python3 dependencies/get_tag.py)
platform=$(cd "$openlane_root" && python3 docker/current_platform.py)
image=${OPENLANE_IMAGE:-ghcr.io/the-openroad-project/openlane:${image_tag}-${platform}}

cd "$openlane_root"
exec docker run --rm \
    -v "$openlane_root:/openlane" \
    -v "$openlane_root/designs:/openlane/install" \
    -v "$HOME:$HOME" \
    -e PDK_ROOT="$PDK_ROOT" \
    -e PDK="$PDK" \
    -e STD_CELL_LIBRARY="$STD_CELL_LIBRARY" \
    --user "$(id -u):$(id -g)" \
    "$image" \
    bash -lc "cd /openlane && ./flow.tcl -design '$design_dir' -tag '$tag' -overwrite $extra_args"
