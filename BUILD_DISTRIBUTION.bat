@echo off
REM ============================================================================
REM RECIPE BATCHING APP - BUILD & DISTRIBUTION SCRIPT
REM ============================================================================
REM This batch file builds the BatchingApp.py into a portable executable
REM and creates a distribution package ready for deployment.
REM
REM Requirements:
REM   - Python 3.7+
REM   - Administrator privileges
REM ============================================================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ============================================================================
echo   RECIPE BATCHING APP - BUILD & DISTRIBUTION
echo ============================================================================
echo.

REM Color codes
set "GREEN=[92m"
set "YELLOW=[93m"
set "RED=[91m"
set "RESET=[0m"

REM Define directories
set "SOURCE_DIR=%cd%"
set "BUILD_DIR=%SOURCE_DIR%\build"
set "DIST_DIR=%SOURCE_DIR%\dist"
set "RELEASE_DIR=%SOURCE_DIR%\Release"
set "ARCHIVE_DIR=%SOURCE_DIR%\Archives"
set "PYTHON_EXE=python"

REM Get version/timestamp for release
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set "RELEASE_DATE=%%c%%a%%b")
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set "RELEASE_TIME=%%a%%b")
set "RELEASE_VERSION=%RELEASE_DATE%_%RELEASE_TIME%"

echo [*] Release Version: %RELEASE_VERSION%
echo [*] Source Directory: %SOURCE_DIR%
echo.

