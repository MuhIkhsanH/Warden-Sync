@echo off
setlocal enabledelayedexpansion

set "FILENAME=%~1"

if "!FILENAME!" == "" (
    echo [?] Mana nama filenya? Contoh: c2c app.py
    exit /b
)

if exist "!FILENAME!" (
    goto :do_backup
)
goto :write_file

:do_backup
set "BAKNUM=1"
:find_next
if exist "!FILENAME!(!BAKNUM!).bak" (
    set /a BAKNUM+=1
    goto :find_next
)
copy /Y "!FILENAME!" "!FILENAME!(!BAKNUM!).bak" >nul
echo [~] Backup dibuat: !FILENAME!(!BAKNUM!).bak
goto :write_file

:write_file
powershell -NoProfile -Command "[System.IO.File]::WriteAllText('!FILENAME!', (Get-Clipboard -Raw), [System.Text.UTF8Encoding]::new($false))"

if exist "!FILENAME!" (
    echo [v] OK - !FILENAME! sudah dibuat dari clipboard.
) else (
    echo [x] Gagal. Clipboard mungkin kosong.
)
