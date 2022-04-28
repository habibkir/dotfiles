# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

#user defined aliases
alias ll="ls -la"
alias llg="ls -la | grep"
alias mks="touch s && chmod u+x s && echo \"#! /bin/bash\" >> s && vim s"
alias kys="shutdown now"
alias emacs="emacs --no-window-system"

#User added commands, beware, it might fuck the whole system, again

xrandr --output DSI-1 --rotate right
setxkbmap -option caps:swapescape
#set -o vi #uncomment if it doesn't fuck with emacs from console
unclutter --timeout 4 &
#setfont /usr/lib/kbd/consolefonts/lat4a-19.psfu.gz

unset rc

