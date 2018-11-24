FROM node:8-alpine

ARG CACHE_SERVER_VERSION=6.1.0

LABEL org.label-schema.version=${CACHE_SERVER_VERSION}

RUN apk add --no-cache --virtual build-dependencies \
    wget \
  && wget -q https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 -O /usr/local/bin/dumb-init \
  && chmod +x /usr/local/bin/dumb-init \
  && apk del --purge build-dependencies

WORKDIR /srv/unity

COPY entrypoint.sh entrypoint.sh

RUN npm i -g unity-cache-server@${CACHE_SERVER_VERSION}

VOLUME [ "/srv/unity/cache" ]
EXPOSE 8126
ENTRYPOINT [ "/srv/unity/entrypoint.sh" ]
CMD [ "unity-cache-server" ]
