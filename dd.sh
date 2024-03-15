#!/bin/bash

TARGET_DIR="$1"
MAIN_BRANCH="$2"
SCRIPT_NAME="$3"
GITHUB_TOKEN="$4"

wget --header="Authorization: token $GITHUB_TOKEN" -O "$TARGET_DIR/$SCRIPT_NAME" https://raw.githubusercontent.com/BKopyl/ml-cluster/main/s3-mount.sh
if [ $? -eq 0 ]; then
    chmod +x "$TARGET_DIR/$SCRIPT_NAME"
    bash "$TARGET_DIR/$SCRIPT_NAME"
else
    echo "Ошибка при скачивании $SCRIPT_NAME с GitHub."
fi
