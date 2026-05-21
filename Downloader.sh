#!/bin/bash

if ! command -v yt-dlp &> /dev/null; then
    echo "[!] Ошибка: yt-dlp не установлен."
    echo "Установите его командой: sudo apt install yt-dlp (или через pip: pip install yt-dlp)"
    exit 1
fi

if ! command -v ffmpeg &> /dev/null; then
    echo "[!] Ошибка: ffmpeg не установлен (нужен для MP3)."
    echo "Установите его командой: sudo apt install ffmpeg"
    exit 1
fi

while true; do
    clear
    echo "=========================================="
    echo "    УНИВЕРСАЛЬНЫЙ УСТАНОВЩИК (LINUX)"
    echo "=========================================="
    echo ""
    read -p "Вставь ссылку на ТРЕК или ПЛЕЙЛИСТ и нажми Enter: " url
    echo ""
    echo "[!] Начинаю скачивание..."
    echo ""

    yt-dlp -x --audio-format mp3 --audio-quality 0 --add-metadata --embed-thumbnail --yes-playlist -o "%(playlist_title,playlist)s/%(title)s.%(ext)s" "$url"

    echo ""
    echo "[+] Готово! Всё разложено по папкам плейлистов."
    echo "======================================================="
    echo ""

    read -p "Хочешь скачать что-то ещё? (Y - да, N - закрыть): " choice
    if [[ "$choice" != "Y" && "$choice" != "y" && "$choice" != "Н" && "$choice" != "н" ]]; then
        break
    fi
done