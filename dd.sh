#!/bin/bash

# Установка безопасных директорий для Git
git config --global --add safe.directory /home/ec2-user/ml-cluster

TARGET_DIR="$1"
REPO_URL="$2"
MAIN_BRANCH="$3"
SCRIPT_PATH="$4"
GITHUB_TOKEN="$5"

# Создание целевой директории
mkdir -p "$TARGET_DIR"

cd "$TARGET_DIR" || exit

# Инициализация Git репозитория, если необходимо
if [ ! -d ".git" ]; then
    git init
fi

# Настройка удаленного репозитория
if git remote get-url origin &>/dev/null; then
    git remote set-url origin "$REPO_URL"
else
    git remote add origin "$REPO_URL"
fi

export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no"

# Получение данных из репозитория
git fetch

# Переключение на основную ветку
if git branch --list "$MAIN_BRANCH" &>/dev/null; then
    git checkout "$MAIN_BRANCH"
else
    git checkout -b "$MAIN_BRANCH" --track "origin/$MAIN_BRANCH"
fi

git pull

echo "Клонирование в $TARGET_DIR завершено."

# Проверка и выполнение s3-run.sh
if [ -f "$SCRIPT_PATH" ]; then
    chmod +x "$SCRIPT_PATH"
    bash "$SCRIPT_PATH"
else
    echo "Скрипт $SCRIPT_PATH не найден."
fi
