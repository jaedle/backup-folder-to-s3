#!/usr/bin/env bash

set -eux -o pipefail

function cleanup() {
  if [[ -f "$TEMPORARY_FILE" ]]; then
    rm  "$TEMPORARY_FILE"
  fi
}

trap cleanup EXIT

TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"

TEMPORARY_FILE="$(mktemp)"
rm "$TEMPORARY_FILE"
zip -r "$TEMPORARY_FILE" /backup 

aws s3 --endpoint-url "$AWS_ENDPOINT" cp "$TEMPORARY_FILE" "s3://$S3_BUCKET/$S3_BUCKET_PREFIX/backup-$TIMESTAMP.zip"