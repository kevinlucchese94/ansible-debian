#!/bin/bash

# controlla se il disco samba è già montato
if grep -qs '/home/kevin/foto_e_video' /proc/mounts; then
  echo "Il disco samba è già montato."
    # impostazione delle cartelle di origine e destinazione
else
  # monta il disco samba sulla cartella specificata
  sudo mount -t cifs -o username=pi,password=Erminio67,rw //192.168.5.198/foto_e_video /home/kevin/foto_e_video
  if [ $? -eq 0 ]; then
    echo "Il disco samba è stato montato con successo."
  else
    echo "Si è verificato un errore nel montare il disco samba."
  fi
fi
