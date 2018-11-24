FROM node:6-alpine

# https://download.unity3d.com/download_unity/b8cbb5de9840/CacheServer-2018.1.1f1.zip
ARG UNITY_VERSION=2018.1.1f1
ARG VERSION_HASH=b8cbb5de9840

LABEL org.label-schema.version=${UNITY_VERSION}

RUN apk add --no-cache --virtual build-dependencies \
    curl \
    unzip \
  && curl https://download.unity3d.com/download_unity/${VERSION_HASH}/CacheServer-${UNITY_VERSION}.zip -o /tmp/cache_server.zip \
  && unzip -j -d /srv /tmp/cache_server.zip \
    CacheServer/CacheServer.js \
    CacheServer/LegacyCacheServer.js \
    CacheServer/main.js \
  && rm -rf /tmp/cache_server.zip \
  && apk del --purge build-dependencies \
  && mkdir -p /srv/unity

WORKDIR /srv
VOLUME [ "/srv/unity" ]
EXPOSE 8125-8126
ENTRYPOINT [ "node", "main.js", "--path", "/srv/unity/cache5.0", "--legacypath", "/srv/unity/cache" ]
