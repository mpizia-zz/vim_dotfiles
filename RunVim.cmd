@echo off
for /f %%i in ('vim --serverlist') do if "%%i"=="GVIM" set SERVER_EXIST=1
echo %SERVER_EXIST%

if defined SERVER_EXIST (gvim +%1 --remote-tab-silent %2) else (gvim +%1 %2)
