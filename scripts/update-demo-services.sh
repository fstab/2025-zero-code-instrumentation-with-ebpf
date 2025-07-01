#!/bin/bash

make

kind load docker-image fosdem-2025/product-service
kind load docker-image fosdem-2025/inventory-service
kind load docker-image fosdem-2025/pricing-service

kubectl delete \
	-f ./deploy/inventory-service.yaml \
	-f ./deploy/pricing-service.yaml \
	-f ./deploy/product-service.yaml

kubectl apply \
	-f ./deploy/inventory-service.yaml \
	-f ./deploy/pricing-service.yaml \
	-f ./deploy/product-service.yaml
