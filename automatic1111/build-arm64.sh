#!/usr/bin/env bash
docker build -t piotrraszkowski/automatic1111-nvidia-docker --build-arg BUILD_VERSION=arm64 --progress=plain .