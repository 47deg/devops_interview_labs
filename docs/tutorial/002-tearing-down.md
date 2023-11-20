# Tutorial: Tearing Down Labs on GCP in Xebia DevOps Interview Labs

## Overview
This tutorial guides you through the process of tearing down any leftover VMs
from the Xebia DevOps Interview Labs on Google Cloud Platform (GCP), ensuring a
clean and efficient cleanup.

## Teardown Process
1. Access the Script:
   - Locate the `delete-xf-labs.bash` script within the project's repository.
2. Script Functionality:
   - The script identifies and deletes VMs following a specific naming
     convention, `xf-lab`.
   - It doesn't require `.env` file setup.
   - Ensure access to the `xf-lab` project on GCP.
3. Executing the Script:
   - Run `delete-xf-labs.bash`.
   - The script uses `gcloud compute instances list` to list instances named
     `xf-lab`.
   - It then iteratively deletes these instances using `gcloud compute instances
     delete`.


This process ensures that any VMs associated with the labs are cleanly and
efficiently removed from your GCP environment.
