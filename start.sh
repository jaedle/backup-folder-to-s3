#!/usr/bin/env bash

set -eux

source ".credentials.rc"

docker image build -t jaedle/backup-folder-to-s3:development .

docker container run \
  --rm \
  -it \
  -e 'CRON_EXPRESSION=* * * * *' \
  -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
  -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
  -e "AWS_ENDPOINT=$AWS_DEFAULT_ENDPOINT" \
  -e "S3_BUCKET=tryout" \
  -e "S3_BUCKET_PREFIX=enpass-backups" \
  --mount type=bind,src="$PWD/example-backup",dst="/backup",readonly \
  jaedle/backup-folder-to-s3:development
