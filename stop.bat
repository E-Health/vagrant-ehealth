ECHO OFF
cd /d %~dp0
for /f "tokens=2* delims= " %%F IN ('vagrant status ^| find /I "default"') DO (SET "STATE=%%F%%G")


IF "%STATE%" EQU "running" (
  ECHO Suspending Vagrant VM...
  vagrant suspend
) 

if errorlevel 1 (
  ECHO FAILURE! Vagrant VM unresponsive...
)

ECHO Close this window if it remains open.
