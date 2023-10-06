#!/usr/bin/env sh

/usr/local/bin/dockerd-entrypoint.sh &

./dind/wait-for-docker.sh

./dind/startup.sh
