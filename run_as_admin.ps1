# Run BatchingApp as Administrator
# This script will launch the BatchingApp with administrator privileges

Write-Host "Launching BatchingApp as Administrator..." -ForegroundColor Green

# Change to the script directory
Set-Location $PSScriptRoot

# First check if virtual environment exists
if (Test-Path "$PSScriptRoot\venv\Scripts\python.exe") {
    Write-Host "Using virtual environment Python" -ForegroundColor Cyan
    $pythonPath = "$PSScriptRoot\venv\Scripts\python.exe"
}
else {
    Write-Host "Virtual environment not found, using system Python" -ForegroundColor Yellow
    $pythonPath = "python.exe"
}

# Run the Python script as administrator
try {
    Start-Process $pythonPath -ArgumentList "BatchingApp.py" -Verb RunAs -Wait
}
catch {
    Write-Host "Failed to launch: $_" -ForegroundColor Red
    Write-Host "`nTrying direct system python launch..." -ForegroundColor Yellow
    try {
        Start-Process "python.exe" -ArgumentList "BatchingApp.py" -Verb RunAs -Wait
    }
    catch {
        Write-Host "ERROR: Could not launch Python. Please ensure Python is installed and in PATH." -ForegroundColor Red
        Write-Host "Or run manually: python BatchingApp.py" -ForegroundColor Yellow
        pause
        exit 1
    }
}

Write-Host "BatchingApp closed." -ForegroundColor Yellow
