#!/bin/bash

set -e

if command -v podman &>/dev/null; then
    podman build -t beyla-demo/frontend .
else
    docker build -t beyla-demo/frontend .
fi
