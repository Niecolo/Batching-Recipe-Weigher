# Printer Mode Toggle Feature

## Overview
Added a printer connection mode toggle to the Print Ticket frame, allowing users to switch between two printer connection methods:
- **COM Port** (Serial/ESC-POS): Direct connection via COM port with configurable baud rate and parity
- **Default Printer**: Windows default printer connection

## Changes Made

### 1. **Settings & Variables**
- Added `printer_mode_var` (StringVar) with values: "COM" or "DEFAULT" (default: "COM")
- Added `printer_name` instance variable to store default printer name
- Updated `save_user_settings()` to persist printer mode selection

### 2. **UI Modifications - Print Ticket Frame**
- Added **Mode** dropdown selector next to "Auto-print" checkbox
- Grouped COM port controls (COM, Baud, Parity) in a collapsible frame
- Controls visibility changes based on selected printer mode:
  - **COM Mode**: Shows COM port, Baud rate, and Parity selectors
  - **DEFAULT Mode**: Hides COM-specific controls

### 3. **Connection Logic**
- Updated `connect_printer()` method to handle both modes:
  - **COM Mode**: Uses existing serial connection logic with pySerial
  - **DEFAULT Mode**: Uses Windows default printer (requires win32print)
  
- Added new `on_printer_mode_change()` method:
  - Toggles visibility of COM port controls
  - Auto-saves settings when mode changes

### 4. **Printing Methods**
- Updated `_send_print_job()` to route to appropriate printer method:
  - Calls `_print_transaction_ticket_default()` for default printer
  - Calls `_print_transaction_ticket_sync()` for COM port

- Added `_print_transaction_ticket_default()` method:
  - Generates plain-text ticket format
  - Uses temporary file and Windows print API
  - Handles cleanup automatically

### 5. **Error Handling**
- Default printer mode checks for win32print package availability
- Shows user-friendly error messages for missing dependencies
- Falls back gracefully if printer connection fails

## Dependencies

### Additional Requirement for Default Printer Mode:
- **pywin32** package: `pip install pywin32`
  
This is optional and only needed if using the "DEFAULT" printer mode.

## Usage

### Selecting Printer Mode:

1. **COM Port Mode (Default)**
   - Select "COM" from Mode dropdown
   - Choose COM port from list
   - Configure Baud rate (9600 default)
   - Configure Parity (None/Even/Odd)
   - Check "Auto-print after capture"

2. **Default Printer Mode**
   - Select "DEFAULT" from Mode dropdown
   - COM controls automatically hide
   - Windows default printer is selected
   - Check "Auto-print after capture"

### Test Print:
- Click **🖨️ Test Print** button to verify printer connection
- Works with both modes

## Implementation Details

### File Modified:
- `BatchingApp.py`

### Key Methods:
- `on_printer_mode_change()`: Manages UI visibility
- `connect_printer()`: Routes to appropriate connection handler
- `_print_transaction_ticket_default()`: Handles Windows default printer
- `_send_print_job()`: Routes to appropriate print method

### Settings Persistence:
- Printer mode preference saved to `user_settings.json`
- Auto-saves when mode is changed
- Persistent across application restarts

## Backward Compatibility
- Default mode is "COM" (existing behavior)
- All existing COM port settings preserved
- No breaking changes to existing functionality

## Testing Checklist
- [ ] COM port mode works as before
- [ ] COM controls hide when "DEFAULT" mode is selected
- [ ] COM controls show when "COM" mode is selected
- [ ] Default printer mode connects successfully (with pywin32 installed)
- [ ] Test print works in both modes
- [ ] Settings persist after restart
- [ ] Mode toggle saves automatically
