#!/usr/bin/env sh

/usr/local/bin/dockerd-entrypoint.sh "$@" &

./dind/wait_for_docker.sh

kind create cluster --name ko-k8s-cluster --image=kindest/node:v1.26.6 --wait 50s

kubectl cluster-info --context kind-ko-k8s-cluster

./dind/prepare-kubeconfig.sh >>kubeconfig.b64

docker compose -f coder/docker-compose.yaml up --build -d

docker compose -f coder/docker-compose.yaml cp kubeconfig.b64 coder:/root

fg 1 # bring back dockerd so container doesn't die
