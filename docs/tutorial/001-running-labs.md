# Tutorial: Running Labs in Xebia DevOps Interview Labs

This tutorial provides a straightforward guide to running the Xebia DevOps
Interview Labs either locally or on the GCP cloud. Follow these steps to set up
and access the lab environment effectively.

## Running Locally
1. Start the Lab:
    - Execute: `docker compose up --build`.
    - Password shows on the terminal.
    - Go to http://0.0.0.0:5801 and enter password.
    - Follow the tutorials provided within the lab environment.

## Running on GCP Cloud
1. Setup a GCP VM:
   - Use `create-vm-from-image.bash`. Requires a GCP account and access to the
     cloud.
   - Ensure the `.env` file has correct values.

2. Retrieve IP Address:
   - Check the GCP VM webpage to find the IP for lab access.

3. Establish SSH Connection:
   - Open an SSH connection to the VM through the browser to obtain the editor's
     password.

4. Access the Lab Environment:
   - Go to the HTTP address on port 5801.
   - Enter the retrieved password.

5. Using the IDE:
   - You should see an interface similar to VS Code.
   - Open a terminal within the IDE.
   - Verify that kubectl command is working.
