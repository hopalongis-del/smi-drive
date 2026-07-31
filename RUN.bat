@echo off
cd /d "%~dp0"
echo Starting Forza Racer at http://127.0.0.1:8765
echo Close this window to stop the server.
start "" "http://127.0.0.1:8765/index.html"
python -m http.server 8765
