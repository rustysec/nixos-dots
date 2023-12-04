{ inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../common.nix
      ../../laptop.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "sucellus";
}
