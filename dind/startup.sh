#!/usr/bin/env sh

kind create cluster --name ko-k8s-cluster --image=kindest/node:v1.26.6 --wait 50s

kubectl cluster-info --context kind-ko-k8s-cluster

./dind/prepare-kubeconfig.sh >>kubeconfig.b64

docker compose -f coder/docker-compose.yaml up --build -d

docker compose -f coder/docker-compose.yaml cp kubeconfig.b64 coder:/root

docker compose -f coder/docker-compose.yaml cp coder/load-kubeconfig.sh coder:/root

docker compose -f coder/docker-compose.yaml exec coder bash -c 'chmod +x /root/load-kubeconfig.sh && /root/load-kubeconfig.sh'

docker compose -f coder/docker-compose.yaml exec coder bash -c 'grep -i password: /root/.config/code-server/config.yaml'
