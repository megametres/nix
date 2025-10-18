{ config, lib, modulesPath, pkgs, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "fuse" ];
  boot.kernelParams = [ "module_blacklist=nvidia,nvidia_drm,nvidia_modeset,nouveau" ];
  boot.extraModulePackages = [ ];

  boot.blacklistedKernelModules = [ "nvidia" "nvidia_drm" "nvidia_modeset" "nouveau" ];
  services.udev.extraRules = ''
    # Disable NVIDIA PCI devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{remove}="1"
  '';

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d48f7b52-3054-4965-a232-b0911847062d";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-99824202-abb9-4b94-b96a-bb2ebc5bd0e2".device = "/dev/disk/by-uuid/99824202-abb9-4b94-b96a-bb2ebc5bd0e2";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8C9A-F43A";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/mnt/kee" =
    { device = "pi@maison.xn--sauv-epa.com:/mnt/keypass";
      fsType = "fuse.sshfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/8babfeb7-8c39-471e-8707-c4d09b3b6027"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.graphics = {
      enable = true;
      enable32Bit =true;
      extraPackages = with pkgs; [ mesa rocmPackages.clr.icd ];
    };
}
