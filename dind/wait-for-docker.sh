#!/usr/bin/env sh

# Location of the Docker UNIX socket
DOCKER_SOCK="/var/run/docker.sock"

# Wait for Docker to be ready
while true; do
    # Check if Docker socket exists and is responsive
    if [[ -S "${DOCKER_SOCK}" ]] && curl --unix-socket "${DOCKER_SOCK}" -s "http://localhost/version" >/dev/null; then
        break
    fi
    sleep 1
done

echo "Docker is up and running!"
