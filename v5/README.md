# Docker Unity Cache Server

## Description

[Unity Cache Server](https://docs.unity3d.com/Manual/CacheServer.html) on Docker container. **Supporting versions later than 2017.x**

## Available on Docker Hub 🐳

* [windyakin/docker-unity-cache-server](https://hub.docker.com/r/windyakin/docker-unity-cache-server)
  * [Supported version tags](https://hub.docker.com/r/windyakin/docker-unity-cache-server/tags/)

## Usage

### Start server

```sh
docker run -d -p 8125-8126:8125-8126 -v $(pwd):/srv/unity --name cache_server windyakin/docker-unity-cache-server
```

[Sample docker-compose.yml](docker-compose.yml)

### Volume position

Recommend volume setting position is `/srv/unity`.

### Don't need legacy mode support

If you do not need legacy mode support, add `--nolegacy` param to Docker run command params.

```sh
docker run -d -p 8126:8126 -v $(pwd):/srv/unity/cache5.0 --name cache_server windyakin/docker-unity-cache-server --no-legacy
```

[Sample docker-compose.yml](docker-compose.nolegacy.yml)

## Build other version

Get download URL from [Unity - Download Archive](https://unity3d.com/jp/get-unity/download/archive) (Download URL of Cache Server is no distinction between Windows and Mac).

Extract the parameter for Docker image building from the URL.

```
https://download.unity3d.com/download_unity/472613c02cf7/CacheServer-2017.1.0f3.zip
                                            ^^^^^^^^^^^^             ^^^^^^^^^^
                                            VERSION_HASH            UNITY_VERSION
```

Build with parameters.

```sh
docker build --tag unity-cache-server:2017.1.0 --build-arg UNITY_VERSION=2017.1.0f3 --build-arg VERSION_HASH=472613c02cf7 .
```

## License

[MIT License](LICENSE)

## Author

* windyakin ([Twitter](https://twitter.com/MITLicense))
