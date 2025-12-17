#!/bin/bash

alias obsidian='obsidian --ozone-platform=wayland'
alias zen='~/.config/eww/scripts/zenmode.sh'
zenmsg() {
    eww update zenmsg="$*"
}

#   core
alias shut='sudo poweroff'
alias o='xdg-open'
alias e='${EDITOR:-vim}'
alias y='yazi'
alias t='task'
alias tt='task pri.not:x'
alias bk='cd ..'
alias reload='source ~/.bashrc && echo "ka-clunk~"'
alias bashr='e ~/.bash_aliases'
alias nmtui='NEWT_COLORS=$(<~/.config/nmtui/palette) nmtui'
alias s='sshs'
function s() {
    ssh "$1" || sshs
}

#   security
alias lockdown='rfkill block all'
alias lockdown-lift='sudo rfkill unblock all'
alias lock='swaylock'

#   renames/config loads
alias quickshell='swaymsg exec quickshell'
alias cat='bat'
alias enkidu='ncdu --color dark'
alias diff='delta'
alias cd='z'
alias grep='grep --color=auto'
alias rm='rm -i'
alias untar='sudo tar -xvzf'
alias {tailscale-tui,tailscaletui}='tsui'
#   Arch linux
if grep arch /etc/os-release >/dev/null; then
    alias invoke='sudo pacman -S'
    alias banish='sudo pacman -R'
    alias commune='sudo pacman -Syu'
fi

alias ydotool-daemon='sudo ydotoold -p /run/user/1000/.ydotool_socket -P 777'

#   ls
alias {eza,ls}='eza -1 --group-directories-first'
alias lt='eza -T'
alias ll='eza -laohb --no-time --no-permissions --group-directories-first'
alias la='eza -1a --all --group-directories-first'

#   docker
alias whale='sudo docker compose'
alias whaleup='sudo docker compose up -d'
alias whaledown='sudo docker compose down'
alias whaleseesaw='sudo docker compose down && sudo docker compose up -d'

#   git
alias gitscum='git add . && git commit -m "0" && git push && echo -e "\033[93mgit successfully scummed\033[0m"'

#   Devices
alias jotm='bluetoothctl connect AC:80:0A:2E:C9:07'

#   yt-dlp
alias ytdlp='yt-dlp'
alias ytmp3='yt-dlp --config-location ~/.config/yt-dlp/mp3'

#   homeshick
alias homescum='homeshick cd dotfiles && git add . && git commit -m "0" && git push && echo -e "\033[93mhome successfully scummed\033[0m"'
alias hometrack='homeshick track dotfiles'

#   hachiko
alias hachisync='ssh -L 8385:localhost:8384 hachiko'
alias hachiko-login='ssh root@192.168.0.3'

#   pablotronica
alias pablosync='ssh -L 8386:localhost:8384 pablotronica'

#   IrregularNotes
alias notesync='ssh -L 8387:localhost:8384 irregularnotes'
