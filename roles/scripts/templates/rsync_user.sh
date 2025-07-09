#!/bin/bash

# Configurazione
REMOTE_SHARE="//192.168.5.198/foto_e_video"
USER_HOME=$(eval echo ~${SUDO_USER:-$USER})
MOUNT_POINT="$USER_HOME/foto_e_video"
DEST_VIDEO="$USER_HOME/Video"
DEST_PHOTO="$USER_HOME/Foto"
CREDENTIALS_FILE="$USER_HOME/.smbcredentials"
LOG_FILE="$USER_HOME/rsync_log.txt"

RSYNC_OPTIONS="-azhv --delete --include='*/'"

# Colori per output opzionali (log + console)
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') $1" | tee -a "$LOG_FILE"
}

# Funzione per eseguire RSYNC
perform_rsync() {
  local src="$1"
  local dest="$2"
  local excludes="$3"
  rsync $RSYNC_OPTIONS $excludes "$src" "$dest" >> "$LOG_FILE" 2>&1
  if [ $? -eq 0 ]; then
    log "✅ Sincronizzazione completata: $dest"
  else
    log "❌ Errore nella sincronizzazione di $dest"
  fi
}

# Funzione per verificare il montaggio
ensure_mounted() {
  if ! grep -qs "$MOUNT_POINT" /proc/mounts; then
    log "Il disco non è montato. Tentativo di montaggio..."
    sudo mkdir -p "$MOUNT_POINT"
    sudo mount -t cifs -o credentials="$CREDENTIALS_FILE",rw "$REMOTE_SHARE" "$MOUNT_POINT"
    if [ $? -ne 0 ]; then
      log "Errore nel montare il disco Samba. Uscita."
      exit 1
    fi
  else
    log "Il disco Samba è già montato."
  fi
}

# File di esclusione
EXCLUDE_VIDEO="--exclude='*.[Jj][Pp][Gg]' --exclude='*.[Pp][Nn][Gg]' --exclude='*.HEIC' --exclude='*.[Jj][Pp][Ee][Gg]'"
EXCLUDE_PHOTO="--exclude='*.[Mm][Oo][Vv]' --exclude='*.[Mm][Pp][4]' --exclude='*.MOD' --exclude='*.[Aa][Vv][Ii]' --exclude='*.[Mm][Kk][Vv]' --exclude='*.[Ww][Mm][Vv]' --exclude='*.[Ff][Ll][Vv]' --exclude='*.[Mm][Pp][Gg]' --exclude='*.[Ww][Ee][Bb][Mm]'"

# Inizio script
log "------ INIZIO SINCRONIZZAZIONE ------"

# Monta il disco remoto
ensure_mounted

# Sincronizzazione Video
log "🟡 Inizio sincronizzazione video"
perform_rsync "$MOUNT_POINT/ALL/" "$DEST_VIDEO" "$EXCLUDE_VIDEO"

# Sincronizzazione Foto
log "🟡 Inizio sincronizzazione foto"
perform_rsync "$MOUNT_POINT/ALL/" "$DEST_PHOTO" "$EXCLUDE_PHOTO"

log "✅ Tutte le sincronizzazioni completate con successo."
exit 0
