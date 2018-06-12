#!/usr/bin/env bash

set -euo pipefail

## Create repository if not existent
echo "--- create ECR repository for ${APP_NAME}"
aws ecr describe-repositories --repository-name ${APP_NAME} >/dev/null || \
    aws ecr create-repository --repository-name ${APP_NAME} >/dev/null || exit 1

aws ecr set-repository-policy --repository-name ${APP_NAME} \
    --policy-text file://./scripts/ecr_repo_permissions.json

echo "--- :docker: :aws: Push the docker image ${DOCKER_IMAGE}"
docker push "${DOCKER_IMAGE}"
