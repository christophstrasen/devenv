export PATH="$PATH:$HOME/.local/bin"
export TERM=xterm-256color

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1 \
POWERLINE_BASH_SELECT=1 \
	. /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh

export FZF_DEFAULT_OPTS='--color=light,hl:12,hl+:15,info:10,bg+:4'

alias nyan='nc -v nyancat.dakko.us 23'
alias tmate='tmate -f ~/.tmate.conf'


alias vim='nvim'
export EDITOR=nvim
export PATH=$PATH:/root/.local/bin

gc() {
	local commit='EDITOR=nvim git commit || bash'
	local diff='TERM=xterm-256color GIT_PAGER="less -+F" git diff --staged'

	tmux new-window "$commit" \; split-window -dh "$diff"
}
