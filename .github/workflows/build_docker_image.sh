#!/bin/bash -e

if [ -z ${GITHUB_WORKSPACE} ]; then
  GITHUB_WORKSPACE=$(cd $(dirname $0)/../../ && pwd)
fi

echo "${GITHUB_WORKSPACE}"

IMAGE_NAME=windyakin/docker-unity-cache-server
VERSIONS=$(cat << EOS
$(find "${GITHUB_WORKSPACE}" -maxdepth 1 -type d | xargs -I FILEPATH basename FILEPATH | egrep "^[0-9]+\.[0-9]+\.[0-9]+([-+.][a-zA-Z0-9-]+)*$" | sed -e "s/\.\///g" | sort -n)
latest
EOS
)

echo "Build versions list in this job:"
echo "${VERSIONS}"

# docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"

for version in ${VERSIONS}; do
  echo "Start ${IMAGE_NAME}:${version} image build and push to Docker Hub"
  if [ ${version} = 'latest' ]; then
    build_dir="${GITHUB_WORKSPACE}"
  else
    build_dir="${GITHUB_WORKSPACE}/${version}"
  fi
  cd "${build_dir}"
  docker build --pull=true --no-cache=true --tag="${IMAGE_NAME}:${version}" .
  # docker push "${IMAGE_NAME}:${version}"
  echo "Finish ${IMAGE_NAME}:${version} image build and push to Docker Hub"
  cd "${GITHUB_WORKSPACE}"
done
