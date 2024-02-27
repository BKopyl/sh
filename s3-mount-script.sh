#!/bin/bash

BUCKET_NAME=$1
MOUNT_POINT=$2

which s3fs >/dev/null || {
    yum install -y s3fs
}

mkdir -p ${MOUNT_POINT}

s3fs ${BUCKET_NAME} ${MOUNT_POINT} -o allow_other -o use_cache=/tmp -o iam_role=auto
