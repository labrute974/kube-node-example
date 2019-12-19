#!/usr/bin/env bash

set -euo pipefail

echo "--- :docker: Push the docker image ${DOCKER_IMAGE}:${COMMIT}"
docker push "${DOCKER_IMAGE}:${COMMIT}"
