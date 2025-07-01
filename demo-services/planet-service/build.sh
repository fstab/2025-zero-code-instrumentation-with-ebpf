#!/bin/bash

./mvnw clean package
docker build -t beyla-demo/planet-service .
