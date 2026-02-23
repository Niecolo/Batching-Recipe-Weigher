# Print Preview Feature - Visual Guide & Examples

## Preview Window Layout

```
┌─────────────────────────────────────────────────────────┐
│ Print Ticket Preview                                [X] │
├─────────────────────────────────────────────────────────┤
│ Print Preview - Thermal Receipt (32 char width)        │
├─────────────────────────────────────────────────────────┤
│                                                    [║]   │
│ ┌─────────────────────────────────────────────────┐   │   │
│ │ ================================                 │   │   │
│ │          COMPANY NAME                           │   │   │
│ │          Addr • Tel                             │   │   │
│ │ ================================                 │   │   │
│ │                                                 │   │   │
│ │ Batch: TEST-001                                 │   │   │
│ │ Time:  01/18/2026 02:30:45 PM                  │   │   │
│ │                                                 │   │   │
│ │ Item:  Test Ingredient                         │   │   │
│ │                                                 │   │   │
│ │ Target: 1000.00 g                              │   │   │
│ │ Actual: 1005.30 g                              │   │   │
│ │ Tol:    2.0%                                    │   │   │
│ │                                                 │   │   │
│ │ Status: OK                                      │   │   │
│ │ Dev:    +5.30 g                                │   │   │
│ │                                                 │   │   │
│ │ ================================                 │   │   │
│ └─────────────────────────────────────────────────┘   │   │
│                                                    [║]   │
├─────────────────────────────────────────────────────────┤
│  [🖨️ Print Ticket]  [📋 Copy Text]                     │
│  [          Close          ]                            │
└─────────────────────────────────────────────────────────┘
```

## Button States

### Normal State (Ready to use)
```
[ 🖨️ Print Ticket ]  [ 📋 Copy Text ]
```

### After Click "Print Ticket"
```
Message: "Print Job Sent"
         "Ticket sent to printer."
→ Window closes automatically
```

### After Click "Copy Text"
```
Message: "Copied"
         "Ticket text copied to clipboard."
→ Window remains open
```

---

## Print Ticket Settings Panel Location

```
┌─ MAIN APPLICATION WINDOW ────────────────────────────────┐
│                                                           │
│ [Input Serial]     [Alarm Output]                        │
│ [Simulated Weight] [Print Ticket] ← ← ← THIS PANEL       │
│                                                           │
│ ┌─ Print Ticket Settings ──────────────────────────┐    │
│ │ ☑ Auto-print after capture  COM: COM3  Baud: 9600│    │
│ │                              Parity: None        │    │
│ │ Header: COMPANY NAME                             │    │
│ │         Addr • Tel                               │    │
│ │                                                  │    │
│ │ Width (chars): [32]  Printer: OK [green]         │    │
│ │                                                  │    │
│ │           [🖨️ Test Print]                        │    │
│ └──────────────────────────────────────────────────┘    │
│                                                           │
└───────────────────────────────────────────────────────────┘
```

---

## Actual Transaction Example

When you weigh ingredients and capture:

### Input Data:
```
Recipe: "Cookie Dough"
Ingredient: "Flour"
Target Weight: 500.00 g
Recorded Weight: 502.45 g
Tolerance: 3%
Status: OK
```

### Preview Shows:
```
================================
         ACME BAKERY
    123 Main Street
================================

Batch: Cookie-012630
Time:  01/18/2026 02:35:12 PM

Item:  Flour

Target: 500.00 g
Actual: 502.45 g
Tol:    3.0%

Status: OK
Dev:    +2.45 g

================================
```

---

## Different Status Examples

### When Status = UNDER
```
Status: UNDER
Dev:    -8.75 g
```
Indicates weight is below target and tolerance minimum.

### When Status = OK
```
Status: OK
Dev:    +2.30 g
```
Indicates weight is within acceptable tolerance range.

### When Status = OVER
```
Status: OVER
Dev:    +12.50 g
```
Indicates weight exceeds target and tolerance maximum.

---

## Header Customization Examples

### Default Header
```
COMPANY NAME
Addr • Tel
```

### Bakery Example
```
SWEET DELIGHTS BAKERY
123 Baker Street, NY 10001
(212) 555-0100
```

