#!/bin/bash

git clone https://github.com/47deg/devops_interview_labs.git #https://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@github.com/tiacloudconsult/completed-aks-cluster.git 
cd devops_interview_labs
git checkout main
git fetch
git pull
git config --global user.email "francis.poku@tiacloud.io"
git config --global user.name "tiacloud-gh"


# Get username and password
read -p "Welcome to Xebia Labs, Enter your username: " username

filename="$username-lab"
j2_template="templates/lab"
key='username'
value=$username

CONFIG_FILE="$j2_template.j2"
# Path to the output file
OUTPUT_FILE="lab_yaml_files/$filename.yaml"

cd templates
pwd

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Config file not found: $CONFIG_FILE"
  exit 1
fi

# Install Jinja2 if it's not already installed
if ! command -v jinja2-cli >/dev/null 2>&1; then
  echo "Jinja2 not found, installing..."
  pip install jinja2-cli[yaml]
fi




# Replace variables in the template and save output to a variable
output=$(jinja2 $j2_template.j2 --format=yaml -D "$key=$value")

# Check if the output file exists
if [ ! -f "$OUTPUT_FILE" ]; then
    # If the output file doesn't exist, create it and write the output to it
    echo -e "$output" > "$OUTPUT_FILE"
    exit
else
    # If the output file exists, append the output to it with three dashes separator
    echo -e "$output" >> "$OUTPUT_FILE"
    exit 1
fi

# # Commit the YAML to the Git repository
# echo "Committing YAML to Git..."
# git add secret.yaml
# git commit -m "Added secret for $clusterName"
# git push