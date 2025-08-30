#!/bin/bash

# A simple bash script to decode a base64-encoded kubeconfig from a Terraform
# output and merge it with the user's existing kubeconfig file.

# Check if tofu is installed
if ! command -v tofu &> /dev/null
then
    echo "tofu command could not be found. Please ensure it's installed and in your PATH."
    exit 1
fi

# Define file names
NEW_CONFIG_FILE="new-vultr-cluster.yaml"
MERGED_CONFIG_FILE="$HOME/.kube/merged-config"
FINAL_CONFIG_FILE="$HOME/.kube/config"

echo "Attempting to get and decode kubeconfig from Terraform output..."

# Step 1: Decode the kubeconfig and save to a temporary file
tofu output -raw kubeconfig | base64 -d > "$NEW_CONFIG_FILE"

# Check if the decoding was successful
if [ ! -s "$NEW_CONFIG_FILE" ]; then
    echo "Error: Kubeconfig decoding failed. The temporary file is empty."
    rm "$NEW_CONFIG_FILE" # Clean up the empty file
    exit 1
fi

echo "Kubeconfig successfully decoded to '$NEW_CONFIG_FILE'."

# Step 2: Merge the new config with the existing one
echo "Merging new kubeconfig into existing ~/.kube/config..."

KUBECONFIG="$FINAL_CONFIG_FILE:$NEW_CONFIG_FILE" kubectl config view --flatten > "$MERGED_CONFIG_FILE"

# Check if the merge was successful
if [ ! -s "$MERGED_CONFIG_FILE" ]; then
    echo "Error: Kubeconfig merge failed. The merged file is empty."
    rm "$NEW_CONFIG_FILE" # Clean up temporary file
    rm "$MERGED_CONFIG_FILE" # Clean up temporary file
    exit 1
fi

echo "Kubeconfig files successfully merged to '$MERGED_CONFIG_FILE'."

# Step 3: Replace the old config with the new, merged one
mv "$MERGED_CONFIG_FILE" "$FINAL_CONFIG_FILE"

# Check if the move was successful
if [ ! -s "$FINAL_CONFIG_FILE" ]; then
    echo "Error: Failed to move merged config to final location."
    rm "$NEW_CONFIG_FILE" # Clean up temporary file
    exit 1
fi

echo "Successfully updated ~/.kube/config with the new cluster configuration."

# Step 4: Clean up the temporary file
rm "$NEW_CONFIG_FILE"

echo "Temporary file '$NEW_CONFIG_FILE' removed."
echo "Script completed successfully! You can now use 'kubectl config use-context <cluster-name>' to switch to your new cluster."

exit 0