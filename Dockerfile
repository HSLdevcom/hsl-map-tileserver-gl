FROM maptiler/tileserver-gl:v5.1.3
CMD [ "--public_url", "https://dev.kartat.hsl.fi/map/v3" ]

USER root

ENV WORK=/
ENV DATA_DIR=${WORK}data

RUN mkdir -p ${DATA_DIR}
WORKDIR ${WORK}

RUN apt-get update -y && apt-get install -y wget git 
RUN npm i -g yarn

COPY . ${WORK}

# COMMENT IF USING LOCAL STYLES
RUN yarn install && yarn make-styles

# COMMENT IF USING LOCAL TILES
RUN wget https://hslstoragekarttatuotanto.blob.core.windows.net/openmaptiles/tiles.mbtiles -q -t 3 -O ${DATA_DIR}/finland.mbtiles

EXPOSE 8080