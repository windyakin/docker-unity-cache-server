#!/bin/bash -xe

IMAGE_NAME=windyakin/docker-unity-cache-server
VERSIONS=$(find -maxdepth 1 -type d | grep -E "^\./[0-9\.]+$" | sed -e "s/\.\///g" | sort)
LTS_VERSION=$(cat ./LTSVersion)

docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"

for version in ${VERSIONS}; do
  echo "Start ${version} build and push"
  cd "${TRAVIS_BUILD_DIR}/${version}"
  docker build --pull=true --no-cache=true --tag="${IMAGE_NAME}:${version}" .
  docker push "${IMAGE_NAME}:${version}"
  if [ "${version}" = "${LTS_VERSION}" ]; then
    echo "${version} is LTS version."
    docker tag "${IMAGE_NAME}:${version}" "${IMAGE_NAME}:lts"
    docker push "${IMAGE_NAME}:lts"
  fi
  echo "Finish ${version} build and push"
  cd "${TRAVIS_BUILD_DIR}"
done
