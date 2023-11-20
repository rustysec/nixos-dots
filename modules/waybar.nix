{
  ...
}:
{
  programs.waybar.enable = true;
  programs.waybar.settings = {
    main = {
      layer = "top";
      position = "top";
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "clock" ];
    };
  };
}
