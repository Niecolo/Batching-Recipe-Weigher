# Persistence System - User Guide

## What This Means For You

**Every change you make in the app is automatically saved.**

No more "Save" buttons. No more lost work. When you close the app and reopen it tomorrow, everything is exactly as you left it.

## What Gets Saved Automatically

### 1. **Your Settings** ✅ Auto-Saved
- Display units (grams, kilograms, pounds)
- Tolerance percentage
- Printer configuration
- Serial port settings
- Everything you've configured

### 2. **Your Recipes** ✅ Auto-Saved
- Recipe names
- All ingredients in each recipe
- Target weights
- Tolerance overrides
- Any changes you make

### 3. **Batch Progress** ✅ Auto-Saved
- Current batch status
- Which ingredient you're on
- Weights you've captured so far
- Status of each item (complete, pending, etc.)

### 4. **All Past Transactions** ✅ Auto-Saved
- Every weight you've ever captured
- Can export and review anytime

## When Auto-Save Happens

### Instantly (Real-Time):
- Change display units → Saved immediately
- Adjust tolerance → Saved immediately
- Modify printer settings → Saved immediately
- Any setting change → Saved in < 1 second

### On Action:
- Add ingredient to recipe → Saved
- Edit ingredient details → Saved
- Delete ingredient → Saved
- Capture weight → Saved
- Navigate to next item → Saved
- Clear recipe → Saved

### On Exit:
- Close the app → All remaining state saved
- Crash (power loss) → Last saved state preserved

## Example Scenarios

### Scenario 1: Change Printer Settings
```
1. Click settings
2. Change printer COM port
3. Change baud rate
4. Change header text
   → All changes automatically saved ✅
   → Close and reopen app
   → All settings still there ✅
```

### Scenario 2: Create and Use a Recipe
```
1. Create recipe "Cookies"
2. Add ingredients: Flour (500g), Sugar (300g)
   → Recipe automatically saved ✅
3. Close app
4. Reopen app next week
5. Recipe "Cookies" still there with all ingredients ✅
```

### Scenario 3: Incomplete Batch
```
1. Start batch with recipe "Cookies"
2. Capture weight for Flour (500g) ✅
3. Oops, app crashes during Sugar measurement
4. Close app without saving progress
   → Batch progress automatically saved ✅
5. Reopen app
6. Click "Resume Batch" 
7. Flour already captured, ready for Sugar ✅
```

### Scenario 4: Long Batching Session
```
1. Start "Madagascar" batch Monday
2. Capture 10 ingredients throughout day
   → After each capture: Auto-saved ✅
3. Close app Monday night
4. Reopen Tuesday morning
5. Click "Resume Madagascar"
6. Still on correct ingredient ✅
7. All captured weights still there ✅
8. All past transactions visible ✅
```

## Files Being Saved

All files go to: `C:\ProgramData\Batching Recipe\`

```
📁 Batching Recipe
├── 📄 user_settings.json          (Your settings)
├── 📄 recipes.json                (All your recipes)
├── 📄 batch_states.json           (Current batch progress)
├── 📄 batch_transactions.csv      (All past transactions)
└── 📄 batch_app.log              (Application log)
```

You can access these files from Windows File Explorer for backup.

## What NOT to Do

❌ **DON'T manually save** - It happens automatically
❌ **DON'T use file explorer to edit JSON files** - Use the app
❌ **DON'T copy settings from other users** - Just use the app UI
✅ **DO** Let the app auto-save everything
✅ **DO** Make changes through the UI
✅ **DO** Trust that it's saved

## Verification

To verify auto-save is working:

1. **Settings Test**:
   - Change display units to "kg"
   - Close app (Ctrl+W or X button)
   - Reopen app
   - Display units still "kg" ✅

2. **Recipe Test**:
   - Create recipe "Test"
   - Add ingredient "Test Item"
   - Close app
   - Reopen app
   - Recipe still there ✅

3. **Batch Test**:
   - Start a batch
   - Capture one weight
   - Close app
   - Reopen app
   - Click "Resume Batch"
   - Shows progress ✅

## Backup Your Data

Since everything is automatically saved, your data is safe in:

`C:\ProgramData\Batching Recipe\`

**Optional Backups**:
```
1. Copy entire "Batching Recipe" folder
2. Store in OneDrive, Google Drive, USB stick
3. Keep monthly archives
```

## Common Questions

**Q: What if I close without clicking save?**
A: It's already saved! App auto-saves on every change.

**Q: What if the app crashes?**
A: Last saved state is recovered. You might lose 1-2 seconds of unsaved changes max.

**Q: Can I export recipes?**
A: Yes, they're in `recipes.json` - can be backed up or shared.

**Q: Can I restore from backup?**
A: Yes, just replace files in `C:\ProgramData\Batching Recipe\`

**Q: Is my data secure?**
A: Yes, stored locally on your computer in protected system folder.

**Q: Do I need cloud storage?**
A: No, but you can backup files manually to cloud if desired.

## Summary

✅ **All changes auto-saved on every action**
✅ **Batch progress recovered if app closes**
✅ **Settings restored exactly as left**
✅ **Recipes never lost**
✅ **Transaction history complete**
✅ **No manual save needed**
✅ **100% reliable recovery**

**Just use the app normally. Everything is safe.**
