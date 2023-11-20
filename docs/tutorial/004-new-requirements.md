# Tutorial: Modifying Labs with New Requirements in Xebia DevOps Interview Labs

## Overview
Customizing labs to meet new requirements involves changing machine
specifications and installing new software. Here's how you can do it:

### Adjusting Machine Specifications
1. **Machine Size or Location**:
   - Modify these details in the `.env` file.
   - This allows for easy adjustments of VM specifications like size and
     location.

### Installing New Software
1. **Create a New Base Image**:
   - To install new software, start by creating a new base image.
   - Take a snapshot of this image for future use.

2. **Update .env File**:
   - Copy the updated `.env` information from the GCP tool that aids in creating
     VMs from an image.

3. **Run the Create Command**:
   - Use the `create-vm-from-image.bash` script (refer to the previous tutorial
     on creating new labs).
   - Ensure you update the `.env` file with new values.

4. **Verification**:
   - After running the create command, verify that the coder environment,
     Kubernetes, and the newly installed software are functioning correctly.

By following these steps, you can effectively modify the labs to accommodate new
requirements, whether it's changing VM specs or adding new software to the lab
environment.
