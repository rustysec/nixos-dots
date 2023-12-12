{ pkgs, ... }:
{
  powerManagement.powertop.enable = true;

  services.tlp = {
    enable = true;
  };

  hardware.opengl.extraPackages = [
    pkgs.intel-compute-runtime
    pkgs.intel-media-driver
  ];
}
