# Print Preview Feature Documentation

## Overview
The print preview feature allows users to see exactly how a thermal printer ticket will look before sending it to the printer. This is useful for verifying formatting, text layout, and content before actual printing.

## Features

### 1. Test Print Preview
Pressing the **🖨️ Test Print** button in the Print Ticket settings panel opens a preview window showing sample ticket output.

**Test Data Shown:**
- Batch ID: TEST-001
- Timestamp: Current date/time
- Ingredient: Test Ingredient
- Target Weight: 1000.00 g
- Actual Weight: 1005.30 g
- Tolerance: 2.0%
- Status: OK
- Deviation: +5.30 g

### 2. Actual Transaction Preview
When auto-print is enabled and a transaction is captured during weighing, the preview displays:
- **Batch ID**: Unique batch identifier
- **Timestamp**: Date and time of capture
- **Item Name**: Ingredient being weighed
- **Target Weight**: Target weight in grams
- **Actual Weight**: Recorded weight in grams
- **Tolerance**: Tolerance percentage for this ingredient
- **Status**: UNDER, OK, or OVER
- **Deviation**: Actual weight difference from target

### 3. Preview Window Features

#### Text Display
- Uses monospace font (Courier New) to match thermal printer output
- Shows text wrapped to match paper width setting (default 32 characters)
- Displays with proper alignment (centered headers, left-aligned data)
- Includes visual separators (lines of dashes and equals signs)

#### Buttons
1. **🖨️ Print Ticket** - Sends the ticket to the connected printer
2. **📋 Copy Text** - Copies the preview text to clipboard for sharing or documentation
3. **Close** - Closes the preview window without printing

#### Customization
The preview respects your print settings:
- **Header Text**: Customizable header displayed at top of ticket
- **Paper Width**: Adjustable character width (24-48 characters)
- **Printer Settings**: COM port, baud rate, and parity

## Ticket Format

```
================================
         COMPANY NAME
         Addr • Tel
================================

Batch: TEST-001
Time:  01/18/2026 02:30:45 PM

Item:  Test Ingredient

Target: 1000.00 g
Actual: 1005.30 g
Tol:    2.0%

Status: OK
Dev:    +5.30 g

================================
```

## Content Included in Ticket

The print preview ticket includes:

| Field | Description |
|-------|-------------|
| Header | Customizable company name/address (up to 3 lines) |
| Batch ID | Unique batch identifier |
| Time | Date and time of capture (mm/dd/yyyy HH:MM:SS AM/PM) |
| Item | Ingredient name |
| Target | Target weight in grams |
| Actual | Recorded actual weight in grams |
| Tol | Tolerance percentage |
| Status | UNDER, OK, or OVER status |
| Dev | Deviation from target (+ or -) |

## How to Use

### Test the Preview (No Printer Required)
1. Go to **Print Ticket** settings panel
2. Enable "Auto-print after capture" (optional - for testing preview)
3. Click **🖨️ Test Print** button
4. Preview window opens showing sample ticket
5. Review formatting and layout
6. Click **Close** to exit without printing

### Preview Actual Transactions
1. Load a recipe and start a batch
2. Weigh ingredients with "Auto-print after capture" enabled
3. When you capture a weight, the ticket is automatically sent to printer
4. Ticket data includes actual batch ID and ingredient from your recipe

### Copy Preview Text
1. Open any preview window
2. Click **📋 Copy Text** button
3. Confirmation dialog appears
4. Paste text anywhere (email, document, etc.) using Ctrl+V

### Adjust Printer Settings
Before testing preview:
1. Configure **Header** text (company name, address, etc.)
2. Set **Paper Width** to match your printer (default 32 characters)
3. Select appropriate **COM port**, **Baud rate**, and **Parity**
4. Preview updates automatically to show new formatting

## Integration with Automatic Printing

When auto-print is enabled and a weight is captured:
1. Data is recorded in CSV transaction log
2. Ticket data is prepared with actual batch/ingredient info
3. Ticket is automatically sent to printer (if connected)
4. User can still view preview by manually testing with **Test Print** button

## Configuration Options

### Print Header
Default: "COMPANY NAME\nAddr • Tel"
- Supports multiple lines (use \n for line breaks)
- Will be centered on ticket
- Text longer than paper width will be wrapped

### Paper Width
Default: 32 characters
Range: 24-48 characters
- Affects how text is wrapped and centered
- Must match your actual thermal printer width

### Printer Connection
- **COM Port**: Serial port where printer is connected
- **Baud Rate**: Communication speed (typical 9600)
- **Parity**: None/Even/Odd (typically None)

## Tips & Best Practices

1. **Test First**: Always use Test Print button before enabling auto-print
2. **Verify Formatting**: Check that header and paper width look correct
3. **Document Template**: Copy preview text to create documentation
4. **Printer Troubleshooting**: Use preview to verify data is correct before investigating printer issues
5. **Custom Headers**: Include relevant company/batch information in header

## Technical Details

### Methods
- `format_ticket_text(data)` - Generates text representation
- `show_print_preview(data)` - Displays preview window
- `_print_and_close_preview(data, window)` - Handles print button
- `_copy_preview_text(text, window)` - Copies text to clipboard
- `test_print_ticket()` - Opens test preview with sample data

### Data Structure
```python
ticket_data = {
    "batch_id": "BATCH-001",
    "timestamp": "01/18/2026 02:30:45 PM",
    "ingredient": "Ingredient Name",
    "target": 1000.0,
    "actual": 1005.3,
    "tolerance": 2.0,
    "status": "OK",
    "deviation": +5.3
}
```

## Troubleshooting

**Preview window not appearing:**
- Ensure main application window is in focus
- Check if multiple preview windows are already open

**Text not displaying correctly:**
- Verify paper width matches your printer
- Check header text for special characters
- Try adjusting paper width setting

**Print button grayed out:**
- Enable auto-print checkbox first
- Connect to printer (green status indicator)
- Verify COM port and baud rate settings

**Copy text shows error:**
- Ensure clipboard is accessible
- Close any clipboard management tools interfering
