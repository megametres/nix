{ config, pkgs, ... }:

{
  boot.supportedFilesystems."fuse.sshfs" = true;

  fileSystems."/mnt/kee" = {
    device = "pi@maison.xn--sauv-epa.com:/mnt/keypass";
    fsType = "fuse.sshfs";
    options = [
      "identityfile=/home/metres/.ssh/id_ed25519_pi"
      "port=11122"
      "nodev"
      "noatime"
      "allow_other"
    ];
  };

}
