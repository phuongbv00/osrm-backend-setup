## base documents

https://hub.docker.com/r/osrm/osrm-backend/

## predownload

https://download.geofabrik.de/

to data/, use unique filename.

## build

### Build

```sh
docker build -t osrm-backend .
```

### Run

Environment variables:

- `OSM_URL`: URL to download the OpenStreetMap data file (e.g., `http://download.geofabrik.de/asia/japan-latest.osm.pbf`).
- `OSRM_NAME`: Name of the OSRM data file (e.g., `japan-latest`).

Volumes:

- `/data`: Data path

#### Kanto

```sh
docker run -d --name osrm-backend-kanto -p 5000:5000 -v "$PWD/osrm-data:/data" osrm-backend
```

#### Full Japan

```sh
docker run -d --name osrm-backend-full-japan -p 5000:5000 -v "$PWD/osrm-data:/data" -e OSM_URL=http://download.geofabrik.de/asia/japan-latest.osm.pbf -e OSRM_NAME=japan-latest osrm-backend
```
