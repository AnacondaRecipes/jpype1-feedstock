@echo on

REM openjdk/ant live in BUILD_PREFIX; CMake cross-compile flags set PROGRAM search to NEVER.
if not defined JAVA_HOME set "JAVA_HOME=%BUILD_PREFIX%"
set "CMAKE_ARGS=%CMAKE_ARGS% -DANT_EXECUTABLE=%BUILD_PREFIX%\Library\bin\ant.bat -DJava_ROOT=%BUILD_PREFIX%"

REM Upstream 1.7+ uses scikit-build-core (CMake); legacy setuptools build_ext flags no longer apply.
%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
