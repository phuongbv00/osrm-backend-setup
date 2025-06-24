FROM ghcr.io/project-osrm/osrm-backend:v6.0.0

WORKDIR /data

ENV OSM_URL=http://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf
ENV OSRM_NAME=kanto-latest

COPY bootstrap.sh /usr/local/bin/bootstrap.sh
RUN chmod +x /usr/local/bin/bootstrap.sh

EXPOSE 5000

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]