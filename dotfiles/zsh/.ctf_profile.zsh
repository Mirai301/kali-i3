#!/usr/bin/env zsh

# keyboard layout
setxkbmap -layout jp

# atuin setting
eval "$(atuin init zsh)"

# Check if the operating system is macOS
if [[ $(uname) == "Darwin" ]]; then
    # macOS
    # echo "Running on macOS"
    PATH="$PATH:/opt/homebrew/bin/"
    export HOMEBREW_NO_ANALYTICS=1

    export TMUX_TMPDIR=/tmp
else
    # Kali Linux
    # some more ls aliases
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -CF'

    # reverse shell
    rev() {
        expect -c "spawn rlwrap nc -lvnp $1; \
                    expect \"$\"; \
                    send \"python3 -c 'import pty; pty.spawn(\\\"/bin/bash\\\")'\n\"; \
                    interact"
    }

    # enable auto-suggestions based on the history
    if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        # change suggestion color
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
    fi

    # enable command-not-found if installed
    if [ -f /etc/zsh_command_not_found ]; then
        . /etc/zsh_command_not_found
    fi

    # Go lang
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin

    # autorecon
    export PATH=$PATH:$HOME/.local/bin

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi