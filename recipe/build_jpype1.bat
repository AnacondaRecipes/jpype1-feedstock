@echo on

REM openjdk/ant live in BUILD_PREFIX; CMake cross-compile flags set PROGRAM search to NEVER.
if not defined JAVA_HOME set "JAVA_HOME=%BUILD_PREFIX%"

REM scikit-build strips backslashes from CMAKE_ARGS on Windows; pass defines via pip -C instead.
set "ANT_BAT=%BUILD_PREFIX:\=/%/Library/bin/ant.bat"
set "JAVA_ROOT=%BUILD_PREFIX:\=/%"

REM Upstream 1.7+ uses scikit-build-core (CMake); legacy setuptools build_ext flags no longer apply.
%PYTHON% -m pip install . -vv --no-deps --no-build-isolation ^
  -Ccmake.define.ANT_EXECUTABLE=%ANT_BAT% ^
  -Ccmake.define.Java_ROOT=%JAVA_ROOT%
