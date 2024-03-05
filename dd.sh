#!/bin/bash

# Принимаемые аргументы
TARGET_DIR="$1"
MAIN_BRANCH="$2"
SCRIPT_NAME="$3"
GITHUB_TOKEN="$4"
SCRIPT_NAME="$5"

# Путь к скрипту для скачивания
SCRIPT_URL="https://raw.githubusercontent.com/BKopyl/ml-cluster/$MAIN_BRANCH/$SCRIPT_NAME"

# Скачивание скрипта с использованием токена для аутентификации
curl -H "Authorization: token $GITHUB_TOKEN" -L $SCRIPT_URL -o "$TARGET_DIR/$SCRIPT_NAME"

if [ $? -eq 0 ]; then
    echo "Скрипт $SCRIPT_NAME успешно скачан."
    chmod +x "$TARGET_DIR/$SCRIPT_NAME"
    # Выполнение скачанного скрипта
    "$TARGET_DIR/$SCRIPT_NAME"
else
    echo "Ошибка при скачивании $SCRIPT_NAME с GitHub."
fi
