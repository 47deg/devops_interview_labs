#!/usr/bin/env bash

source .env

gcloud beta compute instances create "${XF_INSTANCE:?}" \
    --project="${XF_PROJECT:?}" \
    --zone="${XF_ZONE:?}" \
    --machine-type=e2-small \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --metadata="${XF_METADATA:?}" \
    --no-restart-on-failure \
    --maintenance-policy=TERMINATE \
    --provisioning-model=SPOT \
    --instance-termination-action=DELETE \
    --max-run-duration=3960s \
    --service-account="${XF_SA:?}" \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --min-cpu-platform=Automatic \
    --tags=xf-lab-candidate,http-server,https-server,lb-health-check \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any \
    --source-machine-image=xf-lab-base-image
