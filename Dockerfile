FROM maptiler/tileserver-gl

USER root

ENV WORK=/
ENV DATA_DIR=${WORK}data

RUN mkdir -p ${DATA_DIR}
WORKDIR ${WORK}

RUN apt-get update -y && apt-get install -y wget git

COPY . ${WORK}

# COMMENT IF USING LOCAL STYLES
RUN npm install && node generateStyles.js 

# COMMENT IF USING LOCAL TILES
RUN wget https://hslstoragekarttatuotanto.blob.core.windows.net/openmaptiles/tiles.mbtiles -q -t 3 -O ${DATA_DIR}/finland.mbtiles

EXPOSE 8080