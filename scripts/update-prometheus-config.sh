#!/bin/sh

kubectl delete -f ./deploy/prometheus.yaml
kubectl delete configmap prometheus-config
kubectl create configmap prometheus-config --from-file=./deploy/prometheus-config.yaml
kubectl apply -f ./deploy/prometheus.yaml
