FROM ghcr.io/project-osrm/osrm-backend:v6.0.0

ARG PBF_FILE

RUN wget https://download.geofabrik.de/asia/japan-latest.osm.pbf data/area.osm.pbf

RUN osrm-extract -p /opt/car.lua data/area.osm.pbf
RUN osrm-partition data/area.osrm
RUN osrm-customize data/area.osrm

EXPOSE 5000

