@echo off
setlocal

REM check if aicovergen_env exists
if exist "%~dp0\aicovergen_env\" (  
    echo Activating conda environment...
    call conda activate "%~dp0\aicovergen_env"

    REM start webui
    python src/webui.py

) else (
    echo Please run AiCoverGen_VENV.bat before using this script...
)

echo WebUI starting...
pause
endlocal