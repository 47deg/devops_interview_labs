#!/usr/bin/env bash

source .env

gcloud compute ssh "${XF_INSTANCE:?}" \
    --zone "${XF_ZONE:?}" \
    --project "${XF_PROJECT:?}" \
    --command="docker compose -f /home/manuel_mesacano/devops_interview_labs/docker-compose.yaml up -d --build"
