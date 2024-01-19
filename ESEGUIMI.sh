#!/bin/bash

# Richiedi il nome
read -p "Inserisci il nome: " nome
# Richiedi la password
read -s -p "Inserisci la password: " password

# Install Git and Ansible
apt-get update
apt-get install -y git ansible

# Clone ansible-debian repository
git clone https://github.com/kevinlucchese94/ansible-debian.git

# Enter into the downloaded directory
cd ansible-debian
# Salva il nome, cognome e password nel file vars.yml
echo -e "nome: $nome\npassword: $password" > vars.yml

##creo il file hosts e vars
echo "[target]" > hosts ##serve per ansible
echo "localhost" >> hosts ##serve per ansible
echo "[target:vars]" >> hosts ##serve per ansible
echo "ansible_ssh_user=utente" >> hosts ##serve per ansible
echo "ansible_ssh_pass=4" >> hosts ##serve per ansible
echo "ansible_python_interpreter=/usr/bin/python3" >> hosts
echo "ansible_sudo_pass=4" >> hosts

# Install Docker (if not already installed)
if ! command -v docker &> /dev/null; then
    curl -sSL https://get.docker.com | sh
    sudo usermod -aG docker pi
fi

#install Portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Run the ansible playbook
ansible-playbook ansible-debian/main.yml --ask-become-pass
