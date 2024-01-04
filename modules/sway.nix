{ config
, pkgs
, wallpaper
, ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "foot";
      gaps = {
        inner = 5;
        outer = 5;
      };
      window.titlebar = false;
      bars = [ ];
      fonts = {
        names = [ "Hack" "Font Awesome 6 Free" ];
        size = 13.0;
      };
      startup = [
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }

        { command = "kanshi"; always = true; }
        { command = "waybar"; }
        { command = "swaybg -m fill --image ${wallpaper}"; }
        { command = ''swayidle -w timeout 300 'swaylock' timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' before-sleep 'swaylock' ''; }
        { command = "blueman-applet"; }
        { command = "mako"; }
        { command = "nm-applet --indicator"; }

        { command = "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"; }
        { command = "gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Mocha-Standard-Blue-Dark'"; }
        { command = "gsettings set org.gnome.desktop.interface icon-theme 'Papirus'"; }
        { command = "gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Frappe-Dark-Cursors'"; }
      ];
    };
    extraConfig = ''
      set $rosewater #f5e0dc
      set $flamingo  #f2cdcd
      set $pink      #f5c2e7
      set $mauve     #cba6f7
      set $red       #f38ba8
      set $maroon    #eba0ac
      set $peach     #fab387
      set $yellow    #f9e2af
      set $green     #a6e3a1
      set $teal      #94e2d5
      set $sky       #89dceb
      set $sapphire  #74c7ec
      set $blue      #89b4fa
      set $lavender  #b4befe
      set $text      #cdd6f4
      set $subtext1  #bac2de
      set $subtext0  #a6adc8
      set $overlay2  #9399b2
      set $overlay1  #7f849c
      set $overlay0  #6c7086
      set $surface2  #585b70
      set $surface1  #45475a
      set $surface0  #313244
      set $base      #1e1e2e
      set $mantle    #181825
      set $crust     #11111b

      client.focused           $teal     $base $text  $mauve $teal
      client.focused_inactive  $overlay0 $base $text  $overlay0 $overlay0
      client.unfocused         $overlay0 $base $text  $overlay0 $overlay0
      client.urgent            $peach    $base $peach $peach    $peach
      client.placeholder       $overlay0 $base $text  $overlay0 $overlay0
      client.background        $base

      input "1267:12624:ELAN0670:00_04F3:3150_Touchpad" {
        dwt enabled
        natural_scroll enabled
        click_method clickfinger
      }

      input "1739:52710:DLL0945:00_06CB:CDE6_Touchpad" {
        dwt enabled
        natural_scroll enabled
        click_method clickfinger
      }

      input "76:613:Apple_Inc._Magic_Trackpad_2" {
        dwt enabled
        natural_scroll enabled
        click_method clickfinger
      }

      input "1452:613:Apple_Inc._Magic_Trackpad" {
        dwt enabled
        natural_scroll enabled
        click_method clickfinger
      }

      exec_always swaymsg input "1:1:AT_Translated_Set_2_keyboard" {
        xkb_layout "us"
        xkb_variant "colemak"
        xkb_options caps:swapescape
      }

      input "1452:834:Apple_Internal_Keyboard_/_Trackpad" {
        dwt enabled
        natural_scroll enabled
        click_method clickfinger
        xkb_layout "us"
        xkb_variant "colemak"
        xkb_options caps:swapescape
      }

      bindgesture swipe:3:right workspace prev
      bindgesture swipe:3:left workspace next

      for_window [app_id="^blueman-manager$"] floating enable, resize set 500 500
      for_window [app_id="^.blueman-manager-wrapped$"] floating enable, resize set 500 500
      for_window [app_id="^pavucontrol$"] floating enable, resize set 1000 1000
      for_window [app_id="^nm-connection-editor$"] floating enable, resize set 1000 1000
      for_window [app_id="^nm-openconnect-auth-dialog$"] floating enable, resize set 1000 1000
      for_window [window_role="dialog"] floating enable
    '';
    config.keybindings =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
      {
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Return" = "exec ${pkgs.foot}/bin/foot -e tmux new";
        "${modifier}+Shift+Return" = "exec ${pkgs.foot}/bin/foot";
        "${modifier}+Space" = "exec ${pkgs.fuzzel}/bin/fuzzel";
        "${modifier}+Shift+e" = "exec bash ~/.config/locker/menu.sh";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        "${modifier}+bar" = "splith";
        "${modifier}+minus" = "splitv";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+Shift+f" = "fullscreen";
        "${modifier}+Shift+t" = "floating toggle";
        "${modifier}+t" = "focus mode_toggle";
        "${modifier}+a" = "focus parent";
        "${modifier}+c" = "focus child";

        "${modifier}+Shift+x" = "move scratchpad";
        "${modifier}+x" = "scratchpad show";

        "${modifier}+p" = "exec grim -g \"$(slurp -d)\" - | wl-copy -t image/png";
        "Print" = "exec grim -g \"$(slurp -d)\" - | wl-copy -t image/png";
        "XF86AudioRaiseVolume" = "exec pamixer -ui 2 && dc -e \"[`pamixer --get-volume`]sM 100d `pamixer --get-volume`<Mp\"";
        "XF86AudioLowerVolume" = "exec pamixer -ud 2 && dc -e \"[`pamixer --get-volume`]sM 100d `pamixer --get-volume`<Mp\"";
        "XF86AudioMute" = "exec pamixer --toggle-mute && ( pamixer --get-mute && echo 0 )";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec light -U 5%";
        "XF86MonBrightnessUp" = "exec light -A 5%";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
      };
  };
}
