REM @echo off
setlocal enabledelayedexpansion

REM Define source files
set SOURCE1=resources\fonts\fonts.xml
set SOURCE2=resources\settings\settings.xml

REM Loop through matching folders
for /d %%D in (resources-*) do (
    if exist "%%D\fonts" (
        echo Copying to %%D\fonts
        copy /Y "%SOURCE1%" "%%D\fonts\"
    )
)