#!/bin/bash

# Wait for background cloud-init processes to finish
sleep 60

# Update package lists and install Docker
sudo apt update
sudo apt install -y docker.io



# Add the standard ubuntu user to the docker group
sudo usermod -aG docker ubuntu

# NOTE: Only uncomment the line below if you have already installed gitlab-runner on this instance
# sudo usermod -aG docker gitlab-runner

# Restart Docker service with proper privileges
sudo systemctl restart docker
sudo systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
# Install AWS CLI
sudo apt install -y awscli

mkdir -p /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner

# Download the latest runner package (adjust version if needed)
curl -o actions-runner-linux-x64-2.337.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.337.0/actions-runner-linux-x64-2.337.0.tar.gz
echo "70920811a4f8ad4328818682bca5c6469c1c942fab52448868071d0063816613  actions-runner-linux-x64-2.337.0.tar.gz" | shasum -a 256 -c
# Extract the installer
tar xzf ./actions-runner-linux-x64-2.337.0.tar.gz
# Fix ownership so the non-root ubuntu user owns the runner directory
chown -R ubuntu:ubuntu /home/ubuntu/actions-runner

# REPLACE the URL and TOKEN with your actual GitHub repository details
sudo -u ubuntu ./config.sh --url ${github_repo_url} --token ${github_token} --unattended --replace
# Install and start the runner service
sudo ./svc.sh install ubuntu
sudo ./svc.sh start
