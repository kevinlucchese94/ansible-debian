#!/bin/bash

# Configurazione
REMOTE_SHARE="//192.168.5.254/FRITZ.NAS/FOTO_VIDEO"
MOUNT_POINT="/home/{{ utente }}/foto_e_video"
DEST_VIDEO="/home/{{ utente }}/Video/"
DEST_PHOTO="/home/{{ utente }}/Foto/"
CREDENTIALS_FILE="/home/{{ utente }}/.smbcredentials"
LOG_FILE="/home/{{ utente }}/rsync_log.txt"

RSYNC_OPTIONS="-zvrah --delete --include='*/'"

# Funzione per eseguire RSYNC
function perform_rsync {
  local dest=$1
  local src=$2
  local excludes=$3
  rsync $RSYNC_OPTIONS $excludes "$src" "$dest" >> "$LOG_FILE" 2>&1
}

# Funzione per verificare il montaggio
function ensure_mounted {
  if ! grep -qs "$MOUNT_POINT" /proc/mounts; then
    echo "Il disco non è montato. Tentativo di montaggio..." >> "$LOG_FILE"
    sudo mount -t cifs -o credentials=$CREDENTIALS_FILE,rw "$REMOTE_SHARE" "$MOUNT_POINT"
    if [ $? -ne 0 ]; then
      echo "Errore nel montare il disco Samba. Uscita." >> "$LOG_FILE"
      exit 1
    fi
  else
    echo "Il disco Samba è già montato." >> "$LOG_FILE"
  fi
}

# Esclusioni per i file
EXCLUDE_VIDEO="--exclude='*.[Jj][Pp][Gg]' --exclude='*.[Pp][Nn][Gg]' --exclude='*.HEIC' --exclude='*.[Jj][Pp][Ee][Gg]'"
EXCLUDE_PHOTO="--exclude='*.[Mm][Oo][Vv]' --exclude='*.[Mm][Pp][4]' --exclude='*.MOD' --exclude='*.[Aa][Vv][Ii]' --exclude='*.[Mm][Kk][Vv]' --exclude='*.[Ww][Mm][Vv]' --exclude='*.[Ff][Ll][Vv]' --exclude='*.[Mm][Pp][Gg]' --exclude='*.[Ww][Ee][Bb][Mm]'"

# Inizio script
echo "---- $(date) ----" >> "$LOG_FILE"

# Assicura che il disco Samba sia montato
ensure_mounted

# Sincronizzazione Video
echo "Sincronizzazione dei video..." >> "$LOG_FILE"
perform_rsync "$MOUNT_POINT/ALL/" "$DEST_VIDEO" "$EXCLUDE_VIDEO"

# Sincronizzazione Foto
echo "Sincronizzazione delle foto..." >> "$LOG_FILE"
perform_rsync "$MOUNT_POINT/ALL/" "$DEST_PHOTO" "$EXCLUDE_PHOTO"

echo "Sincronizzazione completata con successo!" >> "$LOG_FILE"
exit 0
