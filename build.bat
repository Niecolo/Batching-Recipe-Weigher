@echo off
REM ========================================
REM BatchingApp - Automated Build Script
REM Version 2.0.0
REM ========================================
setlocal enabledelayedexpansion

echo.
echo ========================================
echo  BatchingApp Automated Builder
echo ========================================
echo.

REM Set log file
set LOGFILE=build_log.txt
echo Build started at %date% %time% > %LOGFILE%

REM Check if Python is installed
echo [1/6] Checking Python installation... >> %LOGFILE%
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo ERROR: Python is not installed >> %LOGFILE%
    pause
    exit /b 1
)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Python %PYTHON_VERSION% found >> %LOGFILE%

REM Check if pip is installed
echo [2/6] Checking pip installation... >> %LOGFILE%
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: pip is not installed
    echo ERROR: pip is not installed >> %LOGFILE%
    pause
    exit /b 1
)

REM Upgrade pip silently
echo Upgrading pip... >> %LOGFILE%
python -m pip install --upgrade pip --quiet >> %LOGFILE% 2>&1

REM Install PyInstaller if not installed
echo [3/6] Checking PyInstaller... >> %LOGFILE%
pip show pyinstaller >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing PyInstaller... >> %LOGFILE%
    pip install pyinstaller --quiet >> %LOGFILE% 2>&1
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install PyInstaller
        echo ERROR: Failed to install PyInstaller >> %LOGFILE%
        pause
        exit /b 1
    )
) else (
    echo PyInstaller already installed >> %LOGFILE%
)

REM Install required packages
echo [4/6] Installing required packages... >> %LOGFILE%
echo Installing pyserial... >> %LOGFILE%
pip install pyserial --upgrade --quiet >> %LOGFILE% 2>&1
echo Installing openpyxl... >> %LOGFILE%
pip install openpyxl --upgrade --quiet >> %LOGFILE% 2>&1
echo Installing Pillow... >> %LOGFILE%
pip install Pillow --upgrade --quiet >> %LOGFILE% 2>&1

REM Verify all packages are installed
echo Verifying installations... >> %LOGFILE%
python -c "import serial; print('pyserial: OK')" >> %LOGFILE% 2>&1
python -c "import openpyxl; print('openpyxl: OK')" >> %LOGFILE% 2>&1
python -c "import tkinter; print('tkinter: OK')" >> %LOGFILE% 2>&1

REM Clean previous builds
echo [5/6] Cleaning previous builds... >> %LOGFILE%
if exist "build" rmdir /s /q "build" >> %LOGFILE% 2>&1
if exist "dist" rmdir /s /q "dist" >> %LOGFILE% 2>&1

REM Build the executable
echo [6/6] Building BatchingApp.exe...
echo [6/6] Building BatchingApp.exe... >> %LOGFILE%
echo This may take several minutes...
echo.

REM Build with PyInstaller using spec file (suppress most output)
echo Starting PyInstaller build (this may take several minutes)... >> %LOGFILE%
pyinstaller ^
    --clean ^
    --noconfirm ^
    --log-level=WARN ^
    BatchingApp.spec >> %LOGFILE% 2>&1

if not exist "dist\BatchingApp.exe" (
    echo.
    echo ERROR: Build failed! Check build_log.txt for details.
    echo ERROR: Build failed >> %LOGFILE%
    pause
    exit /b 1
)

REM Create distribution folder structure
echo.
echo Creating distribution package...
echo Creating distribution package... >> %LOGFILE%
if not exist "dist\assets" mkdir "dist\assets" >> %LOGFILE% 2>&1

REM Copy assets to dist folder
if exist "assets" (
    xcopy /E /I /Y assets dist\assets\ >nul 2>&1
    echo Assets copied successfully >> %LOGFILE%
)

REM Create README for distribution
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
    echo For support, contact your system administrator.
) > dist\README.txt

REM Create a simple run script
(
    echo @echo off
    echo start "" "BatchingApp.exe"
) > dist\Run_BatchingApp.bat

REM Create version info file
(
    echo BatchingApp Version 2.0.0
    echo Build Date: %date% %time%
    echo.
    echo Build Environment:
    echo   Python: %PYTHON_VERSION%
) > dist\VERSION.txt

REM Calculate dist folder size
for /f "tokens=3" %%a in ('dir dist /s /-c 2^>nul ^| findstr "File(s)"') do set DIST_SIZE=%%a
echo Distribution size: %DIST_SIZE% bytes >> %LOGFILE%

REM Create ZIP archive for easy distribution
echo Creating ZIP archive...
echo Creating ZIP archive... >> %LOGFILE%
if exist "BatchingApp_v2.0.0.zip" del /f /q "BatchingApp_v2.0.0.zip" >> %LOGFILE% 2>&1
powershell -command "Compress-Archive -Path 'dist\*' -DestinationPath 'BatchingApp_v2.0.0.zip'" >> %LOGFILE% 2>&1

echo.
echo ========================================
echo  Build completed successfully!
echo ========================================
echo.
echo Distribution package: dist\
echo ZIP archive: BatchingApp_v2.0.0.zip
echo Build log: %LOGFILE%
echo.
echo Build completed at %date% %time% >> %LOGFILE%

REM Open the dist folder automatically
explorer dist

exit /b 0