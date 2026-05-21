@echo off
chcp 65001 > nul

if not exist "yt-dlp.exe" (
    echo [!] Локальный yt-dlp.exe не найден. Качаю рабочую версию...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe' -OutFile 'yt-dlp.exe'"
    cls
)

if not exist "ffmpeg.exe" (
    echo [!] Локальный FFmpeg не найден (нужен для MP3). 
    echo [!] Скачиваю облегченную сборку, подожди чуть-чуть...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip' -OutFile 'ffmpeg.zip'"
    echo [!] Распаковываю файлы...
    powershell -Command "Expand-Archive -Path 'ffmpeg.zip' -DestinationPath 'ffmpeg_temp' -Force"
    powershell -Command "Get-ChildItem -Path 'ffmpeg_temp' -Filter 'ffmpeg.exe' -Recurse | Move-Item -Destination '.'"
    powershell -Command "Remove-Item -Path 'ffmpeg.zip', 'ffmpeg_temp' -Recurse -Force"
    cls
)

:loop
cls
echo ================================
echo     УНИВЕРСАЛЬНЫЙ УСТАНОВЩИК
echo ================================
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
