{ pkgs
, ...
}:
{
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      prompt = "'󰍉 '";
      terminal = "${pkgs.foot}/bin/foot";
      font = "Hack Nerd Font:size=20";
      layer = "overlay";
      icon-theme = "Papirus";
      horizontal-pad = 100;
      vertical-pad = 50;
      inner-pad = 20;
      width = 50;
    };
    colors = {
      border = "94e2d5ff";
      background = "181825ff";
      text = "cdd6f4ff";
      selection = "9399b2ff";
    };
    border = {
      width = 5;
      radius = 0;
    };
  };
}
