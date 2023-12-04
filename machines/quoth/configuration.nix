{ inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../common.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "quoth";
  boot.loader.systemd-boot.consoleMode = "1";
}
