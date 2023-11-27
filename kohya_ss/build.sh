#!/usr/bin/env bash
export DOCKER_BUILDKIT=1
docker build --target kohya_ss -t piotrraszkowski/kohya_ss-nvidia-docker --build-arg BUILD_VERSION=x86_64 --progress=plain .