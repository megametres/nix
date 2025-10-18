{ pkgs, ... }:

{
  home.packages = with pkgs; [
    anyrun
    bat
    cargo
    curl
    element-desktop
    eza
    filezilla
    fzf
    gimp
    gnumake
    gtklock
    jan
    lazygit
    lm_sensors
    lmstudio
    neovim
    nixd
    onagre
    python3
    reversal-icon-theme
    ripgrep
    signal-desktop
    qalculate-gtk
    uv
    vscodium
    zed-editor
    waybar
    walker
    wleave
  ];

}
