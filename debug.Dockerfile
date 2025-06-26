FROM ghcr.io/project-osrm/osrm-backend:v6.0.0

ARG PBF_FILE

WORKDIR /data

COPY ${PBF_FILE} /data/area.osm.pbf

RUN osrm-extract -p /opt/car.lua /data/area.osm.pbf
RUN osrm-partition /data/area.osrm
RUN osrm-customize /data/area.osrm

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "mld", "/data/area.osrm"]
