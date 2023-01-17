#!/bin/sh

#RSYNC DEI VIDEO 
remote_dir="/home/kevin/foto_e_video/Video"
local_dir="/home/kevin/"

rsync -zvrah --delete \
  --include="*.[Mm][Oo][Vv]" \
  --include="*.[Mm][Pp][4]" \
  --include="*.MOD" \
  --exclude="*.[Jj][Pp][Gg]" \
  --exclude="*.[Jj][Pp][Ee][Gg]" \
  --exclude="*.[Pp][Nn][Gg]" \
  --exclude="*.HEIC"  \
  "$remote_dir" "$local_dir" 

#RSYNC DEI VIDEO DA SISTEMARE
remote_dir="/home/kevin/foto_e_video/Foto/Da sistemare/"
local_dir="/home/kevin/foto_e_video/Video/Da sistemare/"

rsync -zvrah --delete \
  --include="*.[Mm][Oo][Vv]" \
  --include="*.[Mm][Pp][4]" \
  --include="*.MOD" \
  --exclude="*.[Jj][Pp][Gg]" \
  --exclude="*.[Jj][Pp][Ee][Gg]" \
  --exclude="*.[Pp][Nn][Gg]" \
  --exclude="*.HEIC"  \
  "$remote_dir" "$local_dir" 

#RSYNC DELLE FOTO
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