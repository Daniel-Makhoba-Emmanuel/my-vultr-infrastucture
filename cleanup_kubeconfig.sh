#!/bin/bash

# A more robust script to remove a specific cluster context from the ~/.kube/config file.

# Check if a cluster name was provided as an argument
if [ -z "$1" ]; then
    echo "Error: Please provide the cluster name to remove as an argument."
    echo "Usage: ./cleanup_kubeconfig.sh <cluster-name>"
    exit 1
fi

CLUSTER_NAME="$1"
KUBECONFIG_FILE="$HOME/.kube/config"

echo "Attempting to clean up entries for cluster: $CLUSTER_NAME"

# Check if the ~/.kube/config file exists
if [ ! -f "$KUBECONFIG_FILE" ]; then
    echo "Error: ~/.kube/config file not found."
    exit 1
fi

# --- Step 1: Handle the Current Context ---
# Check if the context to be deleted is the current one
CURRENT_CONTEXT=$(kubectl config current-context 2>/dev/null)
if [ "$CURRENT_CONTEXT" == "$CLUSTER_NAME" ]; then
    echo "The cluster to be deleted is the current context. Switching contexts."
    
    # Get all context names
    ALL_CONTEXTS=$(kubectl config get-contexts | tail -n +2 | awk '{print $1}')
    
    # Find a context that is not the one to be deleted
    NEW_CONTEXT=""
    for context in $ALL_CONTEXTS; do
        if [ "$context" != "$CLUSTER_NAME" ]; then
            NEW_CONTEXT="$context"
            break
        fi
    done
    
    if [ -n "$NEW_CONTEXT" ]; then
        kubectl config use-context "$NEW_CONTEXT"
        echo "Switched current context to: $NEW_CONTEXT"
    else
        # If no other contexts exist, unset the current context
        echo "No other contexts found. Unsetting current-context."
        kubectl config unset current-context
    fi
fi

# --- Step 2: Delete the Context Entry ---
# Check if the context exists before trying to delete it
if kubectl config get-contexts | tail -n +2 | awk '{print $1}' | grep -q "$CLUSTER_NAME"; then
    echo "Deleting context: $CLUSTER_NAME"
    kubectl config delete-context "$CLUSTER_NAME"
else
    echo "Context '$CLUSTER_NAME' not found. Skipping deletion."
fi

# --- Step 3: Delete the Cluster Entry ---
# Check if the cluster exists before trying to delete it
if kubectl config get-clusters | tail -n +2 | awk '{print $1}' | grep -q "$CLUSTER_NAME"; then
    echo "Deleting cluster: $CLUSTER_NAME"
    kubectl config delete-cluster "$CLUSTER_NAME"
else
    echo "Cluster '$CLUSTER_NAME' not found. Skipping deletion."
fi

# --- Step 4: Delete the User Entry ---
# The user name in Vultr is often 'admin' and not the cluster ID.
# This part of the script is now more explicit about the user name it is deleting.
echo "Deleting user: admin"
kubectl config delete-user "admin"

echo "Cleanup process for cluster '$CLUSTER_NAME' completed."
exit 0