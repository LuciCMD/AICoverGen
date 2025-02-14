@echo off
setlocal

REM check if anaconda is installed
if exist "C:\Users\%USERNAME%\anaconda3" (
    echo Anaconda found!
    
) else (
    echo Please install anaconda before continuing...
    pause
)

REM check if aicovergen_env exists
if not exist "%~dp0\aicovergen_env\" (
    echo Creating python 3.9 conda environment for AICoverGen...
    
    REM create conda environment with python 3.9
    call conda create -p "%~dp0\aicovergen_env" python=3.9 -y
    
    echo activating conda environment...
    call conda activate "%~dp0\aicovergen_env"

    REM install pip version 24.0
    aicovergen_env\python.exe -m pip install pip==24.0
    
    echo Installing required packages...
    
    REM install torch with cuda support first
    pip install torch==2.0.1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118
    
    REM install fairseq from prebuilt wheel
    pip install "%~dp0\prebuilt_whl\fairseq-0.12.2-cp39-cp39-win_amd64.whl"
    
    REM install main dependencies
    pip install deemix
    pip install faiss-cpu==1.7.3
    pip install ffmpeg-python
    pip install gradio==3.45.0
    pip install lib==4.0.0
    pip install librosa==0.9.1
    pip install numpy==1.23.5
    pip install onnxruntime_gpu
    pip install praat-parselmouth
    pip install pedalboard==0.7.7
    pip install pydub==0.25.1
    pip install pyworld==0.3.4
    pip install Requests==2.31.0
    pip install scipy==1.11.1
    pip install soundfile==0.12.1
    pip install torchcrepe==0.0.20
    pip install tqdm==4.65.0
    pip install yt_dlp==2023.7.6
    pip install sox==1.4.1
    
    echo Setup complete!
) else (
    echo aicovergen_env already exists, activating...
    call conda activate "%~dp0\aicovergen_env"
)

echo Environment is ready!
echo You can now run AICoverGen with the run.bat script
pause
endlocal