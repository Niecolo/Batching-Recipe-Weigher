# Print Preview Feature - Quick Start Guide

## 5-Minute Quick Start

### Step 1: Enable Auto-Print
1. Scroll up in the main window to **Print Ticket** settings
2. Check the box "Auto-print after capture"
3. Configure printer settings:
   - **COM**: Select your printer's serial port
   - **Baud**: 9600 (typical)
   - **Parity**: None (typical)

### Step 2: View Test Preview (No Printer Needed)
1. Click **🖨️ Test Print** button
2. A preview window appears showing sample ticket
3. Review the formatting and content

### Step 3: What You'll See

The preview shows:

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

### Step 4: Three Options from Preview Window

| Button | Action |
|--------|--------|
| 🖨️ Print Ticket | Sends ticket to printer (if connected) |
| 📋 Copy Text | Copies to clipboard |
| Close | Closes window without printing |

---

## Ticket Contents Explained

| Field | Meaning | Example |
|-------|---------|---------|
| **Batch** | Batch identifier | TEST-001 |
| **Time** | Date/Time captured | 01/18/2026 02:30:45 PM |
| **Item** | Ingredient name | Flour, Sugar, etc. |
| **Target** | Target weight | 1000.00 g |
| **Actual** | Recorded weight | 1005.30 g |
| **Tol** | Tolerance allowed | 2.0% |
| **Status** | Result (UNDER/OK/OVER) | OK |
| **Dev** | Deviation from target | +5.30 g |

---

## Customize the Ticket

### Edit Header Text
In Print Ticket settings, modify the **Header** field.

**Default:**
```
COMPANY NAME
Addr • Tel
```

**Change to:**
```
YOUR COMPANY
123 Street Name
City, State ZIP
```

Use `\n` for line breaks.

### Adjust Paper Width
In Print Ticket settings, set **Width (chars)** to match your printer:
- Small printer: 24-28 characters
- Standard thermal: 32 characters (default)
- Large printer: 40-48 characters

---

## During Actual Weighing

When you capture ingredient weights during batching:

1. **Load Recipe** → **Start Batch** → **Weigh Ingredient**
2. Click **Capture Now** when weight is acceptable
3. If auto-print is enabled:
   - Transaction data is recorded
   - Ticket is automatically sent to printer
   - Includes YOUR batch ID, ingredient name, and actual weight
4. Repeat for next ingredient

---

## Troubleshooting Quick Reference

| Issue | Solution |
|-------|----------|
| Preview doesn't open | Ensure printer auto-print is enabled |
| Text looks weird | Adjust paper width to match printer |
| Print button grayed out | Connect printer first (must see green "OK" status) |
| Copy button not working | Check if Windows clipboard is accessible |
| Printer not receiving | Verify COM port and baud rate settings |

---

## Feature Summary

✅ **See before you print** - Preview shows exact format
✅ **Test without printer** - No printer needed for preview
✅ **Customizable** - Edit header and paper width
✅ **Copy to clipboard** - Share or document format
✅ **Smart printing** - Confirms printer ready before sending
✅ **Automatic logging** - All captures recorded in CSV

---

## Keyboard Tips

While in preview window:
- **Tab** - Move between buttons
- **Enter** - Click focused button
- **Escape** - Close window (same as Close button)

---

## Example Workflow

```
1. Click 🖨️ Test Print
              ↓
2. Review preview window
              ↓
3. Adjust header text (if needed)
              ↓
4. Click Close or 🖨️ Print Ticket
              ↓
5. When weighing, auto-print triggers
   after each Capture Now
```

---

## Need More Details?

See `PRINT_PREVIEW_FEATURE.md` for comprehensive documentation.
