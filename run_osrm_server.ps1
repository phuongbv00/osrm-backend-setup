param(
    [int]$PORT = 5000,
    [string]$OSRM_NAME = "kanto-latest",
    [string]$DATA_DIR = "$PWD/osrm-data"
)

if (-not (Test-Path $DATA_DIR)) {
    Write-Error "Directory not found: $DATA_DIR"
    exit 1
}

Set-Location $DATA_DIR

Write-Host "Starting OSRM server on port $PORT..."
docker run -it -p "${PORT}:5000" -v "$DATA_DIR:/data" `
  ghcr.io/project-osrm/osrm-backend `
  osrm-routed --algorithm mld "/data/$OSRM_NAME.osrm"