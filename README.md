### Prerequisites

If you are using Docker Desktop (macOS or Windows), provide at least x GB of RAM in Settings → Resources → Memory (x
follows --memory).

### Japan

```shell
docker build --platform linux/amd64 --memory=32g -t osrm-backend:v6.0.0-japan -f japan.Dockerfile .
docker run -d -p 5000:5000 osrm-backend:v6.0.0-japan
```

### Kanto

```shell
docker build --platform linux/amd64 --memory=16g -t osrm-backend:v6.0.0-kanto -f kanto.Dockerfile .
docker run -d -p 5000:5000 osrm-backend:v6.0.0-kanto
```

### Vietnam

```shell
docker build --platform linux/amd64 --memory=16g -t osrm-backend:v6.0.0-vietnam -f vietnam.Dockerfile .
docker run -d -p 5000:5000 osrm-backend:v6.0.0-vietnam
```