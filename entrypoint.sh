#!/usr/bin/env bash

set -e

function die() {
  message="$1"

  echo "$message"
  echo 'exiting with error'
  exit 1
}

[[ -n "$CRON_EXPRESSION" ]] || die 'please specify CRON_EXPRESSION'
[[ -d "/backup" ]] || die 'please mount backup folder to /backup'
[[ -n "$AWS_ACCESS_KEY_ID" ]] || 'please specify AWS_ACCESS_KEY_ID'
[[ -n "$AWS_SECRET_ACCESS_KEY" ]] || 'please specify AWS_SECRET_ACCESS_KEY'
[[ -n "$AWS_ENDPOINT" ]] || 'please specify AWS_ENDPOINT'
[[ -n "$S3_BUCKET" ]] || 'please specify S3_BUCKET'
[[ -n "$S3_BUCKET_PREFIX" ]] || 'please specify S3_BUCKET_PREFIX'

echo "$CRON_EXPRESSION /app/backup.sh" > /etc/crontabs/root
echo "# crontab requires an empty line at the end of the file" >> /etc/crontabs/root

crontab /etc/crontabs/root

crond -f
