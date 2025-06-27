# Zero Code Instrumentation with eBPF

## Run the Demo

### Planet Service

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

### Greeting Service

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

### Frontend

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
