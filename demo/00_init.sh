#!/bin/bash
set -x

docker pull busybox
docker image inspect busybox | jq
export DOCKER_DEMO_IMAGE=$(docker image inspect busybox | jq -r '.[].Id' | sed 's/sha256://')
export DOCKER_DEMO_IMAGE_LAYER=$(docker image inspect busybox | jq -r '.[].RootFS.Layers' | sed 's/sha256://')
