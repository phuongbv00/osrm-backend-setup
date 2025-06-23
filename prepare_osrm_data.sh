#!/bin/sh

OSM_URL=${1:-http://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf}
OSRM_NAME=${2:-kanto-latest}
DATA_DIR=${3:-$PWD/osrm-data}

if [ ! -d "$DATA_DIR" ]; then
  mkdir "$DATA_DIR"
fi
cd "$DATA_DIR"

echo "Downloading ${OSM_URL}..."
docker run --rm -v "$DATA_DIR:/data" alpine \
  sh -c "apk add --no-cache wget > /dev/null && wget -O /data/${OSRM_NAME}.osm.pbf ${OSM_URL}" || { echo "Download failed"; exit 1; }

echo "Running osrm-extract..."
docker run --rm -v "$DATA_DIR:/data" ghcr.io/project-osrm/osrm-backend \
  osrm-extract -p /opt/car.lua "/data/${OSRM_NAME}.osm.pbf" || exit 1

echo "Running osrm-partition..."
docker run --rm -v "$DATA_DIR:/data" ghcr.io/project-osrm/osrm-backend \
  osrm-partition "/data/${OSRM_NAME}.osrm" || exit 1

echo "Running osrm-customize..."
docker run --rm -v "$DATA_DIR:/data" ghcr.io/project-osrm/osrm-backend \
  osrm-customize "/data/${OSRM_NAME}.osrm" || exit 1

echo "Data preparation complete: $DATA_DIR/${OSRM_NAME}.osrm*"
