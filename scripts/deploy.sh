#! /bin/bash

set -euo pipefail

echo "--- upload specification file to s3"
cat ./deployment/${ENVIRONMENT}-specification.json | \
  docker-compose run --rm -e APP_NAME -e AWS_ACCOUNT_PREFIX \
    -e DOCKER_IMAGE -e ENVIRONMENT -e OWNER -e PROJECT -e COMMIT \
    build-helper envsubst 2>/dev/null | \
  aws s3 cp --sse AES256 - s3://blockchaintech-build-artifacts/shared/${PROJECT}/${ENVIRONMENT}/${APP_NAME}/${COMMIT}/deployment/specification.json

cat << EOF | buildkite-agent pipeline upload
steps:
- label: "${PROJECT}-${APP_NAME}-${ENVIRONMENT}: ${BUILDKITE_MESSAGE}"
  trigger: "bct-deploy-services"
  build:
    branch: v1
    env:
      APP_NAME: "${APP_NAME}"
      AWS_ACCOUNT: "${AWS_ACCOUNT_PREFIX}-${ENVIRONMENT}"
      COMMIT: "${COMMIT}"
      ENVIRONMENT: "${ENVIRONMENT}"
      OWNER: "${OWNER}"
      PROJECT: "${PROJECT}"
      AWS_ACCOUNT_PREFIX: "${AWS_ACCOUNT_PREFIX}"
EOF
