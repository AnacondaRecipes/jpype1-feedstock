#!/bin/bash

set -ex

# Upstream 1.7+ uses scikit-build-core (CMake); legacy setuptools build_ext flags no longer apply.
$PYTHON -m pip install . -vv --no-deps --no-build-isolation
