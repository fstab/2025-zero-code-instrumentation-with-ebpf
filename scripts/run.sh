#!/bin/bash

make

kind create cluster
kind load docker-image beyla-demo/planet-service
kind load docker-image beyla-demo/greeting-service
kind load docker-image beyla-demo/frontend
kind load docker-image fstab/beyla

kubectl create configmap beyla-config --from-file=./deploy/beyla-config.yaml
kubectl create configmap prometheus-config --from-file=./deploy/prometheus-config.yaml
kubectl create configmap load-generator --from-file=./deploy/load-generator.js
kubectl create configmap grafana-provisioning --from-file=./deploy/grafana-datasources.yaml --from-file=./deploy/grafana-dashboards.yaml
kubectl create configmap grafana-dashboards --from-file=./deploy/grafana-dashboard-red-metrics.json
kubectl create configmap tempo-config --from-file=./deploy/tempo-config.yaml
#
kubectl apply \
	-f ./deploy/planet-service.yaml \
	-f ./deploy/greeting-service.yaml \
	-f ./deploy/frontend.yaml \
	-f ./deploy/beyla.yaml \
	-f ./deploy/prometheus.yaml \
	-f ./deploy/load-generator.yaml \
	-f ./deploy/grafana.yaml \
	-f ./deploy/tempo.yaml \
