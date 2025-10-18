{ pkgs, ... }:

{
  imports = [
    #./system/fonts.nix
    ./system/gdm.nix
    # Include the results of the hardware scan.
    ./system/hardware-configuration.nix
    ./system/keepass-maison.nix
    ./system/packages.nix
  ];

#  boot.kernelPackages = pkgs.linuxPackages_latest;

#  hardware.opengl.enable = true;
#  hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];

#  environment.systemPackages = with pkgs; [
#    rocm-smi
#    rocminfo
#    rocm-opencl-runtime
#  ];

 # nix.settings.extra-sandbox-paths = [
 #   "/dev/kfd"
 #   "/sys/devices/virtual/kfd"
 #   "/dev/dri/renderD128"
 # ];




  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    extra-sandbox-paths = [
      "/dev/kfd"
      "/sys/devices/virtual/kfd"
      "/dev/dri/renderD128"
    ];
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "abeille";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Montreal";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_CA.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "ca";
    videoDrivers = [ "amdgpu" ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  environment.variables = {
    EDITOR = "nvim";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.metres = {
    isNormalUser = true;
    description = "Daniel Sauvé";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
      userland-proxy = false;
      experimental = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # SDDM in Wayland
  #services.displayManager.sddm.wayland.enable = true ;

  services.desktopManager.plasma6.enable = true ;
  programs.hyprland.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
  ];

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";


  # Enable fish.
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    asdf-vm
  ];

  systemd.tmpfiles.rules = 
  let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  services.logrotate.checkConfig = false;

  system.stateVersion = "24.11"; # Do not change

}
