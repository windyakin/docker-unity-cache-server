#!/bin/bash -xe

IMAGE_NAME=windyakin/docker-unity-cache-server
VERSIONS=$(cat << EOS
$(find -maxdepth 1 -type d | grep -E "^\./[0-9\.]+$" | sed -e "s/\.\///g" | sort)
latest
EOS
)

if [ -z ${TRAVIS_BUILD_DIR} ]; then
  TRAVIS_BUILD_DIR=$(cd $(dirname $0) && pwd)
fi

docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"

for version in ${VERSIONS}; do
  echo "Start ${version} build and push"
  if [ ${version} = 'latest' ]; then
    build_dir="${TRAVIS_BUILD_DIR}"
  else
    build_dir="${TRAVIS_BUILD_DIR}/${version}"
  fi
  cd "${build_dir}"
  docker build --pull=true --no-cache=true --tag="${IMAGE_NAME}:${version}" .
  docker push "${IMAGE_NAME}:${version}"
  echo "Finish ${version} build and push"
  cd "${TRAVIS_BUILD_DIR}"
done
