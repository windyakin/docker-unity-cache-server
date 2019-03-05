#!/bin/sh -xe

if [ "$@" = "unity-cache-server" ] || [ -z "$@" ]; then
  dumb-init -- \
    unity-cache-server-cleanup \
      --cache-path "${CACHE_PATH:-"/srv/unity/cache"}" \
      --delete \
      --max-cache-size "${MAX_CACHE_SIZE:-53687091200}" \
      --expire-time-span "${EXPIRE_TIME_SPAN:-"90.00:00:00"}" \
      --log-level "${LOG_LEVEL:-3}" \
      --daemon "${DAEMON_INTERVAL:-86400}" & \
  dumb-init -- \
    unity-cache-server \
      --cache-path "${CACHE_PATH:-"/srv/unity/cache"}"
      --log-level "${LOG_LEVEL:-3}"
else
  exec $@
fi
