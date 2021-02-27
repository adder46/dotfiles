# safer rm
alias rm='rm -I'

#ls
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# xclip
alias xcp='xclip -selection clipboard'

# termbin
alias tb='nc termbin.com 9999'

# pyhstr
alias py="python3 -ic 'from pyhstr import hh'"

# dpaster
alias dpaster='~/.venvs/env-dpaster/bin/dpaster'

# hstr-rs
alias hh='hstr-rs bash'
