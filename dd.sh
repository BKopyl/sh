#!/bin/bash
TOKEN=$(aws secretsmanager get-secret-value --secret-id github/token --query SecretString --output text)
REPO_URL="https://raw.githubusercontent.com/BKopyl/ml-cluster/main/s3-run.sh"
curl -H "Authorization: token ${TOKEN}" -o /path/to/script.sh $REPO_URL
bash /path/to/script.sh