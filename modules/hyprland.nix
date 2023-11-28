{ wallpaper
, ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      bindm = [
        "SUPER,       mouse:272,    movewindow"
        "SUPER,       mouse:273,    resizewindow"
      ];

      bind = [
        "$mod,        a,      exec, foot"
        "$mod,        RETURN, exec, foot -e tmux new"
        "$mod,        SPACE,  exec, fuzzel"
        "SUPERSHIFT,  q,      killactive"
        "SUPERSHIFT,  e,      exec, bash ~/.config/locker/menu.sh"

        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"
        "$mod, H,     movefocus, l"
        "$mod, L,     movefocus, r"
        "$mod, K,     movefocus, u"
        "$mod, J,     movefocus, d"

        "$mod, 1,     workspace, 1"
        "$mod, 2,     workspace, 2"
        "$mod, 3,     workspace, 3"
        "$mod, 4,     workspace, 4"
        "$mod, 5,     workspace, 5"
        "$mod, 6,     workspace, 6"
        "$mod, 7,     workspace, 7"
        "$mod, 8,     workspace, 8"
        "$mod, 9,     workspace, 9"
        "$mod, 0,     workspace, 10"

        "$mod SHIFT,  1,    movetoworkspace, 1"
        "$mod SHIFT,  2,    movetoworkspace, 2"
        "$mod SHIFT,  3,    movetoworkspace, 3"
        "$mod SHIFT,  4,    movetoworkspace, 4"
        "$mod SHIFT,  5,    movetoworkspace, 5"
        "$mod SHIFT,  6,    movetoworkspace, 6"
        "$mod SHIFT,  7,    movetoworkspace, 7"
        "$mod SHIFT,  8,    movetoworkspace, 8"
        "$mod SHIFT,  9,    movetoworkspace, 9"
        "$mod SHIFT,  0,    movetoworkspace, 10"

        "$mod,        P,          exec,grim -g \"$(slurp -d)\" - | wl-copy -t image/png"
        ",XF86AudioRaiseVolume,   exec,pamixer -ui 2 && dc -e \"[`pamixer --get-volume`]sM 100d `pamixer --get-volume`<Mp\""
        ",XF86AudioLowerVolume,   exec,pamixer -ud 2 && dc -e \"[`pamixer --get-volume`]sM 100d `pamixer --get-volume`<Mp\""
        ",XF86AudioMute,          exec,pamixer --toggle-mute && ( pamixer --get-mute && echo 0 )"
        ",XF86AudioMicMute,       exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        ",XF86MonBrightnessDown,  exec,light -U 5%"
        ",XF86MonBrightnessUp,    exec,light -A 5%"
        ",XF86AudioPlay,          exec,playerctl play-pause"
        ",XF86AudioNext,          exec,playerctl next"
        ",XF86AudioPrev,          exec,playerctl previous"
        ",Print,                  exec,grim -g \"$(slurp)\" - | wl-copy"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      decoration = {
        rounding = 0;

        blur = {
          enabled = false;
          size = 10;
          passes = 3;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        resize_on_border = true;
        layout = "master";
      };

      master = {
        new_is_master = false;
        smart_resizing = false;
      };

      dwindle = {
        force_split = 2;
        preserve_split = 2;
      };

      gestures = {
        workspace_swipe = true;
      };

      "device:at-translated-set-2-keyboard" = {
        kb_layout = "us";
        kb_variant = "colemak";
        kb_options = "caps:swapescape";
      };

      exec = [
        "pkill -9 kanshi; kanshi"
        "pkill -9 waybar ; waybar"
        "blueman-applet"
        "mako"
        "nm-applet --indicator"
        "swaybg -m fill --image ${wallpaper}"
        "swayidle -w timeout 300 'swaylock' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock'"

        "hyprctl setcursor Catppuccin-Frappe-Dark-Cursors 24"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
        "gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Mocha-Standard-Blue-Dark'"
        "gsettings set org.gnome.desktop.interface icon-theme 'Papirus'"
        "gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Frappe-Dark-Cursors'"
      ];
    };

    extraConfig = ''
      env = GTK_THEME,Catppuccin-Mocha-Standard-Blue-Dark

      $rosewaterAlpha = f5e0dc
      $flamingoAlpha  = f2cdcd
      $pinkAlpha      = f5c2e7
      $mauveAlpha     = cba6f7
      $redAlpha       = f38ba8
      $maroonAlpha    = eba0ac
      $peachAlpha     = fab387
      $yellowAlpha    = f9e2af
      $greenAlpha     = a6e3a1
      $tealAlpha      = 94e2d5
      $skyAlpha       = 89dceb
      $sapphireAlpha  = 74c7ec
      $blueAlpha      = 89b4fa
      $lavenderAlpha  = b4befe

      $textAlpha      = cdd6f4
      $subtext1Alpha  = bac2de
      $subtext0Alpha  = a6adc8

      $overlay2Alpha  = 9399b2
      $overlay1Alpha  = 7f849c
      $overlay0Alpha  = 6c7086

      $surface2Alpha  = 585b70
      $surface1Alpha  = 45475a
      $surface0Alpha  = 313244

      $baseAlpha      = 1e1e2e
      $mantleAlpha    = 181825
      $crustAlpha     = 11111b

      $rosewater = 0xfff5e0dc
      $flamingo  = 0xfff2cdcd
      $pink      = 0xfff5c2e7
      $mauve     = 0xffcba6f7
      $red       = 0xfff38ba8
      $maroon    = 0xffeba0ac
      $peach     = 0xfffab387
      $yellow    = 0xfff9e2af
      $green     = 0xffa6e3a1
      $teal      = 0xff94e2d5
      $sky       = 0xff89dceb
      $sapphire  = 0xff74c7ec
      $blue      = 0xff89b4fa
      $lavender  = 0xffb4befe

      $text      = 0xffcdd6f4
      $subtext1  = 0xffbac2de
      $subtext0  = 0xffa6adc8

      $overlay2  = 0xff9399b2
      $overlay1  = 0xff7f849c
      $overlay0  = 0xff6c7086

      $surface2  = 0xff585b70
      $surface1  = 0xff45475a
      $surface0  = 0xff313244

      $base      = 0xff1e1e2e
      $mantle    = 0xff181825
      $crust     = 0xff11111b

      general {
          col.active_border = $teal $lavender 45deg
          col.inactive_border = $overlay0
      }

      animations {
          enabled = true
          bezier = ease, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 4, ease
          animation = windowsOut, 1, 4, ease, popin 80%
          animation = fade, 1, 3, ease
          animation = workspaces, 1, 3.5, ease
          animation = border, 1, 6, ease
      }

      input {
          kb_layout = us
          kb_variant = colemak

          follow_mouse = 1
          touchpad {
              natural_scroll = true
              clickfinger_behavior = true 
              tap-to-click = false
          }
      }
    '';
  };
}
