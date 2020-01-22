#!/bin/bash -e

if [ -z ${GITHUB_WORKSPACE} ]; then
  GITHUB_WORKSPACE=$(cd $(dirname $0)/../../ && pwd)
fi

cd "${GITHUB_WORKSPACE}"

# Install semver for versioning sort
npm install -q semver

SEMVER_SORT_ONELINER_JS="console.log(process.argv.slice(1).sort((a, b) => require('semver').gt(a, b) ? 1 : -1).join('\n'));"
IMAGE_NAME=windyakin/docker-unity-cache-server
VERSIONS=$(cat << EOS
$(find "${GITHUB_WORKSPACE}" -maxdepth 1 -type d | xargs -I FILEPATH basename FILEPATH | egrep "^[0-9]+\.[0-9]+\.[0-9]+([-+.][a-zA-Z0-9-]+)*$" | xargs node -e "${SEMVER_SORT_ONELINER_JS}")
latest
EOS
)

echo "Build target versions list in this job:"
echo "${VERSIONS}"

for version in ${VERSIONS}; do
  echo "Start ${IMAGE_NAME}:${version} image build and push to Docker Hub"
  if [ ${version} = 'latest' ]; then
    build_dir="${GITHUB_WORKSPACE}"
  else
    build_dir="${GITHUB_WORKSPACE}/${version}"
  fi
  cd "${build_dir}"
  docker build --pull=true --no-cache=true --tag="${IMAGE_NAME}:${version}" .

  if [ "${DOCKER_PUSH}" = "true" ] && [ -n "${DOCKER_USERNAME}" ] && [ -n "${DOCKER_PASSWORD}" ]; then
    docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"
    docker push "${IMAGE_NAME}:${version}"
  fi

  echo "Finish ${IMAGE_NAME}:${version} image build and push to Docker Hub"
  cd "${GITHUB_WORKSPACE}"
done
