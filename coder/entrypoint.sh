#!/usr/bin/env sh

mkdir -p /root/.kube

base64 -d /root/kubeconfig.b64 >>/root/.kube/config

# echo 'DELETEME!! ' "$(grep -i password: /root/.config/code-server/config.yaml)"
