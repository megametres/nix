{
  pkgs,
  ...
}:
{
  imports = [
    ./metres/packages.nix
  ];

  programs.home-manager.enable = true;

  home.username = "metres";
  home.homeDirectory = "/home/metres";

  # Home Manager dotfiles.
  home.file = let
      theme = import ./metres/theme.nix {};
    in
    {
    ".config/fish/config.fish".text = theme.replaceThemeVariables ./custom_config/fish/config.fish;
    ".config/git".source = ./custom_config/git;
    ".config/helix".source = ./custom_config/helix;
    ".config/hypr/hyprland.conf".text = theme.replaceThemeVariables ./custom_config/hypr/hyprland.conf;
    ".config/kitty/kitty.conf".text = theme.replaceThemeVariables ./custom_config/kitty/kitty.conf;
    ".config/nvim/init.lua".text = theme.replaceThemeVariables ./custom_config/nvim/init.lua;
    #".config/onagre/theme.scss".text = theme.replaceThemeVariables ./custom_config/onagre/theme.scss;
    ".config/waybar/config".source = ./custom_config/waybar/config;
    ".config/waybar/style.css".text = theme.replaceThemeVariables ./custom_config/waybar/style.css;
    ".config/wleave/icons".source = ./custom_config/wleave/icons;
    ".config/wleave/layout".source = ./custom_config/wleave/layout;
    ".config/wleave/style.css".text = theme.replaceThemeVariables ./custom_config/wleave/style.css;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nixpkgs.config = {
    allowUnfree = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    hardware.opengl.enable = true;
    hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];
    environment.systemPackages = with pkgs; [
      rocm-smi
      rocminfo
      rocm-opencl-runtime
    ];
  };
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };



  home.stateVersion = "24.11";
}
