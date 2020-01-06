#!/bin/bash

SCRIP_FOLDER=$HOME/www/dotfiles

cd $SCRIP_FOLDER

folders_to_create=($(find . -type d ! -path "./.git" ! -path "./.git/*" ! -path "."))

for folder in "${folders_to_create[@]}"
do
	[ ! -d "$HOME/$folder" ] && mkdir -p  "$HOME/$folder"
done

config_files=($(find . -type f ! -path "./.git" ! -path "./.git/*" ! -path "." ! -path "./install.sh"))

for file in "${config_files[@]}"
do
  echo "Running: ln -sf $SCRIP_FOLDER/$file $HOME/$file"
	ln -sf $SCRIP_FOLDER/$file $HOME/$file
done
