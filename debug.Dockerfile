FROM ghcr.io/project-osrm/osrm-backend:latest

ARG PBF_FILE

COPY ${PBF_FILE} data/area.osm.pbf

RUN osrm-extract -p /opt/car.lua data/area.osm.pbf
RUN osrm-partition data/area.osrm
RUN osrm-customize data/area.osrm

