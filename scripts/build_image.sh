#!/usr/bin/env bash

set -euo pipefail

## Construct the docker image with tag
DOCKER_IMAGE=${DOCKER_IMAGE:-${APP_NAME}}

echo "--- :docker: Build image"
docker build --compress --force-rm --no-cache -t "${DOCKER_IMAGE}:${COMMIT}" .
