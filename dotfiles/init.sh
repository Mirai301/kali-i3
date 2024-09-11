#!/usr/bin/env zsh

BASE_DIR=$(pwd)

echo "[+] Create symlinks for dotfiles"
ln -sf "$BASE_DIR"/zsh/.ctf_profile.zsh       "$HOME"/.ctf_profile.zsh
ln -sf "$BASE_DIR"/tmux/.tmux.conf        "$HOME"/.tmux.conf
ln -sf "$BASE_DIR"/vim/.vimrc        "$HOME"/.vimrc
ln -sf "$BASE_DIR"/git/.gitconfig   "$HOME"/.gitconfig

echo -e "\n[+] Finish"