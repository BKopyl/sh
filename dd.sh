#!/bin/bash
TOKEN=$(aws secretsmanager get-secret-value --secret-id github/token --query SecretString --output text)
REPO_URL="https://raw.githubusercontent.com/username/repository/branch/script.sh"
curl -H "Authorization: token ${TOKEN}" -o /path/to/script.sh $REPO_URL
bash /path/to/script.sh
