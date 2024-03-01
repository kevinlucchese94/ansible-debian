#!/bin/bash

# Richiedi il nome utente
read -p "Inserisci il nome utente: " utente
# Richiedi la password
read -s -p "Inserisci la password: " password
echo

# Installa Git e Ansible
sudo apt-get update
sudo apt-get install -y git ansible

# Clone ansible-debian repository
git clone https://github.com/kevinlucchese94/ansible-debian.git

# Entra nella directory scaricata
cd ansible-debian
# Salva il nome utente e la password nel file vars.yml
echo -e "utente: $utente\npassword: $password" > vars.yml

# Crea il file hosts
echo "[target]" > hosts
echo "localhost" >> hosts

# Crea il file ansible.cfg per specificare l'utente sudo
echo -e "[defaults]\nremote_user = $utente" > ansible.cfg

# Esegui il playbook Ansible
ansible-playbook main.yml --ask-become-pass


# Run the ansible playbook
ansible-playbook ansible-debian/main.yml --ask-become-pass
