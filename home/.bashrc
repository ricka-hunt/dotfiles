
case $- in
*i*) ;;
*) return ;;
esac

#   bash history stuff
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alertrm "$1" && echo "Removed file: $1"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# changes manpage pager
# export PAGER='glow'
export LESS="-R"

#--------------
#   completion stuff

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# case-insensitive completion
bind -s 'set completion-ignore-case on' >/dev/null
#--------------

#   paths
export PATH="$PATH:~/.shells"
export PYTHONPATH="${PYTHONPATH}:~/.shells"
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR=nvim
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

#   eza
export EZA_ICONS_AUTO=always

#   FZF
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/fzf-config
eval "$(fzf --bash)"

#   starship
eval "$(starship init bash)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

#   homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

#   zoxide
eval "$(zoxide init bash)"

#   yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

echo -e -n "\x1b[\x35 q" # changes to blinking bar

# export RESTIC_REPOSITORY=~/restic-repo
# export RESTIC_PASSWORD=reallystrongpassword

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Eternal bash history.
# https://stackoverflow.com/a/19533853
#export HISTFILESIZE=
#export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export XDG_FILE_MANAGER=nemo

# wayland
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export ELECTRON_OZONE_PLATFORM_HINT=x11
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export ELECTRON_OZONE_PLATFORM_HINT=wayland

source ~/.task/task_completions.sh
