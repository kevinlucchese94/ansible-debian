#!/bin/bash

# Funzione per eseguire il RSYNC
function perform_rsync_video {
  rsync -zvrah --delete \
    --exclude="*.[Jj][Pp][Gg]" \
    --exclude="*.[Pp][Nn][Gg]" \
    --exclude="*.HEIC" \
    --exclude="*.[Jj][Pp][Ee][Gg]" \
    "$1" "$2"
}
# Funzione per eseguire il RSYNC
function perform_rsync_foto {
  rsync -zvrah --delete \
    --exclude="*.[Mm][Oo][Vv]" \
    --exclude="*.[Mm][Pp][4]" \
    --exclude="*.MOD" \
    --exclude="*.[Aa][Vv][Ii]" \
    --exclude="*.[Mm][Kk][Vv]" \
    --exclude="*.[Ww][Mm][Vv]" \
    --exclude="*.[Ff][Ll][Vv]" \
    --exclude="*.[Mm][Pp][Gg]" \
    --exclude="*.[Ww][Ee][Bb][Mm]" \
    "$1" "$2"
}
# Cartella remota principale
remote_base="/home/kevin/foto_e_video"

# controlla se il disco samba è già montato
if grep -qs "$remote_base" /proc/mounts; then
  echo "Il disco samba è già montato."

  # RSYNC DEI VIDEO
  perform_rsync_video "$remote_base/ALL/" "/home/kevin/Video"

  # RSYNC DELLE FOTO
  perform_rsync_foto "$remote_base/ALL/" "/home/kevin/Foto"
else
  # monta il disco samba sulla cartella specificata
  sudo mount -t cifs -o username=pi,password=Erminio67,rw //192.168.5.198/foto_e_video /home/kevin/foto_e_video

  if [ $? -eq 0 ]; then
    echo "Il disco samba è stato montato con successo."

  # RSYNC DEI VIDEO
  perform_rsync_video "$remote_base/ALL/" "/home/kevin/Video"

  # RSYNC DELLE FOTO
  perform_rsync_foto "$remote_base/ALL/" "/home/kevin/Foto"
  else
    echo "Si è verificato un errore nel montare il disco samba."
  fi
fi
