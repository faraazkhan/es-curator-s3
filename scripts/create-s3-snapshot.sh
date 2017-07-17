#!/bin/bash -e

function wait_for_es() {
  until curl --fail -k $ES_HOST:$ES_PORT/_cluster/health; do
    echo "waiting for elasticsearch service to be available"
    sleep 2
  done
  echo "Elastic search is reporting healthy...proceeding"
}

function create_es_snapshot() {
 S3_SNAPSHOT_URL="http://$ES_HOST:$ES_PORT/_snapshot/s3-backup?verify=false"
 curl -XPUT $S3_SNAPSHOT_URL -d '
 {"type": "s3",
 "settings": {
 "bucket": $S3_BUCKET_NAME,
 "region": $AWS_REGION,
 }}'
}

wait_for_es
create_es_snapshot
