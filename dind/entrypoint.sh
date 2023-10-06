#!/usr/bin/env sh

# parallel ::: "/usr/local/bin/dockerd-entrypoint.sh" "./dind/startup.sh"

./dind/startup.sh &
/usr/local/bin/dockerd-entrypoint.sh
