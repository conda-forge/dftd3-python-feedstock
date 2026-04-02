setlocal EnableExtensions EnableDelayedExpansion
@echo on

%PYTHON% -m pip install .\python --no-deps --no-build-isolation -vv
if errorlevel 1 exit 1
