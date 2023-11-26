{ pkgs
, ...
}:
{
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      terminal = "${pkgs.foot}/bin/foot";
      font = "Hack Nerd Font:size=11";
      layer = "overlay";
      icon-theme = "Adwaita";
      horizontal-pad = 50;
      vertical-pad = 15;
    };
    colors = {
      border = "33ccffee";
      background = "1a1c1eff";
      text = "ffffffff";
      selection = "151718ff";
    };
    border = {
      width = 5;
      radius = 0;
    };
  };
}
