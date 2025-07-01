#!/bin/sh

kubectl delete -f ./deploy/grafana.yaml
kubectl delete configmap grafana-provisioning
kubectl delete configmap grafana-dashboards

kubectl create configmap grafana-provisioning --from-file=./deploy/grafana-datasources.yaml --from-file=./deploy/grafana-dashboards.yaml
kubectl create configmap grafana-dashboards --from-file=./deploy/grafana-dashboard-red-metrics.json
kubectl apply -f ./deploy/grafana.yaml
