# Docker Unity Cache Server

## Description

[Unity Cache Server](https://github.com/Unity-Technologies/unity-cache-server) on Docker container. **Supporting versions later than 6.x**

## Available on Docker Hub 🐳

* [windyakin/docker-unity-cache-server](https://hub.docker.com/r/windyakin/docker-unity-cache-server)
  * [Supported version tags](https://hub.docker.com/r/windyakin/docker-unity-cache-server/tags/)

## Usage

### Start server

```sh
docker run -d -p 8126:8126 -v $(pwd):/srv/unity/cache --name unity-cache-server windyakin/docker-unity-cache-server
```

[Sample docker-compose.yml](docker-compose.yml)

### Volume position

Recommend volume setting position is `/srv/unity/cache`.

## Build other version

Build with parameters.

```sh
docker build --tag unity-cache-server:6.1.0 --build-arg CACHE_SERVER_VERSION=6.1.0 .
```

## You wanna get old versions cache server image?

Old cache server (enclosed Unity version 2017.1.0 - 2017.3.1) moved ["v5/" directory](v5)

## License

[MIT License](LICENSE)

## Author

* windyakin ([Twitter](https://twitter.com/MITLicense))
