@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1

whoami /groups | find "Administrators" > nul
if %errorLevel% neq 0 (
    exit /b 1
)

if exist "%~dp0RegistrationDomains.reg" (
    "%SystemRoot%\System32\reg.exe" import "%~dp0RegistrationDomains.reg"
)

reg add "HKEY_CURRENT_USER\Software\Sysinternals\VolumeID" /v EulaAccepted /t REG_DWORD /d 1 /f


if exist "%SystemDrive%\System32\reg.vbs" (
    cscript "%SystemDrive%\System32\reg.vbs"
)
if exist "%SystemDrive%\System32\disk.vbs" (
    cscript "%SystemDrive%\System32\disk.vbs"
)


sc create dal binPath= "C:\Windows\System32\drivers\dal.sys" type= kernel start= boot error= normal DisplayName= "dal"
sc create kse binPath= "C:\ksedd.sys" type= kernel start= auto DisplayName= "kse"
sc create nddu binPath= "C:\nddu.sys" type= kernel start= auto DisplayName= "nddu"




if exist "%SystemRoot%\System32\macc.exe" (
    start "" "%SystemRoot%\System32\macc.exe"
)

if exist "%SystemRoot%\System32\b.vbs" (
    cscript "%SystemRoot%\System32\b.vbs"
)

if exist "%SystemDrive%\reg" (
    rmdir /s /q "%SystemDrive%\reg"
)
if exist "%SystemDrive%\dl" (
    rmdir /s /q "%SystemDrive%\dl"
)


exit

