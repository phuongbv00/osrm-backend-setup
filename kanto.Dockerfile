FROM ghcr.io/project-osrm/osrm-backend:v6.0.0

WORKDIR /data

RUN wget -O /data/area.osm.pbf http://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf

RUN osrm-extract -p /opt/car.lua /data/area.osm.pbf
RUN osrm-partition /data/area.osrm
RUN osrm-customize /data/area.osrm

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "mld", "/data/area.osrm"]