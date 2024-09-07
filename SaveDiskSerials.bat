@echo off

:: Check for administrative rights
>nul 2>&1 set "a=%~f0"
if '%errorlevel%' neq '0' (
  echo Requesting administrative privileges...
  powershell -Command "Start-Process cmd -ArgumentList '/c %~f0 %*' -Verb RunAs"
  exit /b
)

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