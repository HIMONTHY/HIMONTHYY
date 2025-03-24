@echo off
:: Set folder name to hide/unhide
set "folder=C:\Users\icone\AppData\Local\Steam"

:: Check if folder exists
if not exist "%folder%" (
    echo Folder "%folder%" not found!
    pause
    exit
)

:: Check if folder is hidden
attrib "%folder%" | find "H" > nul
if %errorlevel% == 0 (
    attrib -s -h "%folder%"
    echo Folder is now visible.
) else (
    attrib +s +h "%folder%"
    echo Folder is now hidden.
)

pause
