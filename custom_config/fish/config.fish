if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

function fish_prompt
    echo -n ' '(set_color $${primaryColor4})(prompt_pwd)' '

    set_color -o
    if fish_is_root_user
        echo -n (set_color red)'#'
    end
    echo -n (set_color $${primaryColor3})'❯'(set_color $${primaryColor4})'❯'(set_color $${primaryColor5})'❯ '
    set_color normal
end

# Clean up
abbr nc 'sudo nix-env --delete-generations +1 && sudo nix-collect-garbage -d'
# Update
abbr nu 'cd ~/nix; nix flake update'
# Build config/flakes
abbr nbc  'sudo nixos-rebuild switch --flake ~/nix'
# Build Home-manager
abbr nbh 'home-manager switch --flake ~/nix'
# Build Home-manager with backup
abbr nbhb 'nix run home-manager/master -- switch -b backup --flake ~/nix'
# Search nix packages
abbr ns 'nix-env -qaP --description'

alias l 'eza -lh --group-directories-first'
alias la 'eza -lha --group-directories-first'
abbr ri 'rg -i'
abbr s 'sudo'

bind alt-l downcase-word
bind alt-home begin-selection
bind alt-end end-selection


fish_add_path ~/.local/bin

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
