#!/bin/bash

echo "Start Time"
date

# Get username and password
read -p "Welcome to Xebia Labs, Enter your username: " username
echo

git clone https://github.com/47deg/devops_interview_labs.git #https://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@github.com/tiacloudconsult/completed-aks-cluster.git 
cd devops_interview_labs
git checkout main
git fetch
git pull
git config --global user.email "francis.poku@tiacloud.io"
git config --global user.name "tiacloud-gh"

home=$(pwd)
filename="$username-lab"
j2_template="templates/lab"
key='username'
value=$username

CONFIG_FILE="$j2_template.j2"
# Path to the output file
OUTPUT_FILE="$home/lab_yaml_files/$filename.yaml"

# cd templates
# pwd

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

# Commit the YAML to the Git repository
echo "Committing $filename.yaml to Git..."
git add .
git commit -m "Added $filename.yaml to xebia lab"
git pull
git push

echo "..................Lab Template Generated..........................."

echo "Building AKS cluster for Lab"


# Define the Azure subscription id, resource group name, Key Vault name, and the service principle name
subscription_id="46081af3-7258-44cd-899c-db7516f0a121"

# Get the device code
device_code=$(az login --device-code)

# Extract the device code URL and user code
device_code_url=$(echo $device_code | grep "http" | awk '{print $NF}')
user_code=$(echo $device_code | grep "user_code" | awk '{print $NF}')

# Inform the user to go to the device code URL and enter the user code
echo "Please go to the following URL and enter the user code: $device_code_url"
echo "User code: $user_code"

# Wait for the user to log in
az login --use-device-code

# Set the Azure subscription
echo "Set the Azure subscription"
az account set --subscription "$subscription_id"

# Create an AKS single node cluster
resource_group="argocd-dev-eus-rg-2"  # Replace with your resource group
cluster_name="$username-xebia-lab"  # Replace with desired cluster name
location="YOUR_LOCATION"  # Replace with your location
vm_size="Standard_B2s"

echo "Create an AKS single node cluster"
# Function to show progress
show_progress() {
    local elapsed_time=0

    while true; do
        echo "Creating AKS cluster... elapsed time: $elapsed_time seconds"
        sleep 10
        elapsed_time=$((elapsed_time + 10))
    done
}

# Start showing progress in the background
show_progress &
# Get the process ID of the background function
progress_pid=$!

# Create the AKS cluster
output=$(az aks create --resource-group $resource_group --name $cluster_name --node-count 1 --enable-addons monitoring --generate-ssh-keys --node-vm-size $vm_size 2>&1)

# Kill the background progress function as soon as AKS creation is done
kill $progress_pid

# Check for errors during AKS cluster creation
if [ $? -ne 0 ]; then
    echo "Error creating AKS cluster:"
    echo "$output"
    exit 1
else
    echo "AKS cluster created successfully!"
fi

# Get the AKS cluster credentials
echo "Retrieving AKS cluster credentials..."
output=$(az aks get-credentials --resource-group $resource_group --name $cluster_name 2>&1)

# Check for errors while retrieving credentials
if [ $? -ne 0 ]; then
    echo "Error retrieving AKS cluster credentials:"
    echo "$output"
    exit 1
else
    echo "AKS cluster credentials retrieved successfully!"
fi

echo "----------------------------------------------------------------"

echo "Deploying $username's Xebia Lab"

# Apply the deployment
kubectl apply -f $OUTPUT_FILE


# Grep for the load balancer IP
while true; do
    lb_ip=$(kubectl get svc -A | grep -i xebia-labs-$username | awk '{print $5}')  # Replace YOUR_SERVICE_NAME with the name of your service
    if [[ $lb_ip && $lb_ip != "<pending>" ]]; then  # Wait until the IP is assigned
        break
    else
        echo "Waiting for LoadBalancer IP..."
        sleep 10
    fi
done

echo "$username Please use LoadBalancer IP: $lb_ip to login into your Xebia Lab. Your password is $username-121"
echo "Happy CODING :)"

echo "End Time" 
date

exit 0