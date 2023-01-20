#!/bin/sh
bash /home/kevin/scripts/mount_samba.sh
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
  --exclude="*.HEIC"  \
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
