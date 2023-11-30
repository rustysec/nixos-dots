{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    inputs.home-manager.nixosModules.default
  ];
  networking.hostName = "nixos";
}
