#!/bin/bash

# Define the URL for available distributions
MIRROR_URL="https://mirror.limda.net/ubuntu-archive/dists/"

# Get the current Ubuntu codename
CURRENT_CODENAME=$(lsb_release -c | awk '{print $2}')

# Fetch the list of available distributions from the mirror URL
AVAILABLE_DISTS=$(wget -q -O - $MIRROR_URL | grep -oP '(?<=<a href=")[^"]+')

# Check if the current codename is available in the list of distributions
if echo "$AVAILABLE_DISTS" | grep -q "$CURRENT_CODENAME"; then
    echo "Found the distribution '$CURRENT_CODENAME' in the available list."
else
    echo "Error: Distribution '$CURRENT_CODENAME' not found in the available mirror list."
    exit 1
fi

# Define the repo URL based on the codename
REPO_URL="http://mirror.limda.net/ubuntu-archive/"

# Backup the original sources.list file
echo "Backing up original sources.list..."
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup

# Set the repository URL to the sources.list for the current codename
echo "Setting the repository URL to: $REPO_URL"
echo "deb $REPO_URL $CURRENT_CODENAME main restricted universe multiverse" | sudo tee /etc/apt/sources.list
echo "deb $REPO_URL $CURRENT_CODENAME-updates main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
echo "deb $REPO_URL $CURRENT_CODENAME-security main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list

# Update package list
echo "Updating package list..."
sudo apt update

# Done
echo "Repository setup and package list updated!"
