# 🛡️ Warden Sync

> A Clipboard-to-Code utility with an automatic numbered backup system.  
> Write fast, stay safe, stay tracked — straight from clipboard to file.

---

## 📦 Project Structure

```
WARDEN_SYNC/
├── WARDEN/          ← main project folder
└── c2c.bat          ← core utility
```

---

## ⚡ c2c — Clipboard to Code

A batch script utility that grabs your clipboard content and saves it to a file, while **automatically creating numbered backups** every time the same file is overwritten.

### Usage

```bat
c2c <filename>
```

**Examples:**

```bat
c2c app.py
c2c index.html
c2c config.json
```

---

## 🔄 Backup Behavior

| Run | Condition | Result |
|---|---|---|
| `c2c app.py` — 1st time | File does not exist | `app.py` is created, no backup |
| `c2c app.py` — 2nd time | File already exists | `app.py(1).bak` created, then `app.py` is overwritten |
| `c2c app.py` — 3rd time | `(1).bak` already exists | `app.py(2).bak` created, then `app.py` is overwritten |
| And so on… | | Number increments automatically |

### Terminal Output Example

```
c:\Projects\myapp> c2c app.py
[v] OK - app.py created from clipboard.

c:\Projects\myapp> c2c app.py
[~] Backup created: app.py(1).bak
[v] OK - app.py created from clipboard.

c:\Projects\myapp> c2c app.py
[~] Backup created: app.py(2).bak
[v] OK - app.py created from clipboard.
```

---

## 📁 Backup Location

Backups are **always saved in the directory where the command is run** (your current working directory), not in the location of `c2c.bat` itself.

```
C:\Users\you\Downloads> c2c app.py
→ backup saved to C:\Users\you\Downloads\app.py(1).bak

C:\Projects\web> c2c app.py
→ backup saved to C:\Projects\web\app.py(1).bak
```

---

## 🔧 Installation

1. Save `c2c.bat` to any folder in your `PATH`, e.g. `C:\Tools\`
2. Add that folder to your `PATH` environment variable:
   - Open **System Properties** → **Environment Variables**
   - Under *System variables*, select `Path` → **Edit** → **New**
   - Enter the folder path (e.g. `C:\Tools`)
   - Click OK and restart your terminal
3. Done — `c2c` can now be called from any directory

---

## ✅ Technical Specs

- **Platform:** Windows (CMD / PowerShell)
- **Output encoding:** UTF-8 **without BOM** (safe for Python, JS, and more)
- **Backup format:** `filename.ext(N).bak`
- **Backup numbering:** auto-increments, never overwrites existing backups
- **Dependency:** PowerShell 5+ (built-in on Windows 10/11)

---

## 🛡️ Warden Sync
