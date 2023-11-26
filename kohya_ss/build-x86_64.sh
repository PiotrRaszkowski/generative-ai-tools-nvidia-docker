#!/usr/bin/env bash
docker build -t piotrraszkowski/kohya_ss-nvidia-docker --build-arg BUILD_VERSION=x86_64 --progress=plain .