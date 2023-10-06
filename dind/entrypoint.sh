#!/usr/bin/env sh

./dind/startup.sh &
/usr/local/bin/dockerd-entrypoint.sh
