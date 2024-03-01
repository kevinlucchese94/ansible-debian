#!/bin/bash

# Richiedi il nome utente
read -p "Inserisci il nome utente per il nuovo account: " utente
# Richiedi la password per il nuovo utente
read -s -p "Inserisci la password per il nuovo utente: " password
echo
# Richiedi il nome utente rasperry
read -p "Inserisci il nome utente rasperry per samba: " utenterasperry
# Richiedi la password per il nuovo utente
read -s -p "Inserisci la password rasperry per samba: " passwordrasperry
echo
# Installa Git e Ansible
sudo apt-get update
sudo apt-get install -y git ansible

# Clone ansible-debian repository
git clone https://github.com/kevinlucchese94/ansible-debian.git

# Entra nella directory scaricata
cd ansible-debian

# Salva il nome utente e la password nel file vars.yml
echo -e "utente: $utenterasperry\npassword: $password" > vars.yml
echo -e "utenterasperry: $utenterasperry\npasswordrasperry: $passwordrasperry" >> vars.yml

# Crea il file hosts
echo "[target]" > hosts
echo "localhost" >> hosts

# Crea il file ansible.cfg per specificare l'utente sudo
echo -e "[defaults]\nremote_user = $utente" > ansible.cfg

# Esegui il playbook Ansible
ansible-playbook main.yml --ask-become-pass
