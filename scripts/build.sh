#! /bin/bash

set -euo pipefail

echo "--- build application"
yarn
yarn run build
yarn install --modules-folder build/node_modules --prod

echo "--- package up application into tarball"
mkdir -p target
(
  cd build
  tar czf ../target/app.tgz .
)
