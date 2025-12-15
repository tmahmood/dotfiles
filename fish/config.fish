if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    starship init fish | source
    if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
        unset "$DIRENV_*"  # unset env vars starting with DIRENV_
    end
    direnv hook fish | source
    atuin init fish | source
    set -g TERM xterm-256color
    set -gx PATH $PATH ~/bin
    set -gx PATH $PATH ~/.cargo/bin
    set -gx TERMINAL ptyxis
    set -gx EDITOR vim
    set -gx VCPKG ~/vcpkg

    alias ls='eza -F=always --icons always --color-scale'
    alias cat=bat
    alias pkgi="yay -Qq | fzf --preview 'yay -Qil {}' --height=97% --layout=reverse --bind 'enter:execute(yay -Qil {} | less)'"
    fish_add_path "/home/mahmood/.local/bin"
    # ensure compatibility tmux <-> direnv


    set -g fish_key_bindings fish_vi_key_bindings
end
