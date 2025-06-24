#!/bin/sh
set -e

OSM_URL=${OSM_URL:-http://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf}
OSRM_NAME=${OSRM_NAME:-kanto-latest}

OSM_FILE="/data/${OSRM_NAME}.osm.pbf"
OSRM_PATH="/data/${OSRM_NAME}.osrm"

echo "===> [INFO] Using OSM file: $OSM_FILE"
echo "===> [INFO] OSRM base path: $OSRM_PATH"

if [ ! -f "$OSM_FILE" ]; then
  echo "===> [BOOTSTRAP] Downloading OSM extract from $OSM_URL..."
  wget -O "$OSM_FILE" "$OSM_URL"
else
  echo "===> [BOOTSTRAP] OSM file already exists. Skipping download."
fi

if ls "${OSRM_PATH}"* 1> /dev/null 2>&1; then
  echo "===> [BOOTSTRAP] Found existing OSRM files. Skipping preprocessing."
else
  echo "===> [BOOTSTRAP] Running osrm-extract..."
  osrm-extract -p /opt/car.lua "$OSM_FILE"

  echo "===> [BOOTSTRAP] Running osrm-partition..."
  osrm-partition "$OSRM_PATH"

  echo "===> [BOOTSTRAP] Running osrm-customize..."
  osrm-customize "$OSRM_PATH"
fi

echo "===> [BOOTSTRAP] Starting osrm-routed..."
exec osrm-routed --algorithm mld "$OSRM_PATH"