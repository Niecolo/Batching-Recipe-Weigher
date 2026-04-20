@echo off
:: Batch wrapper to properly launch run_as_admin.ps1 PowerShell script
:: This fixes the issue where trying to run the ps1 file directly with Python causes syntax errors

echo Launching BatchingApp as Administrator...
echo.

:: Change to current script directory
cd /d "%~dp0"

:: Run PowerShell script with proper execution policy bypass
powershell.exe -ExecutionPolicy Bypass -File "%~dp0run_as_admin.ps1"

:: If there was an error, pause so user can see it
if %errorlevel% neq 0 (
    echo.
    echo Press any key to exit...
    pause >nul
)