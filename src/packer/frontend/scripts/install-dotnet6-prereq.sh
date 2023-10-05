#!/bin/bash

# Get Ubuntu version
repo_version_raw=$(if command -v lsb_release &> /dev/null; then lsb_release -r -s; else grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"'; fi)
repo_version=$(echo $repo_version_raw | tr -d '\n' | tr -d '\r')

echo "Repo Version: $repo_version"

# Download Microsoft signing key and repository
url="https://packages.microsoft.com/config/ubuntu/${repo_version}/packages-microsoft-prod.deb"
echo $url
wget $url -O packages-microsoft-prod.deb

# Install Microsoft signing key and repository
dpkg -i packages-microsoft-prod.deb

# Clean up
rm packages-microsoft-prod.deb

# Update packages
apt-get update -y