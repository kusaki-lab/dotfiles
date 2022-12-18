#!/usr/bin/env bash
set -Ceuo pipefail

# BACKUP_NAME=$(date +%Y%m%d-%H%M-%S)
readonly SCRIPT_DIR=$(cd $(dirname $0);pwd)
readonly SCRIPT_NAME=$(basename $0)
readonly BACKUP_NAME="ent"
readonly BACKUP_DIR="${HOME}/backup/dotfiles"
readonly BACKUP_PATH=${BACKUP_DIR}/${BACKUP_NAME}
readonly LOG_FILE="${BACKUP_DIR}/log.txt"
# echo $BACKUP_NAME
# echo $BACKUP_DIR
echo $BACKUP_PATH

restore()
{
  if [ ! -d ${BACKUP_PATH} ]; then
    echo 'no backup folder' "[${BACKUP_PATH}]"
    exit
  fi
  if [ $(find ${BACKUP_PATH} -type f | wc -l) -eq 0 ]; then
    echo 'no backup files'
    exit
  fi
  read -p "restore: ok?[Y/n]>" ans; [[ ! $ans =~ ^$|(^Y|y$) ]] && exit


  echo '=================='
  echo ' restore dotfiles :'"$(date)"
  IFS='|'
  while read src dst; do
    echo -----
    if [ -z $dst ]; then
      dst=${HOME}/${src}
    fi
    src=${SCRIPT_DIR}/${src}

    echo -n "SRC: $src "
    if [ ! -e ${src} ]; then
      echo '[no src file]'
      continue
    else
      echo '[exist]'
    fi

    echo -n "DST: $dst "
    if [ ! -e $dst ]; then
      echo '[no dst]'
    elif [ -L $dst ]; then
      echo '[link file]'
      rm -v $dst
    elif [ -f $dst ]; then
      echo '[file]'
    elif [ -d $dst ]; then
      echo '[directory]'
    fi
  done < <(cat ${SCRIPT_DIR}/setup.list | grep -v '^#')

  mv -fv ${BACKUP_PATH}/{*,.[^\.]*} .
  echo -----
  echo -e "end\n"
}

setup()
{
  read -p "setup: ok?[Y/n]>" ans; [[ ! $ans =~ ^$|(^Y|y$) ]] && exit

  echo '=================='
  echo ' setup dotfiles :'"$(date)"
  IFS='|'
  while read src dst; do
    echo -----
    if [ -z $dst ]; then
      dst=${HOME}/${src}
    fi
    src=${SCRIPT_DIR}/${src}

    echo -n "SRC: $src "
    if [ ! -e ${src} ]; then
      echo '[no src file]'
      continue
    else
      echo '[exist]'
    fi

    echo -n "DST: $dst "
    if [ ! -e $dst ]; then
      echo '[no dst]'
    elif [ -L $dst ]; then
      echo '[link file]'
      mv -nv ${dst} ${BACKUP_PATH}
    elif [ -f $dst ]; then
      echo '[file]'
      mv -nv ${dst} ${BACKUP_PATH}
    elif [ -d $dst ]; then
      echo '[directory]'
      mv -nv ${dst} ${BACKUP_PATH}
    fi
    ln -sfv ${src} ${dst}
  done < <(cat ${SCRIPT_DIR}/setup.list | grep -v '^#')
  echo -----
  echo -e "end\n"
}

mkdir -vp ${BACKUP_PATH}
touch $LOG_FILE
(if [ $# -eq 0 ]; then
  setup
elif [ $1 = '-r' ]; then
  restore
fi) | tee -a $LOG_FILE
exit

