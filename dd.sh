#!/bin/bash

TARGET_DIR="/home/ec2-user/ml-cluster"
REPO_URL="git@github.com:BKopyl/ml-cluster.git"

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

if git ls-remote --heads "$REPO_URL" main &>/dev/null; then
    MAIN_BRANCH="main"
elif git ls-remote --heads "$REPO_URL" master &>/dev/null; then
    MAIN_BRANCH="master"
else
    exit 1
fi

git fetch

if git branch --list "$MAIN_BRANCH" &>/dev/null; then
    git checkout "$MAIN_BRANCH"
else
    git checkout -b "$MAIN_BRANCH" --track "origin/$MAIN_BRANCH"
fi

git pull

echo "Клонирование в $TARGET_DIR завершено."

SCRIPT_PATH="/home/ec2-user/ml-cluster/s3-run.sh"
if [ -f "$SCRIPT_PATH" ]; then
    bash "$SCRIPT_PATH"
else
    echo "Скрипт $SCRIPT_PATH не найден."
fi
