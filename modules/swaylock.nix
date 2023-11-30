{ wallpaper_lock
, ...
}:
{
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${wallpaper_lock}";
      text-color = "cdd6f4";
      text-clear-color = "cdd6f4";
      text-caps-lock-color = "cdd6f4";
      text-ver-color = "cdd6f4";
      text-wrong-color = "cdd6f4";
      color = "181825";
      inside-color = "00000000";
      inside-wrong-color = "00000000";
      inside-ver-color = "00000000";
      inside-clear-color = "00000000";
      ring-color = "7f849c";
      ring-clear-color = "a6e4a1";
      ring-ver-color = "94e2d5";
      ring-wrong-color = "f38ba8";
      line-uses-ring = true;
      bs-hl-color = "cba6f7";
      key-hl-color = "a6e3a1";
      separator-color = "7f849c";
    };
  };
}
