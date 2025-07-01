#!/bin/sh

kubectl delete -f ./deploy/load-generator.yaml
kubectl delete configmap load-generator
kubectl create configmap load-generator --from-file=./deploy/load-generator.js
kubectl apply -f ./deploy/load-generator.yaml
