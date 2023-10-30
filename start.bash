#!/usr/bin/env bash

./create-vm-from-image.bash

echo 'wait 7 ...' && sleep 7

./through-ssh-start-lab.bash

gcloud compute instances list
