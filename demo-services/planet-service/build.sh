#!/bin/bash

set -e

mvn wrapper:wrapper
./mvnw clean package
docker build -t beyla-demo/planet-service .
