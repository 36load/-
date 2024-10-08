@echo off

:: BatchGotAdmin
:-------------------------------------

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"


REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
powershell reset-physicaldisk *
:: Define file paths
Del "C:\Windows\Temp\currentSerials.txt"
mkdir "C:\Windows\Temp"
set "outputFile=C:\Windows\Temp\currentSerials.txt"
set "savedFile=C:\Windows\savedSerials.txt"

:: Check if savedSerials.txt does not exist
if not exist "%savedFile%" (
wmic diskdrive get serialnumber > "%savedFile%"
)

:: Use WMIC to get disk serial numbers and append to the file
wmic diskdrive get serialnumber > "%outputFile%"

exit