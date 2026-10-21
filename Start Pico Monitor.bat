@echo off
cd /d "%~dp0"
echo === Simarine Pico Monitor ===
echo.
docker info >nul 2>&1
if errorlevel 1 (
  echo Docker Desktop is not running. Please start Docker Desktop, wait for it to
  echo finish loading, then run this again.
  pause & exit /b 1
)
if not exist .env (
  copy /y .env.example .env >nul
  for /f %%i in ('powershell -NoProfile -Command "[guid]::NewGuid().ToString('N')+[guid]::NewGuid().ToString('N')"') do set TOKEN=%%i
  powershell -NoProfile -Command "(Get-Content .env) -replace '^INFLUX_TOKEN=.*','INFLUX_TOKEN=%TOKEN%' | Set-Content -Encoding ascii .env"
  set /p SERIAL="Enter your Simarine Pico2 serial number: "
  powershell -NoProfile -Command "(Get-Content .env) -replace '^PICO_SERIAL=.*','PICO_SERIAL=%SERIAL%' | Set-Content -Encoding ascii .env"
  echo Saved. Tip: change the passwords in the .env file later.
)
echo Starting (first run builds images + auto-discovers your devices, a few minutes)...
docker compose up -d
if errorlevel 1 ( echo Something went wrong. & pause & exit /b 1 )
echo Waiting for the dashboard...
timeout /t 25 >nul
start http://localhost:3000
echo Done!  Dashboard: http://localhost:3000
pause