### Manufacturing Example
```
PRECISION PARTS INC.
Quality Control Division
Batch Record Label
```

### Lab Example
```
CHEMICAL RESEARCH LAB
Building A, Room 205
Date: 01/18/2026
```

---

## Paper Width Impact

### 24 Characters (Narrow Printer)
```
════════════════════════
   COMPANY NAME
   Addr • Tel
════════════════════════

Batch: RECIPE-010101
Time: 01/18/2026 2:30 PM
Item: Ingredient Name

Target: 1000.00 g
Actual: 1005.30 g
```

### 32 Characters (Standard - DEFAULT)
```
================================
         COMPANY NAME
         Addr • Tel
================================

Batch: RECIPE-010101
Time: 01/18/2026 02:30 PM
Item: Ingredient Name

Target: 1000.00 g
Actual: 1005.30 g
```

### 40 Characters (Wide Printer)
```
════════════════════════════════════════
               COMPANY NAME
               Addr • Tel
════════════════════════════════════════

Batch: RECIPE-010101
Time: 01/18/2026 02:30 PM
Item: Ingredient Name

Target: 1000.00 g
Actual: 1005.30 g
```

---

## User Interaction Flow

```
START
  │
  ├─→ Click 🖨️ Test Print Button
  │   │
  │   ├─→ Preview Window Opens
  │   │   │
  │   │   ├─→ User Reviews Format
  │   │   │
  │   │   ├─→ Click 🖨️ Print Ticket
  │   │   │   │
  │   │   │   ├─→ (Printer connected?) ✓
  │   │   │   │   │
  │   │   │   │   ├─→ Send to printer in background
  │   │   │   │   │
  │   │   │   │   ├─→ Show "Print Job Sent"
  │   │   │   │   │
  │   │   │   │   └─→ Close preview
  │   │   │   │
  │   │   │   └─→ (Printer NOT connected?) ✗
  │   │   │       │
  │   │   │       └─→ Show "Printer Disconnected" warning
  │   │   │
  │   │   ├─→ Click 📋 Copy Text
  │   │   │   │
  │   │   │   ├─→ Copy to clipboard
  │   │   │   │
  │   │   │   └─→ Show "Copied" confirmation
  │   │   │
  │   │   └─→ Click Close
  │   │       │
  │   │       └─→ Close preview
  │   │
  │   └─→ Preview closes
  │
  ├─→ Configure Actual Weighing
  │   │
  │   ├─→ Load Recipe
  │   │
  │   ├─→ Enable auto-print ☑
  │   │
  │   └─→ Start Batch
  │
  ├─→ Weigh Ingredients
  │   │
  │   ├─→ Place ingredient
  │   │
  │   ├─→ Click Capture Now
  │   │
  │   ├─→ (Auto-print enabled?) ✓
  │   │   │
  │   │   ├─→ Record in CSV
  │   │   │
  │   │   ├─→ Format ticket with real data
  │   │   │
  │   │   └─→ Send to printer (background)
  │   │
  │   └─→ Move to next ingredient
  │
  └─→ END
```

---

## Clipboard Text Format

When copying preview text, the clipboard contains:

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

This can be pasted into:
- Email
- Text files (.txt)
- Word documents
- Spreadsheets
- Chat applications
- Any document editor

---

## Color Scheme

```
Window Background:    White/Light Gray
Text Color:          Black (monospace)
Header Bar:          Light Gray (#f0f0f0)
Buttons:
  - Print:           Green (#4CAF50)
  - Copy:            Blue (#2196F3)
  - Close:           Gray (#9E9E9E)
Text Widget:         White background, black text
Scrollbar:           Standard system theme
```

---

## Responsive Behavior

### Small Screen (< 500px width)
Window adjusts but maintains minimum 450px width

### Large Screen (> 800px width)
Window opens at comfortable 450px width (doesn't over-expand)

### Mobile/Tablet
Preview window remains usable at any size

---

## Accessibility Features

- Button labels are clear and descriptive
- Emoji icons aid quick visual identification
- Monospace font ensures character alignment
- Scrollbar for long previews
- Keyboard navigation supported (Tab, Enter, Escape)
- High contrast text on background
