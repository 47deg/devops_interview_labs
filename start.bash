#!/usr/bin/env bash

./create-vm-from-image.bash

echo 'wait for SSH daemon to start ...' && sleep 10

./through-ssh-start-lab.bash

gcloud compute instances list
