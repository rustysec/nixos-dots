{ inputs, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../common.nix
      inputs.home-manager.nixosModules.default
    ];

  hardware.opengl.extraPackages = [
    pkgs.rocmPackages.clr.icd
    pkgs.amdvlk
  ];

  networking.hostName = "quoth";
  boot.loader.systemd-boot.consoleMode = "1";
}
