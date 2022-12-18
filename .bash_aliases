alias upd='sudo apt update && sudo apt upgrade'
alias psgrep='ps ax |grep -v grep |grep'
alias hgrep='history |grep -v grep |grep'
alias ba='. ~/.bash_aliases'
alias lcl='lxc ls -c ns4DtS'
alias h-del-prev='history -d $(history |tail -n2|head -n1| sed "s/\*//; s/ *//; s/ .*$//")'
alias tree='tree -a -I "\.git"'
alias ..='cd ..'
alias ...='cd ../..'
alias ..h='cd ${HOME}'
alias ..d='cd ${HOME}/src/dotfiles'

#=========================================
# functions
#=========================================

function _mykill (){
  kill -9 $(psgrep $1 |awk '{print $1}')
}


function dlm3u8 () {
  ffmpeg -i "$1" -c copy ~/Videos/Av/$(date +%Y%m%d-%H%M-%S).mp4
}

function _history-clean () {
  cat ~/.bash_history > ~/.bash_history~
  __LIST=$(cat .history_clean_list | sed '/^$/d' |tr "\n" "|")
  __LIST="${__LIST/%?/}"
  echo $__LIST
  awk "!/$__LIST/" ~/.bash_history~ > ~/.bash_history
}
alias hc='_history-clean'


# for batcat
if which batcat > /dev/null; then
  alias cat='batcat'
fi

# for fzf
if which fzf > /dev/null; then
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
  # fkill - kill process
  fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
      echo $pid | xargs kill -${1:-9}
    fi
  }
fi

# for tmux
if which tmux > /dev/null; then
  [ -f ~/.tmux.session.conf ] && alias tmux-='tmux new-session \; source-file ~/.tmux.session.conf'
fi

