if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    starship init fish | source
    direnv hook fish | source

    alias ls='eza -F=always -lh --color-scale'
    alias cat=bat
    alias pkgi="yay -Qq | fzf --preview 'yay -Qil {}' --height=97% --layout=reverse --bind 'enter:execute(yay -Qil {} | less)'"

    set -g fish_key_bindings fish_vi_key_bindings
end
