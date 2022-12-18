#!/bin/bash

#---------------------
# git install
#---------------------

function install_vim(){
    echo vim install
    sudo apt update
    sudo apt install curl
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update
    sudo apt upgrade
}
function install_dein(){
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh ./installer.sh ~/.cache/dein
  rm ./installer.sh
}
function _uninstall(){
    echo "not imple!"
}


function main(){
  if [[ $1 = "-r" ]]; then
  	_uninstall
  else
  	install_vim
  	install_dein
  fi
}

main $@
