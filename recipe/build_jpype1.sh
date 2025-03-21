#!/bin/bash

set -ex

$PYTHON -m pip install . \
    -vv \
    --no-deps \
    --no-build-isolation \
    -C--global-option=build_ext \
    -C--global-option="--enable-build-jar" \
    -C--global-option="--enable-tracing"
