#!/usr/bin/env bash
set -e
INSTALL_BASE="${HOME}/src"

mkdir -p ${INSTALL_BASE}

cd ${INSTALL_BASE}

git clone https://github.com/kusaki-lab/dotfiles.git

cd ./dotfiles

./install-bat.sh
./install-fzf.sh
./install-vim.sh

./setup.sh
