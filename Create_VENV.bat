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
    
    echo Activating conda environment...
    call conda activate "%~dp0\aicovergen_env"

    REM install pip version 24.0
    echo [1/6] Updating pip version...
    aicovergen_env\python.exe -m pip install pip==24.0 >nul 2>&1
    echo [####----------------] 20%%
    
    REM install torch with cuda support first
    echo [2/6] Installing PyTorch with CUDA support...
    pip install --quiet torch==2.0.1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118 >nul 2>&1
    echo [########------------] 40%%
    
    REM install fairseq from prebuilt wheel
    echo [3/6] Installing Fairseq from prebuilt wheel...
    pip install --quiet "%~dp0\prebuilt_whl\fairseq-0.12.2-cp39-cp39-win_amd64.whl" >nul 2>&1
    echo [############--------] 60%%
    
    REM install audio processing dependencies
    echo [4/6] Installing audio processing libraries...
    pip install --quiet librosa==0.9.1 soundfile==0.12.1 pyworld==0.3.4 praat-parselmouth>=0.4.2 pedalboard==0.7.7 pydub==0.25.1 >nul 2>&1
    echo [################----] 80%%
    
    REM install ML dependencies
    echo [5/6] Installing ML dependencies...
    pip install --quiet numpy==1.23.5 scipy==1.11.1 onnxruntime_gpu faiss-cpu==1.7.3 torchcrepe==0.0.20 >nul 2>&1
    echo [##################--] 90%%
    
    REM install remaining utilities
    echo [6/6] Installing utility packages...
    pip install --quiet deemix ffmpeg-python>=0.2.0 gradio==3.45.0 lib==4.0.0 Requests==2.31.0 tqdm==4.65.0 yt_dlp==2023.7.6 sox==1.4.1 >nul 2>&1
    echo [####################] 100%%
    
    echo Setup complete!
) else (
    echo aicovergen_env already exists, activating...
    call conda activate "%~dp0\aicovergen_env"
)

echo Environment is ready!
echo You can now run AICoverGen with the run.bat script
pause
endlocal