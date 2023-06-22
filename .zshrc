# Local Aliases
alias hm='cd ~'
alias zconf='ne ~/.zshrc'
alias nconf='ne ~/.config/nvim'
alias kconf='ne ~/.config/kitty'
alias ffconf='cd ~/Library/Application\ Support/Firefox/Profiles'
alias src='omz reload'
alias tm='tmux'
alias ne='nvim'
alias nef='ne $(fzf)'
alias na='lvim'
alias ls='exa -l -h -F'
alias lst='exa -T'

# Dev aliases
alias pn='pnpm'
alias dcu='docker compose up -d'
alias dcd='docker compose down'

# Pass a string to ripgrep -> results to fzf -> open the file in neovim and jump to that line
openJumpTo() {
    selected=$(rg -n $1 | fzf)

    if [[ $selected ]]
    then
        string_split=("${(@s/:/)selected}")
        filename=$string_split[1]
        line_number=$string_split[2]
        ne $filename +$line_number
        echo 'Selected: ' $filename $line_number
    fi
}

# Copy this line to your local rc file to open this container on your local directory
neovimDocker() {
    docker run \
        --rm -it \
        -v $(pwd):/mnt/workspace \
        -v $HOME/.dotfiles/nvim:/home/neovim/.config/nvim \
        nicodebo/neovim-docker:latest \
        "$@"
       }

# fzf and ripgrep power aliases
alias rgf='f() { rg -l $1 | fzf }; f'
alias opj='openJumpTo'

# Copy this line to your local rc file to open this container on your local directory
alias nd='neovimDocker'

# Chrome aliases
alias bug='//Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'

# Misc Aliases
alias cl='clear'
alias ysku='brew services start yabai && brew services start skhd'
alias yskd='brew services stop yabai && brew services stop skhd'
