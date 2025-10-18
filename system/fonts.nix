{ pkgs, ... }:

let
  digital-7 = pkgs.callPackage ../packages/digital-7-font.nix {};
in
{
  fonts.packages = with pkgs; [
    digital-7
    nerd-fonts.commit-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.iosevka-term-slab
  ];
  fonts.fontDir.enable = true;
  fonts.enableGhostscriptFonts = true;
  fonts.enableDefaultPackages = true;
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "IosevkaTermSlab" ];
      sansSerif = [ "FantasqueSansMono" ];
      monospace = [ "CommitMono" ];
    };
  };

}
