#!/bin/bash

# Пример аргументов
# $1 - TARGET_DIR
# $2 - REPO_URL
# $3 - MAIN_BRANCH
# $4 - SCRIPT_PATH

TARGET_DIR="${1:-/home/ec2-user/ml-cluster}"
REPO_URL="${2:-git@github.com:BKopyl/ml-cluster.git}"
MAIN_BRANCH="${3:-main}"
SCRIPT_PATH="${4:-/home/ec2-user/ml-cluster/s3-run.sh}"

mkdir -p "$TARGET_DIR"

cd "$TARGET_DIR" || exit

if [ ! -d ".git" ]; then
    git init
fi

if git remote get-url origin &>/dev/null; then
    git remote set-url origin "$REPO_URL"
else
    git remote add origin "$REPO_URL"
fi

export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no"

git fetch

if git branch --list "$MAIN_BRANCH" &>/dev/null; then
    git checkout "$MAIN_BRANCH"
else
    git checkout -b "$MAIN_BRANCH" --track "origin/$MAIN_BRANCH"
fi

git pull

echo "Клонирование в $TARGET_DIR завершено."

if [ -f "$SCRIPT_PATH" ]; then
    bash "$SCRIPT_PATH"
else
    echo "Скрипт $SCRIPT_PATH не найден."
fi
