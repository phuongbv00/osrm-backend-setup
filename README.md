### Build

```sh
docker build -f osrm.Dockerfile -t osrm-backend .
```

### Run

Environment variables:

- `OSM_URL`: URL to download the OpenStreetMap data file (e.g., `http://download.geofabrik.de/asia/japan-latest.osm.pbf`).
- `OSRM_NAME`: Name of the OSRM data file (e.g., `japan-latest`).

#### Kanto

```sh
docker run -d --name osrm-backend-kanto -p 5000:5000 -v "$PWD/osrm-data:/data" osrm-backend
```

#### Full Japan

```sh
docker run -d --name osrm-backend-full-japan -p 5000:5000 -v "$PWD/osrm-data:/data" -e OSM_URL=http://download.geofabrik.de/asia/japan-latest.osm.pbf -e OSRM_NAME=japan-latest osrm-backend
```
