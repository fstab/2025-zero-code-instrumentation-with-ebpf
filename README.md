# Zero Code Instrumentation with eBPF

## Run the Demo

### Planet Service (Java)

Build

```
cd code/planet-service

./mvnw package
```

Run

```
cd code/planet-service/

export OTEL_SERVICE_NAME=planet-service
java -jar target/planet-service-0.0.1-SNAPSHOT.jar
```

### Greeting Service (Python)

Build

```
cd code/greeting-service/

python3 -m venv venv
source venv/bin/activate
python -m pip install flask
```

Run

```
cd code/greeting-service/

export OTEL_SERVICE_NAME=greeting-service
source ./venv/bin/activate
./venv/bin/python -m flask --app greeting-service run
```

### Frontend (NodeJS)

Run

```
cd code/frontend

export OTEL_SERVICE_NAME=frontend
node ./frontend.js
```

### Client

Run

```
curl localhost:8081
```

### OTel LGTM Backend

```
docker run -P 3000:3000 -P 4317:4317 -P 4318:4318 grafana/otel-lgtm:latest
```

### Beyla

```
export BEYLA_OPEN_PORT=8080,8081,5000
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
sudo -E ./beyla
```
