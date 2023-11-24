{
  description = "russ's nixos configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = github:hyprwm/Hyprland;

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixvim,
    home-manager,
    hyprland,
  } @ inputs: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./machines/vm/configuration.nix
      ];
    };
    nixosConfigurations.helvetios = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./machines/helvetios/configuration.nix
      ];
    };
  };
}
