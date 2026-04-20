# Recipe Batching Scale Application

Industrial grade recipe batching system with RS232 scale interface, serial port I/O and real-time weight monitoring.

[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Windows Compatible](https://img.shields.io/badge/Windows-10%2F11-green.svg)](https://www.microsoft.com/windows)

---

## ✨ Features

### Core Functionality
✅ **Real-time weight display** with live status indication
✅ **Recipe management system** - unlimited ingredients per recipe
✅ **Auto-advance logic** with refill cycle detection
✅ **Auto-advance minimum weight threshold**
✅ **Tare & Zero command support** (proper slow byte protocol)
✅ **Dual serial port operation** - Input scale + Alarm output
✅ **Automatic serial connection** on application startup
✅ **Negative weight support**
✅ **Full settings persistence** - all user settings saved automatically

### Control & Automation
✅ **3 status levels**: UNDER / OK / OVER
✅ **Visual status flashing indicators**
✅ **Hold time tolerance configuration**
✅ **Configurable tolerance percentage**
✅ **Auto-print after capture**
✅ **Batch total printing**
✅ **RS232 Alarm output with configurable intervals**
✅ **Continuous sound alarm with separate per-status toggles**

### Reporting & History
✅ **Transaction history viewer with search**
✅ **CSV logging for all transactions**
✅ **Excel export capability**
✅ **Batch summary generation**
✅ **Automatic transaction tickets**

---

## 🚀 Installation

### Prerequisites
- Windows 10 / 11
- Python 3.8 or higher
- Administrator privileges (required for serial port access)

### Install Dependencies
```bash
pip install -r requirements.txt
```

### Run Application
```bash
python BatchingApp.py
```

### Build Executable
```bash
build_exe.cmd
```

---

## ⚙️ System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| Operating System | Windows 10 | Windows 11 |
| CPU | 1 GHz Dual Core | 2 GHz Quad Core |
| RAM | 256 MB | 512 MB |
| Storage | 100 MB | 500 MB |
| Serial Ports | 1 | 2+ |

---

## 🔌 Serial Protocol

### Standard Control Commands
| Action | Command Sequence |
|--------|------------------|
| **TARE** | `0x05 <ENQ> + 'T' + 0x0D <CR>` |
| **ZERO** | `0x05 <ENQ> + 'Z' + 0x0D <CR>` |

> ℹ️ All commands are sent byte-by-byte with 3ms inter-byte delay for maximum scale compatibility

### Supported Scale Baud Rates
- 300, 600, 1200, 2400, 4800, **9600**, 14400, 19200, 38400, 57600, 115200 baud

---

## 📋 Operation

### Auto-advance Logic
1.  First detects weight **BELOW minimum threshold** (refill cycle)
2.  Then waits for weight to **rise into tolerance range**
3.  Applies hold time delay
4.  Automatically captures weight and advances to next ingredient

### Status Colour Codes
| Status | Colour | Description |
|--------|--------|-------------|
| **UNDER** | 🟡 Yellow | Weight below target minimum |
| **OK** | 🟢 Green | Weight within acceptable tolerance |
| **OVER** | 🔴 Red | Weight above target maximum |

---

## 🛠 Configuration

All settings are automatically saved in `app_data/user_settings.json` and persist across application restarts including:
- Serial port configurations
- All weighing control values
- Alarm and sound settings
- Printer configuration
- Simulated weight mode
- All user preferences

---

## 📄 License

MIT License - See LICENSE file for full details.

---

## 🤝 Support

For technical support, feature requests or bug reports please open an issue on GitHub.