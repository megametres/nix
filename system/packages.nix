{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asdf-vm
    firefox
    gcc
    git
    helix
    keepass
    kitty
    librewolf
    pulseaudio
    pavucontrol
    rocmPackages.amdsmi
    unzip
    zip
  ];
}
