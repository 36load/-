@echo off
StartLocal

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

endlocal
exit