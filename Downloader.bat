@echo off
chcp 65001 > nul

if not exist "yt-dlp.exe" (
    echo [!] Локальный yt-dlp.exe не найден. Качаю рабочую версию...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe' -OutFile 'yt-dlp.exe'"
    cls
)

ffmpeg -version >nul 2>&1
if errorlevel 1 goto install_ffmpeg
goto loop

:install_ffmpeg
echo [!] В системе не найден FFmpeg (нужен для конвертации в MP3).
echo [!] Устанавливаю его автоматически через winget...
echo.
winget install Gyan.FFmpeg -e --accept-package-agreements --accept-source-agreements
echo.
echo [+] Установка запущена.
echo [!] ВАЖНО: Перезапусти батник, чтобы система увидела FFmpeg!
pause
exit

:loop
cls
echo =================================
echo      УНИВЕРСАЛЬНЫЙ УСТАНОВЩИК
echo =================================
echo.

set /p url="Вставь ссылку на ТРЕК или ПЛЕЙЛИСТ и нажми Enter: "

echo.
echo [!] Начинаю скачивание...
echo.

"yt-dlp.exe" -x --audio-format mp3 --audio-quality 0 --add-metadata --embed-thumbnail --yes-playlist -o "%%(playlist_title,playlist)s/%%(title)s.%%(ext)s" "%url%"

echo.
echo [+] Готово! Всё разложено по папкам плейлистов.
echo =======================================================
echo.

set /p choice="Хочешь скачать что-то ещё? (Y - да, N - закрыть): "
if /i "%choice%"=="Y" goto loop
if /i "%choice%"=="Н" goto loop

exit
