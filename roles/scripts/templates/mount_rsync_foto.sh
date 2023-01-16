#!/bin/bash

# controlla se il disco samba è già montato
if grep -qs '/home/kevin/foto_e_video' /proc/mounts; then
  echo "Il disco samba è già montato."
    # impostazione delle cartelle di origine e destinazione
    remote_dir="/home/kevin/foto_e_video/Foto"
    local_dir="/home/kevin/"

    rsync -zvrah --delete \
    --include="*.[Jj][Pp][Gg]" \
    --include="*.[Pp][Nn][Gg]" \
    --include="*.HEIC" \
    --include="*.[Jj][Pp][Ee][Gg]" \
    --exclude="*.MOD" \
    --exclude="*.[Mm][Oo][Vv]" \
    --exclude="*.[Mm][Pp]4" \
  "$remote_dir" "$local_dir"
else
  # monta il disco samba sulla cartella specificata
  sudo mount -t cifs -o username=pi,password=Erminio67,rw //192.168.5.198/foto_e_video /home/kevin/foto_e_video
  if [ $? -eq 0 ]; then
    echo "Il disco samba è stato montato con successo."
    # impostazione delle cartelle di origine e destinazione
    remote_dir="/home/kevin/foto_e_video/Foto"
    local_dir="/home/kevin/"

    rsync -zvrah --delete \
    --include="*.[Jj][Pp][Gg]" \
    --include="*.[Pp][Nn][Gg]" \
    --include="*.HEIC" \
    --include="*.[Jj][Pp][Ee][Gg]" \
    --exclude="*.MOD" \
    --exclude="*.[Mm][Oo][Vv]" \
    --exclude="*.[Mm][Pp]4" \
  "$remote_dir" "$local_dir"
  else
    echo "Si è verificato un errore nel montare il disco samba."
  fi
fi