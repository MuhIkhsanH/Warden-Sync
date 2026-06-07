@echo off
setlocal enabledelayedexpansion

set "CMD=%~1"

if "!CMD!"=="" (
    echo Usage: copy2code filename or copy2code back
    exit /b
)

if /i "!CMD!"=="back" goto :restore

set "FILE=!CMD!"
if exist "!FILE!" (
    set "NUM=1"
    :findnum
    if exist "!FILE!_!NUM!.bak" (
        set /a NUM+=1
        goto findnum
    )
    copy /Y "!FILE!" "!FILE!_!NUM!.bak" >nul
    echo [~] !FILE!_!NUM!.bak
)

powershell -NoProfile -Command "[System.IO.File]::WriteAllText('!FILE!', (Get-Clipboard -Raw), [System.Text.UTF8Encoding]::new($false))"
echo [v] !FILE!
exit /b

:restore
setlocal enabledelayedexpansion
set "IDX=0"
for /f "delims=" %%F in ('dir /b "*_*.bak" 2^>nul') do (
    set /a IDX+=1
    set "BAK[!IDX!]=%%F"
    echo [!IDX!] %%F
)

if !IDX!==0 (
    echo [x] No backups
    exit /b
)

set /p "PICK=Pick: "
set "FILE=!BAK[%PICK%]!"

for /f "tokens=1 delims=_" %%X in ("!FILE!") do set "ORIG=%%X"

copy /Y "!FILE!" "!ORIG!"
echo [v] !ORIG!
