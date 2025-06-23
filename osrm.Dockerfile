ARG OSM_URL=http://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf
ARG OSRM_NAME=kanto-latest

FROM ghcr.io/project-osrm/osrm-backend

ARG OSM_URL
ARG OSRM_NAME

RUN apk add --no-cache wget
RUN wget ${OSM_URL} -O ${OSRM_NAME}.osm.pbf

# Prepare data
RUN osrm-extract -p /opt/car.lua ${OSRM_NAME}.osm.pbf
RUN osrm-partition /data/${OSRM_NAME}.osrm
RUN osrm-customize /data/${OSRM_NAME}.osrm

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "mld", "/data/${OSRM_NAME}.osrm"]
