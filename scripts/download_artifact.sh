#! /bin/bash

if [[ "${BUILDKITE}" == "true" ]]
then
  if [[ "$2" == "s3" ]]
  then
    basedir=$(dirname $1)
    mkdir -p $basedir
    aws s3 cp s3://blockchaintech-build-artifacts/buildkite/${UPSTREAM_BUILDKITE_PIPELINE_SLUG}/${BUILDKITE_BRANCH}/${BUILDKITE_COMMIT}/$1 ${basedir}
    [ $? -ne 0 ] && echo "Error fetching artifact from s3..." >&2 && exit 1
  else
    buildkite-agent artifact download $1 .
    [ $? -ne 0 ] && echo "Error fetching artifact..." >&2 && exit 1
  fi
fi

exit 0
