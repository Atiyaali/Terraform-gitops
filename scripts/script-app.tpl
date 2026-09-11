#!/bin/bash

# Wait for background cloud-init processes to finish
sleep 60

# Update package lists and install Docker
sudo apt update
sudo apt install -y docker.io


# Add the standard ubuntu user to the docker group
sudo usermod -aG docker ubuntu

# Restart Docker service with proper privileges
sudo systemctl restart docker
sudo systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
# Install AWS CLI
sudo apt install -y awscli

