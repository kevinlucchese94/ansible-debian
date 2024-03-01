# Configurazione del PC Personale

Questo progetto Ansible è progettato per automatizzare la configurazione di un PC personale utilizzando Ansible. Il playbook `main.yml` contiene una serie di ruoli che installano e configurano varie componenti, come Docker, Cockpit, Samba, e altro ancora.

## Istruzioni

### 1. Modifica le variabili

Prima di eseguire il playbook, assicurati di modificare il file `vars.yml` con le informazioni corrette. In particolare, specifica il nome utente (`utente`), la password (`password`), e qualsiasi altra variabile necessaria per la configurazione.

### 2. Esegui il playbook Ansible

Dopo aver aggiornato le variabili, esegui il playbook Ansible con il seguente comando:

```bash
ansible-playbook main.yml --ask-become-pass
