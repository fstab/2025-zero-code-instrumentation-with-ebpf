# Zero Code Instrumentation with eBPF

## Prerequisites

- Java
- Maven

## Setup

The following script will create a kind cluster and deploy the demo there.

```
./scripts/run.sh
```

Now, run the following command to expose port 3000 of the Grafana Pod on localhost:

```
kubectl port-forward $(kubectl get pods -lapp=grafana -o=name) 3000:3000
```

Access Grafana on http://localhost:3000. Default username is _admin_ with password _admin_.

Click on Dashboards (menu on the left) -> RED metrics (list of dashboards) to view an example RED metrics dashboard.

Click on Explore (menu on the left) to explore Prometheus metrics, Tempo traces, and the Tempo service graph.
