#!/bin/bash

set -e

if ! kind create cluster ; then
    echo "Error: Kind cluster is already runnning. Please run 'kind delete cluster' before executing this script."
    exit 1
fi

for service in frontend greeting-service planet-service ; do
    echo
    echo "############################################################"
    echo "# Building $service"
    echo "############################################################"
    cd ./demo-services/$service
    ./build.sh
    cd ../..
    if command -v podman &>/dev/null; then
        rm -f images/beyla_demo_$service.tar 2>/dev/null
        podman save beyla-demo/$service -o images/beyla_demo_$service.tar
        kind load image-archive images/beyla_demo_$service.tar
    else
        kind load docker-image beyla-demo/$service
    fi
done

echo
echo "############################################################"
echo "# Loading upstream Docker images"
echo "############################################################"
for docker_image in prom/prometheus grafana/tempo grafana/k6 grafana/grafana grafana/beyla ; do
    echo "Loading $docker_image"
    if command -v podman &>/dev/null; then
        if ! podman image inspect $docker_image >/dev/null 2>&1 ; then
            podman pull $docker_image
        fi
        rm -f images/${docker_image//\//_}.tar 2>/dev/null
        podman save $docker_image -o images/${docker_image//\//_}.tar
        kind load image-archive images/${docker_image//\//_}.tar
    else
        if ! docker image inspect $docker_image >/dev/null 2>&1 ; then
            docker pull $docker_image
        fi
        kind load docker-image $docker_image
    fi
done

echo
echo "############################################################"
echo "# Deploying the demo"
echo "############################################################"
kubectl create configmap beyla-config --from-file=./deploy/beyla-config.yaml
kubectl create configmap prometheus-config --from-file=./deploy/prometheus-config.yaml
kubectl create configmap load-generator --from-file=./deploy/load-generator.js
kubectl create configmap grafana-provisioning --from-file=./deploy/grafana-datasources.yaml --from-file=./deploy/grafana-dashboards.yaml
kubectl create configmap grafana-dashboards --from-file=./deploy/grafana-dashboard-red-metrics.json
kubectl create configmap tempo-config --from-file=./deploy/tempo-config.yaml

kubectl apply \
	-f ./deploy/planet-service.yaml \
	-f ./deploy/greeting-service.yaml \
	-f ./deploy/frontend.yaml \
	-f ./deploy/beyla.yaml \
	-f ./deploy/prometheus.yaml \
	-f ./deploy/load-generator.yaml \
	-f ./deploy/grafana.yaml \
	-f ./deploy/tempo.yaml \

echo
echo 'Success!'
echo 'Please run the following command to expose Grafana on http://localhost:3000'
echo 'kubectl port-forward $(kubectl get pods -lapp=grafana -o=name) 3000:3000'
