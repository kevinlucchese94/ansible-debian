#!/bin/bash

# controlla se il disco samba è già montato
if grep -qs '/home/kevin/foto_e_video' /proc/mounts; then
  echo "Il disco samba è già montato."
  # impostazione delle cartelle di origine e destinazione
  #RSYNC DEI VIDEO
  remote_dir="/home/kevin/foto_e_video/"
  local_dir="/home/kevin/Video"

  rsync -zvrah --delete \
    --include="*.[Mm][Oo][Vv]" \
    --include="*.[Mm][Pp][4]" \
    --include="*.MOD" \
    --exclude="*.[Jj][Pp][Gg]" \
    --exclude="*.[Jj][Pp][Ee][Gg]" \
    --exclude="*.[Pp][Nn][Gg]" \
    --exclude="*.HEIC" \
    "$local_dir" "$remote_dir"

  #RSYNC DELLE FOTO
  remote_dir="/home/kevin/foto_e_video/"
  local_dir="/home/kevin/Foto"

  rsync -zvrah --delete \
    --include="*.[Jj][Pp][Gg]" \
    --include="*.[Pp][Nn][Gg]" \
    --include="*.HEIC" \
    --include="*.[Jj][Pp][Ee][Gg]" \
    --exclude="*.MOD" \
    --exclude="*.[Mm][Oo][Vv]" \
    --exclude="*.[Mm][Pp]4" \
    "$local_dir" "$remote_dir"
else
  # monta il disco samba sulla cartella specificata
  sudo mount -t cifs -o username=pi,password=Erminio67,rw //192.168.5.198/foto_e_video /home/kevin/foto_e_video
  if [ $? -eq 0 ]; then
    echo "Il disco samba è stato montato con successo."
    #RSYNC DEI VIDEO
    remote_dir="/home/kevin/foto_e_video/"
    local_dir="/home/kevin/Video"

    rsync -zvrah --delete \
      --include="*.[Mm][Oo][Vv]" \
      --include="*.[Mm][Pp][4]" \
      --include="*.MOD" \
      --exclude="*.[Jj][Pp][Gg]" \
      --exclude="*.[Jj][Pp][Ee][Gg]" \
      --exclude="*.[Pp][Nn][Gg]" \
      --exclude="*.HEIC" \
      "$local_dir" "$remote_dir"

    #RSYNC DELLE FOTO
    remote_dir="/home/kevin/foto_e_video/"
    local_dir="/home/kevin/Foto"

    rsync -zvrah --delete \
      --include="*.[Jj][Pp][Gg]" \
      --include="*.[Pp][Nn][Gg]" \
      --include="*.HEIC" \
      --include="*.[Jj][Pp][Ee][Gg]" \
      --exclude="*.MOD" \
      --exclude="*.[Mm][Oo][Vv]" \
      --exclude="*.[Mm][Pp]4" \
      "$local_dir" "$remote_dir"
  else
    echo "Si è verificato un errore nel montare il disco samba."
  fi
fi
