setlocal EnableExtensions EnableDelayedExpansion
@echo on

move python\mesonpep517.toml python\pyproject.toml

%PYTHON% -m pip install .\python --no-deps --no-build-isolation -vv
if errorlevel 1 exit 1
