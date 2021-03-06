# Docker Unity Cache Server

## Description

[Unity-Technologies/unity-cache-server](https://github.com/Unity-Technologies/unity-cache-server) on Docker container. **Supporting versions later than 6.x**

It is recommended to use [Accelarator](https://blogs.unity3d.com/2019/09/11/speed-up-your-team-with-the-unity-accelerator/) in Unity version 2019.3 and later. That Docker image is [provided by Unity Technologies](https://hub.docker.com/r/unitytechnologies/accelerator).

## Available on GitHub Container Registry and Docker Hub 🐳

![](https://images.microbadger.com/badges/image/windyakin/docker-unity-cache-server.svg)
![](https://github.com/windyakin/docker-unity-cache-server/workflows/Publish%20to%20Docker%20Hub/badge.svg?branch=master)
![](https://img.shields.io/docker/pulls/windyakin/docker-unity-cache-server?label=Docker%20pulls&logo=docker&logoColor=white)

* [ghcr.io/windyakin/docker-unity-cache-server](https://github.com/users/windyakin/packages/container/package/docker-unity-cache-server)
* [windyakin/docker-unity-cache-server](https://hub.docker.com/r/windyakin/docker-unity-cache-server)

## Usage

### Start server

```sh
docker run -d -p 8126:8126 -v $(pwd):/srv/unity/cache --name unity-cache-server ghcr.io/windyakin/docker-unity-cache-server
```

[Sample docker-compose.yml](docker-compose.yml)

### Volume position

Recommend volume setting position is `/srv/unity/cache`.

### Environment variables

#### Using for `unity-cache-server` and `unity-cache-server-cleanup`

| Variable name |    Command     |            Description            |   Default value    |
| ------------- | -------------- | --------------------------------- | ------------------ |
| `CACHE_PATH`  | `--cache-path` | Cache files position in container | `/srv/unity/cache` |
| `LOG_LEVEL`   | `--log-level`  | Output log level                  | `3` (info)         |

#### Using only for `unity-cache-server-cleanup`

|   Variable name    |       Command        |              Description               |      Default value      |
| ------------------ | -------------------- | -------------------------------------- | ----------------------- |
| `MAX_CACHE_SIZE`   | `--max-cache-size`   | Max cache size (bytes)                 | `53687091200` (50GiB)   |
| `EXPIRE_TIME_SPAN` | `--expire-time-span` | Cache expire time (ASP.NET style time) | `90.00:00:00` (90 days) |
| `DAEMON_INTERVAL`  | `--daemon`           | Daemon working interval (seconds)      | `86400` (24 hours)      |

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
