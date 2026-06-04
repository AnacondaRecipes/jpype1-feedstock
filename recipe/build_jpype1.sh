#!/bin/bash

set -ex

# openjdk/ant live in BUILD_PREFIX; CMake cross-compile flags set PROGRAM search to NEVER.
export JAVA_HOME="${JAVA_HOME:-${BUILD_PREFIX}}"
export CMAKE_ARGS="${CMAKE_ARGS} -DANT_EXECUTABLE=${BUILD_PREFIX}/bin/ant -DJava_ROOT=${BUILD_PREFIX}"

# Upstream 1.7+ uses scikit-build-core (CMake); legacy setuptools build_ext flags no longer apply.
$PYTHON -m pip install . -vv --no-deps --no-build-isolation
