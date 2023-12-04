{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../laptop.nix
    inputs.home-manager.nixosModules.default
  ];
  networking.hostName = "helvetios";
  boot.loader.systemd-boot.consoleMode = "1";
}
