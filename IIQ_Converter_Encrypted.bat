@echo off
REM ============================================================================
REM IIQ to JPEG Converter - Encrypted Version Launcher
REM Developed by Bipul Neupane, PhD
REM ============================================================================
REM
REM This launcher uses an encrypted version of the Python code.
REM First run: Downloads full Python with tkinter and sets up environment
REM Subsequent runs: Launches instantly
REM
REM ============================================================================

setlocal EnableDelayedExpansion

REM ── Configuration ──────────────────────────────────────────────────────────
set APP_NAME=IIQ to JPEG Converter
set ENCRYPTED_SCRIPT=iiq_converter_encrypted.pye
set ENV_DIR=%~dp0_python_env
set PYTHON_EXE=%ENV_DIR%\python\python.exe
set SETUP_MARKER=%ENV_DIR%\.setup_complete

REM Python 3.11.9 full installer for Windows (64-bit) - includes tkinter
set PYTHON_INSTALLER_URL=https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe
set PYTHON_INSTALLER=%ENV_DIR%\python-installer.exe

REM ── Check if setup is needed ───────────────────────────────────────────────
if exist "%SETUP_MARKER%" goto :run_app

REM ── First Run Setup ────────────────────────────────────────────────────────
echo.
echo ============================================================================
echo   %APP_NAME% - First Run Setup
echo ============================================================================
echo.
echo This will download and install Python plus all dependencies.
echo Takes about 3-5 minutes. This only happens once.
echo.
echo Press any key to continue, or Ctrl+C to cancel...
pause >nul

echo.
echo [1/5] Creating environment folder...
if not exist "%ENV_DIR%" mkdir "%ENV_DIR%"
cd /d "%ENV_DIR%"

echo [2/5] Downloading Python 3.11.9 installer (~25 MB)...
echo   This includes tkinter and all GUI libraries...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%PYTHON_INSTALLER_URL%' -OutFile '%PYTHON_INSTALLER%'}" 2>nul
if errorlevel 1 (
    echo ERROR: Failed to download Python installer.
    echo Please check your internet connection and try again.
    pause
    exit /b 1
)

echo [3/5] Installing Python (portable mode)...
echo   This may take 2-3 minutes...
REM Install Python to local folder (no admin rights needed)
REM /quiet = silent install, TargetDir = local folder, Include_pip = install pip
"%PYTHON_INSTALLER%" /quiet InstallAllUsers=0 TargetDir="%ENV_DIR%\python" Include_pip=1 Include_tcltk=1 Include_test=0 Include_doc=0 PrependPath=0 Shortcuts=0

REM Wait for installation to complete
timeout /t 5 /nobreak >nul

REM Verify installation
if not exist "%PYTHON_EXE%" (
    echo ERROR: Python installation failed.
    echo The installer may require different permissions.
    pause
    exit /b 1
)

REM Clean up installer
del "%PYTHON_INSTALLER%"

echo [4/5] Upgrading pip...
"%PYTHON_EXE%" -m pip install --upgrade pip --quiet 2>nul

echo [5/5] Installing required packages...
echo   This may take 2-3 minutes...
"%PYTHON_EXE%" -m pip install rawpy Pillow numpy imageio psutil piexif --quiet 2>nul

if errorlevel 1 (
    echo WARNING: Some packages may have failed to install.
    echo The application may not work correctly.
    pause
)

REM Create marker file
echo setup_complete > "%SETUP_MARKER%"

echo.
echo ============================================================================
echo   Setup Complete!
echo ============================================================================
echo.
echo Python environment installed to:
echo   %ENV_DIR%\python
echo.
echo The converter will now launch automatically...
echo.
timeout /t 3 >nul

REM ── Run Application ────────────────────────────────────────────────────────
:run_app
cd /d "%~dp0"

if not exist "%ENCRYPTED_SCRIPT%" (
    echo.
    echo ERROR: %ENCRYPTED_SCRIPT% not found.
    echo Please ensure the encrypted application file is in the same folder.
    echo.
    pause
    exit /b 1
)

REM Launch the encrypted script
"%PYTHON_EXE%" "%ENCRYPTED_SCRIPT%"

if errorlevel 1 (
    echo.
    echo The application encountered an error.
    echo Press any key to close this window...
    pause >nul
)

exit /b 0
