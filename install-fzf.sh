#!/usr/bin/env bash
set -e
INSTALL_BASE="${HOME}/src"

install()
{
  echo install
  if [ ! -d $INSTALL_BASE ]; then
    echo "${INSTALL_BASE} not found."
    exit
  fi
  if [ -d ${INSTALL_BASE}/fzf ]; then
    echo "${INSTALL_BASE}/fzf already exist."
    exit
  fi

  git clone --depth 1 https://github.com/junegunn/fzf.git ~/src/fzf
  cd ${INSTALL_BASE}/fzf && ./install
}

uninstall()
{
  echo uninstall
  cd ${INSTALL_BASE}/fzf && ./uninstall
  rm -rfv ${INSTALL_BASE}/fzf
}


update()
{
  echo update
  cd ${INSTALL_BASE}/fzf && git pull && ./install
}


if [ $# -eq 0 ]; then
  install
elif [ $1 = '-r' ]; then
  uninstall
elif [ $1 = '-u' ]; then
  update
else
  echo 'undefined option'
  echo '-r: uninstall'
  echo '-u: update'
fi
