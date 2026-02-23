# Distribution & Installation Guide

## Overview
The Recipe Batching App can be packaged as a portable executable for easy distribution to end users. No installation required - users just extract and run!

## Build Process

### Quick Start
1. **Run the build script:**
   ```batch
   BUILD_DISTRIBUTION.bat
   ```

2. **The script will:**
   - ✓ Check Python installation
   - ✓ Install all required dependencies
   - ✓ Clean previous builds
   - ✓ Build the executable with PyInstaller
   - ✓ Create a release package
   - ✓ Generate a distributable ZIP archive

3. **Output locations:**
   - **Executable:** `Release/BatchingApp.exe`
   - **Distribution ZIP:** `Archives/BatchingApp_YYYYMMDD_HHMM.zip`

---

## What's Included in Distribution

### Portable Executable Package
When users extract the ZIP file, they get:

```
BatchingApp/
├── BatchingApp.exe              # Main application (run this!)
├── README.md                    # Quick start guide
├── COMPLETE_SUMMARY.md          # Full feature documentation
├── USER_GUIDE.md                # Detailed usage guide
├── START_HERE.bat               # Installation instructions
└── assets/
    └── recipes.json             # Default recipe database
```

### Features
- **Fully Portable** - No installation required
- **Self-Contained** - All dependencies bundled
- **Admin Manifest** - Auto-requests admin privileges
- **Default Configuration** - Ready to use out of the box
- **Data Persistence** - Settings saved to ProgramData

---

## System Requirements

### Minimum
- Windows 7 or later (32-bit or 64-bit)
- 100 MB free disk space
- 256 MB RAM minimum

### Recommended
- Windows 10/11
- 500 MB free disk space
- 512 MB RAM

### Optional (For Full Features)
- **Serial Scale Connection:** USB-to-COM adapter or serial scale
- **Thermal Printer:** ESC/POS printer via COM port
- **Default Printer:** Windows printer (auto-detected)

---

## Installation for End Users

### Step 1: Extract
Unzip `BatchingApp_YYYYMMDD_HHMM.zip` to any folder:
- Desktop
- Program Files (if permissions allow)
- Portable USB drive
- Network share

### Step 2: Run
Double-click `BatchingApp.exe` to start

### Step 3: First Run
- Grant administrator privileges (if prompted)
- Configure COM ports for scale and printer
- Load or create recipe data
- Start batching!

---

## Customization Before Distribution

### Modify Default Settings
Edit these in `BatchingApp.py` before building:

```python
# Default recipe header (line ~375)
self.print_header_var = tk.StringVar(value="YOUR COMPANY NAME\nAddress • Phone")

# Default COM ports (lines ~372-374)
self.printer_com_var = tk.StringVar(value="COM3")
self.printer_baud_var = tk.StringVar(value="9600")
```

### Include Custom Recipes
Add recipes to `assets/recipes.json` before building

### Custom Icon/Manifest
Modify these files:
- `assets/icon.ico` - Application icon
- `admin.manifest` - Admin privilege request

---

## Troubleshooting

### Build Script Issues

**"Python not found"**
- Install Python 3.7+ from python.org
- Add Python to PATH during installation
- Verify: `python --version` in command prompt

**"PyInstaller failed"**
- Delete `build/` and `dist/` folders manually
- Run build script again
- Check Python 3.7+ compatibility

**"Permissions denied"**
- Run command prompt as Administrator
- Run `BUILD_DISTRIBUTION.bat` with admin rights

### End User Issues

**App won't start**
- Ensure Windows 7+ with latest updates
- Right-click → Run as Administrator
- Check that admin.manifest is present

**Scale/Printer not detected**
- Install USB-to-COM drivers if using adapter
- Verify COM port in Device Manager
- Test connection in settings panel

**Data not saving**
- Verify user has write permissions to `C:\ProgramData\Batching Recipe`
- Run as Administrator
- Check available disk space

---

## Advanced Options

### Build Custom Executable
```batch
python -m PyInstaller --onefile ^
    --windowed ^
    --name BatchingApp ^
    --icon=assets/icon.ico ^
    --add-data "assets;assets" ^
    BatchingApp.py
```

### Single-File vs. Multiple Files
Current build uses `--onefile` for single executable. To use multiple files:
- Remove `--onefile` flag
- Distribute entire `dist/` folder
- Slightly smaller file size, faster startup

### Signature Executable (Corporate Distribution)
```batch
REM After build completes:
signtool sign /f YourCert.pfx /p YourPassword /t http://timestamp.server ^
    dist\BatchingApp.exe
```

---

## Support & Updates

### Providing Updates
1. Update `BatchingApp.py` in source
2. Run `BUILD_DISTRIBUTION.bat` again
3. Distribute new ZIP archive
4. Users extract over old version (data is in ProgramData, preserved)

### Collecting Feedback
Application logs are stored in:
```
C:\ProgramData\Batching Recipe\batch_app.log
```

Users can share this for troubleshooting.

### Distributing Patches
For quick fixes:
1. Rebuild executable only (step 4)
2. Copy new `BatchingApp.exe` to users' installation folders
3. No need to distribute full archive

---

## Distribution Channels

### USB Drive / Network Share
- Copy entire Release folder to network
- Users extract and run

### ZIP Archive
- Host on internal server
- Share via email/file transfer
- Provide checksums for verification

### Auto-Update (Advanced)
- Version check on startup
- Download new archive automatically
- Prompt user to update
- (Requires modification to source code)

---

## Security Notes

- ✓ No internet required - fully offline capable
- ✓ Data stored locally in ProgramData
- ✓ Admin manifest verified in source
- ✓ All imports validated
- ⚠ pywin32 optional for printer features

**Code Signing (Recommended):**
For corporate distribution, sign the executable to bypass SmartScreen warnings.

---

## Version History

| Version | Date | Notes |
|---------|------|-------|
| Build 1.0 | 2026-01-20 | Initial release with printer mode toggle |

---

**Need Help?** Refer to README.md or COMPLETE_SUMMARY.md for usage documentation.
