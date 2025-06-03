FROM maptiler/tileserver-gl:v5.1.3

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

ARG PUBLIC_URL="http://localhost:8080"
ENV PUBLIC_URL=${PUBLIC_URL}

ENTRYPOINT /usr/src/app/docker-entrypoint.sh --public_url ${PUBLIC_URL}