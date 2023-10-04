#!/usr/bin/env sh

oldUrl="$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')"
newUrl="https://$(docker ps --format "{{.Names}}" | grep control-plane):6443"

sed "s@${oldUrl}@${newUrl}@g" /root/.kube/config | base64 -w 0
