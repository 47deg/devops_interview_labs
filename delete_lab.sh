#!/bin/bash

echo "Start Time"
date

# Create an AKS single node cluster
resource_group="argocd-dev-eus-rg-2"  # Replace with your resource group
cluster_name="guille-xebia-lab"  # Replace with desired cluster name
location="uksouth"  # Replace with your location


read -p "Do you want to delete AKS or User's Lab? (aks/lab): " a

if [ "$a" == "aks" ]; then

    echo 
    
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

    echo
    echo "PLEASE LOGIN INTO AZURE PORTAL"
    # Wait for the user to log in
    az login --use-device-code
    if [ $? -eq 0 ]; then
        echo "Logged in to your Account"
    else
        echo "Account not found"
        exit
    fi
    # Set the Azure subscription
    echo "Set the Azure subscription"
    az account set --subscription "$subscription_id"
    if [ $? -eq 0 ]; then
        echo "Subscription set for Azure Key Vault"
    else
        echo "Subscription setting failed"
        exit
    fi

    cluster_exists=$(az aks list --resource-group $resource_group | jq -r --arg cluster_name "$cluster_name" '.[] | select(.name == $cluster_name) | .name')

    if [ "$cluster_exists" == "$cluster_name" ]; then
        echo "AKS cluster $cluster_name already exists in resource group $resource_group."

        # Function to show progress
        show_progress() {
            local elapsed_time=0

            while true; do
                echo "Deleting AKS cluster... elapsed time: $elapsed_time seconds"
                sleep 10
                elapsed_time=$((elapsed_time + 10))
            done
        }
        # Start showing progress in the background
        show_progress &
        # Get the process ID of the background function
        progress_pid=$!

        # Try to delete the AKS cluster
        output=$(az aks delete --resource-group "$resource_group" --name "$cluster_name" --yes --no-wait 2>&1)
        # Capture the exit status of AKS creation immediately
        aks_delete_status=$?

        # Kill the background progress function as soon as AKS creation is done
        kill $progress_pid

        if [ $aks_delete_status -ne 0 ]; then
            echo "Error Deleting AKS cluster:"
            echo "$output"
            exit 1
        else
            echo "AKS cluster Deleted successfully!"
            git clone https://github.com/47deg/devops_interview_labs.git 
            git checkout main
            git fetch
            git pull
            git config --global user.email "francis.poku@tiacloud.io"
            git config --global user.name "tiacloud-gh"

            home=$(pwd)
            filename="$username-lab"
            OUTPUT_FILE="$home/lab_yaml_files/$filename.yaml"
            rm -rf $OUTPUT_FILE
            echo "Committing $filename.yaml to Git..."
            git add .
            git commit -m "Deleted $filename.yaml from xebia lab"
            git pull
            git push
        fi
    else
        echo "AKS cluster $cluster_name does not exist in resource group $resource_group."
    fi

else
    echo 
    # Get username and password
    read -p "Welcome to Xebia Labs, Enter user's name: " username
    echo

    resource_group="argocd-dev-eus-rg-2"  # Replace with your resource group
    cluster_name="$username-xebia-lab" 
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

    echo
    echo "PLEASE LOGIN INTO AZURE PORTAL"
    # Wait for the user to log in
    az login --use-device-code
    if [ $? -eq 0 ]; then
        echo "Logged in to your Account"
    else
        echo "Account not found"
        exit
    fi
    # Set the Azure subscription
    echo "Set the Azure subscription"
    az account set --subscription "$subscription_id"
    if [ $? -eq 0 ]; then
        echo "Subscription set for Azure Key Vault"
    else
        echo "Subscription setting failed"
        exit
    fi
    # Get the AKS cluster credentials
    echo "Retrieving AKS cluster credentials..."
    output=$(yes | az aks get-credentials --resource-group $resource_group --name $cluster_name 2>&1)

    # Check for errors while retrieving credentials
    if [ $? -ne 0 ]; then
        echo "Error retrieving AKS cluster credentials:"
        echo "$output"
        exit 1
    else
        echo "AKS cluster credentials retrieved successfully!"
    fi

    git clone https://github.com/47deg/devops_interview_labs.git
    git fetch
    git pull
    git config --global user.email "francis.poku@tiacloud.io"
    git config --global user.name "tiacloud-gh"

    home=$(pwd)
    filename="$username-lab"
    OUTPUT_FILE="$home/lab_yaml_files/$filename.yaml"

    echo

    echo "Deleting $username's Lab..."
    kubectl delete -f $OUTPUT_FILE
    rm -rf $OUTPUT_FILE
    echo "Committing $filename.yaml to Git..."
    git add .
    git commit -m "Deleted $filename.yaml from xebia lab"
    git pull
    git push

    echo
    echo "lab Deleted, thank you!!"
    exit
fi
