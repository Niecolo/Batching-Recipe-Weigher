@echo off
REM ========================================
REM BatchingApp - Build Distributable EXE
REM Version 2.0.0
REM ========================================
setlocal enabledelayedexpansion

echo.
echo ========================================
echo  BatchingApp EXE Builder v2.0.0
echo ========================================
echo.

REM Check if Python is installed
echo [1/6] Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python from https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Found Python %PYTHON_VERSION%

REM Check if pip is installed
echo.
echo [2/6] Checking pip installation...
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: pip is not installed
    echo Please install pip: python -m ensurepip --upgrade
    pause
    exit /b 1
)

REM Install/upgrade pip if needed
echo Upgrading pip...
python -m pip install --upgrade pip >nul 2>&1

REM Install PyInstaller if not installed
echo.
echo [3/6] Checking PyInstaller...
pip show pyinstaller >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing PyInstaller...
    pip install pyinstaller
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install PyInstaller
        pause
        exit /b 1
    )
) else (
    echo PyInstaller already installed
)

REM Install required packages
echo.
echo [4/6] Installing required packages...
echo Installing pyserial...
pip install pyserial --upgrade >nul 2>&1
echo Installing openpyxl...
pip install openpyxl --upgrade >nul 2>&1
echo Installing Pillow (for icon support)...
pip install Pillow --upgrade >nul 2>&1

REM Verify all packages are installed
echo.
echo Verifying installations...
python -c "import serial; print('pyserial: OK')" 2>nul || echo pyserial: MISSING
python -c "import openpyxl; print('openpyxl: OK')" 2>nul || echo openpyxl: MISSING
python -c "import tkinter; print('tkinter: OK')" 2>nul || echo tkinter: MISSING

REM Clean previous builds
echo.
echo [5/6] Cleaning previous builds...
if exist "build" (
    echo Removing build folder...
    rmdir /s /q "build"
)
if exist "dist" (
    echo Removing dist folder...
    rmdir /s /q "dist"
)
if exist "BatchingApp.spec" (
    del /f /q "BatchingApp.spec"
)

REM Build the executable
echo.
echo [6/6] Building BatchingApp.exe...
echo This may take several minutes...
echo.

REM Build with PyInstaller
pyinstaller ^
    --onefile ^
    --windowed ^
    --icon=assets\icon.ico ^
    --name "BatchingApp" ^
    --add-data "assets;assets" ^
    --uac-admin ^
    --clean ^
    --noconfirm ^
    --log-level=WARN ^
    BatchingApp.py

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Build failed!
    echo Check the error messages above for details.
    pause
    exit /b 1
)

REM Create distribution folder structure
echo.
echo Creating distribution package...
if not exist "dist\assets" (
    mkdir "dist\assets"
)

REM Copy assets to dist folder
echo Copying assets to distribution folder...
if exist "assets" (
    xcopy /E /I /Y assets dist\assets\ >nul
    if %errorlevel% neq 0 (
        echo WARNING: Failed to copy some assets
    ) else (
        echo Assets copied successfully
    )
)

REM Create README for distribution
echo Creating distribution README...
(
    echo BatchingApp v2.0.0
    echo ==================
    echo.
    echo INSTALLATION:
    echo   1. Copy BatchingApp.exe to any folder
    echo   2. Double-click BatchingApp.exe to run
    echo   3. The application will request Administrator privileges
    echo.
    echo REQUIREMENTS:
    echo   - Windows 7/8/10/11
    echo   - Administrator privileges (for serial port access)
    echo.
    echo DATA STORAGE:
    echo   Recipes and settings are stored in:
    echo   C:\ProgramData\Batching Recipe\
    echo.
    echo FEATURES:
    echo   - Recipe management with ingredients
    echo   - Live weight reading from serial scale
    echo   - Auto-advance when weight is in tolerance
    echo   - Thermal printer support (ESC/POS)
    echo   - Transaction history with CSV/Excel export
    echo   - Batch resume functionality
    echo.
    echo SERIAL PORT SETTINGS:
    echo   - Default: COM1, 9600 baud, 8N1
    echo   - Configurable in Settings menu
    echo.
    echo ALARM OUTPUT:
    echo   - RS232 RTS signal for external alarms
    echo   - Sound alerts for weight status
    echo.
    echo For support, contact your system administrator.
) > dist\README.txt

REM Create a simple run script
echo Creating run script...
(
    echo @echo off
    echo echo Starting BatchingApp...
    echo start "" "BatchingApp.exe"
) > dist\Run_BatchingApp.bat

REM Create version info file
echo Creating version info...
(
    echo BatchingApp Version 2.0.0
    echo Build Date: %date% %time%
    echo.
    echo Build Environment:
    echo   Python: %PYTHON_VERSION%
    echo   PyInstaller: 
    for /f "tokens=2" %%i in ('pip show pyinstaller 2^>^&1 ^| findstr "Version"') do echo     %%i
    echo   pyserial:
    for /f "tokens=2" %%i in ('pip show pyserial 2^>^&1 ^| findstr "Version"') do echo     %%i
    echo   openpyxl:
    for /f "tokens=2" %%i in ('pip show openpyxl 2^>^&1 ^| findstr "Version"') do echo     %%i
) > dist\VERSION.txt

REM Calculate dist folder size
echo.
echo Calculating package size...
for /f "tokens=3" %%a in ('dir dist /s /-c 2^>nul ^| findstr "File(s)"') do set DIST_SIZE=%%a
if defined DIST_SIZE (
    echo Distribution size: %DIST_SIZE% bytes
)

echo.
echo ========================================
echo  Build completed successfully!
echo ========================================
echo.
echo Your distributable package is located at:
echo   %cd%\dist\
echo.
echo Contents:
echo   - BatchingApp.exe    (Main executable)
echo   - assets\            (Application assets)
echo   - README.txt         (User documentation)
echo   - Run_BatchingApp.bat (Quick run script)
echo   - VERSION.txt        (Build information)
echo.
echo To distribute:
echo   1. Copy the entire 'dist' folder to target machine
echo   2. Run BatchingApp.exe
echo   3. Application will request Administrator privileges
echo.
echo Note: The EXE is a standalone executable - no Python
echo       installation required on target machines.
echo.

REM Ask if user wants to open the dist folder
set /p OPEN_DIST="Open distribution folder? (Y/N): "
if /i "%OPEN_DIST%"=="Y" (
    explorer dist
)

echo.
echo Done!
pause
exit /b 0