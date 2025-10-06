### Japan

```shell
docker buildx build --platform linux/amd64 -t osrm-backend:v6.0.0-japan -f japan.Dockerfile .
docker run -d -p 5000:5000 osrm-backend:v6.0.0-japan
```

### Kanto

```shell
docker buildx build --platform linux/amd64 -t osrm-backend:v6.0.0-kanto -f kanto.Dockerfile .
docker run -d -p 5000:5000 osrm-backend:v6.0.0-kanto
```

### Vietnam

```shell
docker buildx build --platform linux/amd64 -t osrm-backend:v6.0.0-vietnam -f vietnam.Dockerfile .
docker run -d -p 5000:5000 osrm-backend:v6.0.0-vietnam
```