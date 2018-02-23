#!/bin/bash -xe

IMAGE_NAME=windyakin/docker-unity-cache-server
VERSIONS=$(find -maxdepth 1 -type d | grep -E "^\./[0-9\.]+$" | sed -e "s/\.\///g" | sort)

docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"

for version in ${VERSIONS}; do
  echo "${version}"
  cd $version
  set +e
  docker pull "${IMAGE_NAME}:${version}"
  set -e
  docker build --pull --tag "${IMAGE_NAME}:${version}" .
  docker push "${IMAGE_NAME}:${version}"
  cd ..
done
