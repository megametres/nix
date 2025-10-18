{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "digital-7-font";
  version = "1.0";
  src = ../assets/fonts/digital-7.zip; # Path to your font archive

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 *.ttf -t $out/share/fonts/truetype
    runHook postInstall
  '';

}
