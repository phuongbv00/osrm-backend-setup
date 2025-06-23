#!/bin/sh

PORT=${1:-5000}
OSRM_NAME=${2:-kanto-latest}
DATA_DIR=${3:-$PWD/osrm-data}

cd "$DATA_DIR" || { echo "osrm-data/ directory not found"; exit 1; }

echo "Starting OSRM server on port ${PORT}..."
docker run -it -p ${PORT}:5000 -v "$DATA_DIR:/data" \
  ghcr.io/project-osrm/osrm-backend \
  osrm-routed --algorithm mld "/data/${OSRM_NAME}.osrm"
