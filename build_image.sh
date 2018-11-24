#!/bin/bash -xe

IMAGE_NAME=windyakin/docker-unity-cache-server
VERSIONS=$(find -maxdepth 1 -type d | grep -E "^\./[0-9\.]+$" | sed -e "s/\.\///g" | sort)

docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"

for version in ${VERSIONS}; do
  echo "Start ${version} build and push"
  cd "${TRAVIS_BUILD_DIR}/${version}"
  docker build --pull=true --no-cache=true --tag="${IMAGE_NAME}:${version}" .
  docker push "${IMAGE_NAME}:${version}"
  echo "Finish ${version} build and push"
  cd "${TRAVIS_BUILD_DIR}"
done
