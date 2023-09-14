#!/bin/bash

# Install Git and Ansible
apt-get update
apt-get install -y git ansible

# Clone ansible-raspberry repository
git clone https://github.com/kevinlucchese94/ansible-debian.git

# Enter into the downloaded directory
cd ansible-debian

# Install Docker (if not already installed)
if ! command -v docker &> /dev/null; then
    curl -sSL https://get.docker.com | sh
    sudo usermod -aG docker pi
fi

#install Portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Run the ansible playbook
ansible-playbook main.yml --ask-become-pass
