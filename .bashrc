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

set -o vi
export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'
export XDG_CONFIG_HOME="$HOME/.config"

alias ohno='flatpak run org.eclipse.Java'
alias ls='ls --color'
alias stallman='systemctl --user start emacs.service'
alias stalfos='systemctl --user stop emacs.service'

alias quello='cmake -S . -B build'
alias quella='cd build; make'

alias nvim-sync="nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"

unset rc
. "$HOME/.cargo/env"
