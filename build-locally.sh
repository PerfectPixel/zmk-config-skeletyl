#!/usr/bin/env bash

set -euxo pipefail

build_and_copy () {
    local side=$1
    west build \
        -b nice_nano_v2 -- \
        -DSHIELD=skeletyl_$side \
        -DZMK_CONFIG="$CONFIG_DIR"

    cp "./build/zephyr/zmk.uf2" "$CURRENT_DIR/build/skeletyl_$side.uf2"
}

CURRENT_DIR="$(pwd)"
CONFIG_DIR="$(pwd)/config"

DEFAULTZMKAPPDIR="$HOME/zmk/app"
ZMK_APP_DIR="${1:-$DEFAULTZMKAPPDIR}"

mkdir -p "$CURRENT_DIR/build"

pushd "$ZMK_APP_DIR"

build_and_copy left
build_and_copy right

popd
