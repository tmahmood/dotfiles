if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    starship init fish | source
    direnv hook fish | source
    atuin init fish | source
    set -g TERM xterm-256color
    set -gx PATH $PATH ~/bin
    set -gx PATH $PATH ~/.cargo/bin
    set -gx TERMINAL ptyxis
    set -gx EDITOR vim

    alias ls='eza -F=always --icons always --color-scale'
    alias cat=bat
    alias pkgi="yay -Qq | fzf --preview 'yay -Qil {}' --height=97% --layout=reverse --bind 'enter:execute(yay -Qil {} | less)'"
    fish_add_path "/home/mahmood/.local/bin"

    set -g fish_key_bindings fish_vi_key_bindings
end
