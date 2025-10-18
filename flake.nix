{
  description = "NixOS configuration with ROCm overlay";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-rocm.url = "github:nixos-rocm/nixos-rocm";
  };

  outputs = { nixpkgs, home-manager, nixos-rocm, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      nixosConfigurations = {
        abeille = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
          # Add sandbox paths here inside the configuration attribute set
        };
      };
      homeConfigurations = {
        metres = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./home.nix ];
        };
      };
    };
}
