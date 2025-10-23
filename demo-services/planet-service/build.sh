#!/bin/bash

set -e

mvn wrapper:wrapper
if command -v podman &>/dev/null; then
    podman build -t beyla-demo/planet-service .
else
    docker build -t beyla-demo/planet-service .
fi
