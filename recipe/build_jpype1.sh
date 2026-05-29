#!/bin/bash

set -ex

# openjdk/ant live in BUILD_PREFIX; CMake cross-compile flags set PROGRAM search to NEVER.
export JAVA_HOME="${JAVA_HOME:-${BUILD_PREFIX}}"
export CMAKE_ARGS="${CMAKE_ARGS} -DANT_EXECUTABLE=${BUILD_PREFIX}/bin/ant -DJava_ROOT=${BUILD_PREFIX}"

# ant is not on defaults for osx-arm64; use jar built from upstream v1.7.1 native/build.xml.
if [[ "${target_platform}" == "osx-arm64" ]]; then
  mkdir -p "${SRC_DIR}/native/build/lib"
  cp "${RECIPE_DIR}/org.jpype.jar" "${SRC_DIR}/native/build/lib/"
  export CMAKE_ARGS="${CMAKE_ARGS} -DENABLE_BUILD_JAR=OFF -DBUILD_TEST_HARNESS=OFF"
fi

# Upstream 1.7+ uses scikit-build-core (CMake); legacy setuptools build_ext flags no longer apply.
$PYTHON -m pip install . -vv --no-deps --no-build-isolation

if [[ "${target_platform}" == "osx-arm64" ]]; then
  cp "${RECIPE_DIR}/org.jpype.jar" "${SP_DIR}/org.jpype.jar"
fi
