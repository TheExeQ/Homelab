#!/usr/bin/env bash

set -e

tag=$1

if [[ -z "$tag" ]]; then
  tag="theexeq/helix-p4d:dev"
fi

docker build -t ${tag} --platform linux/amd64 .