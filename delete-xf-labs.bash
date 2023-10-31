#!/usr/bin/env bash

instances=$(gcloud compute instances list --filter=name:xf-lab --format="csv[no-heading](name,zone.basename())")

echo "$instances" | while IFS=',' read -r col1 col2; do
    gcloud compute instances delete "$col1" --zone "$col2" --quiet
done
