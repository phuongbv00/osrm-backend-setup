param(
    [string]$OSM_URL = "http://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf",
    [string]$OSRM_NAME = "kanto-latest",
    [string]$DATA_DIR = "$PWD/osrm-data"
)

if (-not (Test-Path $DATA_DIR)) {
    New-Item -ItemType Directory -Path $DATA_DIR | Out-Null
}
Set-Location $DATA_DIR

Write-Host "Downloading $OSM_URL..."
docker run --rm -v "${DATA_DIR}:/data" alpine `
    sh -c "apk add --no-cache wget > /dev/null && wget -O /data/${OSRM_NAME}.osm.pbf ${OSM_URL}"

if (-not $? ) {
    Write-Error "Download failed"
    exit 1
}

Write-Host "Running osrm-extract..."
docker run --rm -v "${DATA_DIR}:/data" ghcr.io/project-osrm/osrm-backend `
    osrm-extract -p /opt/car.lua "/data/${OSRM_NAME}.osm.pbf"
if (-not $?) { exit 1 }

Write-Host "Running osrm-partition..."
docker run --rm -v "${DATA_DIR}:/data" ghcr.io/project-osrm/osrm-backend `
    osrm-partition "/data/${OSRM_NAME}.osrm"
if (-not $?) { exit 1 }

Write-Host "Running osrm-customize..."
docker run --rm -v "${DATA_DIR}:/data" ghcr.io/project-osrm/osrm-backend `
    osrm-customize "/data/${OSRM_NAME}.osrm"
if (-not $?) { exit 1 }

Write-Host "Data preparation complete: $DATA_DIR\$OSRM_NAME.osrm*"