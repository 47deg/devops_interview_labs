#!/usr/bin/env bash

instances=$(gcloud compute instances list --filter=name:xf-lab --format="value(name)")

for instance in $instances; do
    gcloud compute instances delete "$instance"
    # yes Y | gcloud compute instances delete "$instance"
done
