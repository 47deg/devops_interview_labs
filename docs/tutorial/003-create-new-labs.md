# Tutorial: Creating New Labs in Xebia DevOps Interview Labs

## Overview
This guide explains how to create new lab environments on Google Cloud Platform
(GCP) using the `create-vm-from-image.bash` script provided in the Xebia DevOps
Interview Labs project.

## Steps to Create New Labs
1. **Script Usage**:
   - The `create-vm-from-image.bash` script spins up new VMs on GCP.

2. **Naming Convention**:
   - Follow the specific naming convention outlined in the README section of the
     project for consistency and easy management.

3. **.env File Setup**:
   - The script requires an `.env` file with specific configurations.
   - Details needed in `.env` include `XF_INSTANCE`, `XF_LOCATION`,
     `XF_PROJECT`, `XF_ZONE`, `XF_METADATA`, `XF_SA`.
   - These values can be retrieved from the GCP VMs website. While creating a
     new VM from an existing image, GCP provides a command generator for ease.

4. **Script Execution**:
   - The script configures and launches a new VM with predefined specifications
     such as machine type, network interface, metadata, service account, and
     labels.
   - It also sets up various Google Cloud API scopes and instance settings
     tailored for the lab environment.

By following these steps, you can effectively create new lab environments in the
Xebia DevOps Interview Labs project, ensuring a consistent and controlled setup
on GCP.
