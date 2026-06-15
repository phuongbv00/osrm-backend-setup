## OSRM Setup

This project provides a unified Dockerfile to build OSRM backend for different regions using build arguments.

### Prerequisites

If you are using Docker Desktop (macOS or Windows), provide at least x GB of RAM in Settings → Resources → Memory (x
follows --memory).

### Build Instructions

The Dockerfile accepts a `MAP_URL` build argument to specify which OpenStreetMap data to download.

#### Vietnam

```shell
docker build --memory=16g \
  --build-arg MAP_URL=https://download.geofabrik.de/asia/vietnam-latest.osm.pbf \
  -t osrm-backend:v26.6.5-debian-vietnam .
```

```shell
docker run -d -p 5000:5000 osrm-backend:v26.6.5-debian-vietnam
```

#### Japan

```shell
docker build --memory=32g \
  --build-arg MAP_URL=https://download.geofabrik.de/asia/japan-latest.osm.pbf \
  -t osrm-backend:v26.6.5-debian-japan .
```

```shell
docker run -d -p 5000:5000 osrm-backend:v26.6.5-debian-japan
```

#### Kanto

```shell
docker build --memory=16g \
  --build-arg MAP_URL=https://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf \
  -t osrm-backend:v26.6.5-debian-kanto .
```

```shell
docker run -d -p 5000:5000 osrm-backend:v26.6.5-debian-kanto
```

#### Other Region

You can build for any region available on [Geofabrik](https://download.geofabrik.de/):

```shell
MAP_URL=<MAP_URL>
REGION_NAME=<REGION_NAME>
```

```shell
docker build --memory=16g \
  --build-arg MAP_URL="$MAP_URL" \
  -t "osrm-backend:v26.6.5-debian-$REGION_NAME" .
```

```shell
docker run -d -p 5000:5000 "osrm-backend:v26.6.5-debian-$REGION_NAME"
```