REM Step 1: Check Python Installation
echo [1/6] Checking Python installation...
%PYTHON_EXE% --version >nul 2>&1
if errorlevel 1 (
    echo %RED%[ERROR] Python not found in PATH%RESET%
    echo Please ensure Python 3.7+ is installed and added to PATH.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('%PYTHON_EXE% --version') do set "PYTHON_VERSION=%%i"
echo %GREEN%[OK] %PYTHON_VERSION%%RESET%
echo.

REM Step 2: Install/Upgrade Required Dependencies
echo [2/6] Installing/upgrading dependencies...
echo Packages to install:
echo   - pyinstaller (for building executable)
echo   - pyserial (for COM port communication)
echo   - openpyxl (for Excel export)
echo   - pywin32 (for Windows printer support - optional)
echo.

%PYTHON_EXE% -m pip install --upgrade pip setuptools wheel >nul 2>&1
if errorlevel 1 (
    echo %RED%[WARNING] Failed to upgrade pip%RESET%
) else (
    echo [*] pip upgraded successfully
)

%PYTHON_EXE% -m pip install pyinstaller pyserial openpyxl >nul 2>&1
if errorlevel 1 (
    echo %RED%[ERROR] Failed to install core dependencies%RESET%
    pause
    exit /b 1
)
echo %GREEN%[OK] Core dependencies installed%RESET%

REM Try to install pywin32 for Windows printer support
%PYTHON_EXE% -m pip install pywin32 >nul 2>&1
if errorlevel 1 (
    echo [*] pywin32 optional package not installed (printer mode may be limited)
) else (
    echo [*] pywin32 installed for Windows printer support
)
echo.

REM Step 3: Clean Previous Builds
echo [3/6] Cleaning previous builds...
if exist "%BUILD_DIR%" (
    rmdir /s /q "%BUILD_DIR%" >nul 2>&1
    echo [*] Removed build directory
)
if exist "%DIST_DIR%" (
    rmdir /s /q "%DIST_DIR%" >nul 2>&1
    echo [*] Removed dist directory
)
echo %GREEN%[OK] Clean complete%RESET%
echo.

REM Step 4: Build Executable with PyInstaller
echo [4/6] Building executable with PyInstaller...
echo This may take 1-2 minutes...
echo.

%PYTHON_EXE% -m PyInstaller --onefile ^
    --windowed ^
    --name BatchingApp ^
    --icon=assets\icon.ico ^
    --manifest=admin.manifest ^
    --collect-all serial ^
    --collect-all openpyxl ^
    --hidden-import=serial.tools.list_ports ^
    BatchingApp.py

if errorlevel 1 (
    echo %RED%[ERROR] PyInstaller build failed%RESET%
    pause
    exit /b 1
)
echo %GREEN%[OK] Executable built successfully%RESET%
echo.

REM Step 5: Create Release Package
echo [5/6] Creating release package...

REM Create release directory structure
if not exist "%RELEASE_DIR%" mkdir "%RELEASE_DIR%"
if not exist "%ARCHIVE_DIR%" mkdir "%ARCHIVE_DIR%"

REM Copy executable to release directory
if exist "%DIST_DIR%\BatchingApp.exe" (
    copy "%DIST_DIR%\BatchingApp.exe" "%RELEASE_DIR%\BatchingApp.exe" >nul
    echo [*] Copied executable to Release directory
) else (
    echo %RED%[ERROR] Executable not found in dist directory%RESET%
    pause
    exit /b 1
)

REM Copy supporting files
if exist "README.md" copy "README.md" "%RELEASE_DIR%\README.md" >nul
if exist "COMPLETE_SUMMARY.md" copy "COMPLETE_SUMMARY.md" "%RELEASE_DIR%\COMPLETE_SUMMARY.md" >nul
if exist "USER_GUIDE_PERSISTENCE.md" copy "USER_GUIDE_PERSISTENCE.md" "%RELEASE_DIR%\USER_GUIDE.md" >nul
if exist "assets\recipes.json" (
    if not exist "%RELEASE_DIR%\assets" mkdir "%RELEASE_DIR%\assets"
    copy "assets\recipes.json" "%RELEASE_DIR%\assets\recipes.json" >nul
)

REM Create installation batch file
(
    echo @echo off
    echo title Recipe Batching App - Installation
    echo echo.
    echo echo ============================================================
    echo echo   RECIPE BATCHING APP - PORTABLE INSTALLATION
    echo echo ============================================================
    echo echo.
    echo echo This is a portable application. No installation required.
    echo echo.
    echo echo To use the application:
    echo echo   1. Run BatchingApp.exe
    echo echo   2. Configure your scale and printer connections
    echo echo   3. Load recipe data or create new batches
    echo echo.
    echo echo Documentation:
    echo echo   - README.md - Quick start guide
    echo echo   - COMPLETE_SUMMARY.md - Full feature documentation
    echo echo   - USER_GUIDE.md - Detailed usage guide
    echo echo.
    echo echo Requirements:
    echo echo   - Windows 7 or later
    echo echo   - Administrator privileges recommended
    echo echo   - Serial port for scale connection (optional^)
    echo echo   - Thermal printer via COM port or Windows default printer (optional^)
    echo echo.
    echo pause
) > "%RELEASE_DIR%\START_HERE.bat"

echo %GREEN%[OK] Release package created%RESET%
echo.

REM Step 6: Create Archive for Distribution
echo [6/6] Creating distribution archive...

REM Create zip archive using PowerShell (available on all Windows systems^)
powershell -Command "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('%RELEASE_DIR%', '%ARCHIVE_DIR%\BatchingApp_%RELEASE_VERSION%.zip')"

if errorlevel 1 (
    echo %RED%[WARNING] Failed to create archive%RESET%
) else (
    echo %GREEN%[OK] Archive created: BatchingApp_%RELEASE_VERSION%.zip%RESET%
)

echo.
echo ============================================================================
echo   BUILD COMPLETE
echo ============================================================================
echo.
echo Release Directory: %RELEASE_DIR%
echo Distribution Archive: %ARCHIVE_DIR%\BatchingApp_%RELEASE_VERSION%.zip
echo.
echo Contents:
echo   - BatchingApp.exe (Main executable^)
echo   - README.md (Quick start^)
echo   - COMPLETE_SUMMARY.md (Full documentation^)
echo   - USER_GUIDE.md (Usage guide^)
echo   - assets\recipes.json (Default recipes^)
echo   - START_HERE.bat (Installation info^)
echo.
echo Next Steps:
echo   1. Review the Release folder
echo   2. Test BatchingApp.exe on your system
echo   3. Distribute the ZIP archive to end users
echo   4. End users can extract and run directly - no installation needed!
echo.
echo ============================================================================
echo.
pause
