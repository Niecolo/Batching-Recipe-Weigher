@echo off
echo ============================================================
echo  Starting Batching Application in DEBUG MODE
echo ============================================================
echo.
echo  Debug mode features:
echo  - No Administrator privileges required
echo  - Enhanced debug logging enabled
echo  - F12 opens developer panel directly
echo  - Serial port restrictions relaxed
echo  - All debug information shown
echo.

echo Installing/updating required dependencies...
pip install -r requirements.txt
echo.

echo Starting application with debug flag...
python BatchingApp.py --debug

echo.
echo Application exited.
pause