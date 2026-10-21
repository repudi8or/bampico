@echo off
cd /d "%~dp0"
echo Stopping Pico monitor (your data is kept)...
docker compose down
pause
