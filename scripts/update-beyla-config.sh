#!/bin/sh

kubectl delete -f ./deploy/beyla.yaml
kubectl delete configmap beyla-config
kubectl create configmap beyla-config --from-file=./deploy/beyla-config.yaml
kubectl apply -f ./deploy/beyla.yaml
