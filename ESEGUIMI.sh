#!/bin/bash
set -e

# Richiedi input
read -p "Inserisci il nome utente per il nuovo account: " utente
read -s -p "Inserisci la password per il nuovo utente: " password
echo
read -p "Inserisci il nome utente Raspberry per Samba: " utenterasperry
read -s -p "Inserisci la password Raspberry per Samba: " passwordrasperry
echo

# Verifica input
if [ -z "$utente" ] || [ -z "$password" ] || [ -z "$utenterasperry" ] || [ -z "$passwordrasperry" ]; then
    echo "Errore: Tutti i campi sono obbligatori."
    exit 1
fi

# Installa Git e Ansible
echo "Aggiornamento e installazione di Git e Ansible..."
sudo apt-get update
sudo apt-get install -y git ansible

# Clona il repository
echo "Clonazione del repository Ansible..."
git clone https://github.com/kevinlucchese94/ansible-debian.git
cd ansible-debian

# Salva le credenziali criptate
echo "Creazione del file vars.yml con Ansible Vault..."
echo -e "utente: $utente\npassword: $password\nutenterasperry: $utenterasperry\npasswordrasperry: $passwordrasperry" > vars.yml
#ansible-vault encrypt vars.yml

# Crea il file ansible.cfg
echo "Configurazione di ansible.cfg..."
if [ -f ansible.cfg ]; then
    cp ansible.cfg ansible.cfg.bak
    echo "Backup di ansible.cfg salvato come ansible.cfg.bak"
fi
echo -e "[defaults]\nremote_user = $utente" > ansible.cfg

# Esegui il playbook
echo "Esecuzione del playbook Ansible..."
ansible-playbook main.yml --ask-vault-pass --ask-become-pass

# Pulizia
echo "Pulizia dei file temporanei..."
rm -f vars.yml
