{ ...
}:
{
  programs.waybar.enable = true;
  programs.waybar.settings = {
    main = {
      layer = "top";
      position = "top";
      spacing = 4;
      modules-left = [ "hyprland/workspaces" "mpris" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "pulseaudio" "battery" "backlight" "cpu" "memory" "clock" "tray" ];

      "tray" = {
        spacing = 10;
      };

      "mpris" = {
        dynamic-len = 25;
      };

      "clock" = {
        format = "{:%a | %b %d | %H:%M}";
      };

      "hyprland/window" = {
        max-length = 25;
      };

      "cpu" = {
        "format" = "{usage}% ";
        "tooltip" = false;
      };

      "memory" = {
        "format" = "{}% ";
      };

      "backlight" = {
        "format" = "{percent}% {icon}";
        "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
      };

      "battery" = {
        "states" = {
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-alt" = "{time} {icon}";
        "format-icons" = [ "" "" "" "" "" ];
      };

      "pulseaudio" = {
        "format" = "{volume}% {icon} {format_source}";
        "format-bluetooth" = "{volume}% {icon}  {format_source}";
        "format-bluetooth-muted" = " {icon}  {format_source}";
        "format-muted" = " {format_source}";
        "format-source" = "{volume}% ";
        "format-source-muted" = "";
        "format-icons" = {
          "headphone" = "";
          "hands-free" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = [ "" "" "" ];
        };
        "on-click" = "pavucontrol";
      };

      "mpris" = {
        "format" = "{status_icon} {player_icon} {artist} - {title}";
        "player-icons" = {
          "default" = "🎵";
          "chrome" = "";
          "chromium" = "";
          "firefox" = "";
        };
        "status-icons" = {
          "paused" = "";
          "playing" = "";
        };
      };

      "bluetooth" = {
        "format" = " {status}";
        "format-connected" = " {device_alias}";
        "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
      };
    };
  };

  programs.waybar.style = ''
    /*
    *
    * Catppuccin Mocha palette
    * Maintainer: rubyowo
    *
    */

    @define-color base   #1e1e2e;
    @define-color mantle #181825;
    @define-color crust  #11111b;

    @define-color text     #cdd6f4;
    @define-color subtext0 #a6adc8;
    @define-color subtext1 #bac2de;

    @define-color surface0 #313244;
    @define-color surface1 #45475a;
    @define-color surface2 #585b70;

    @define-color overlay0 #6c7086;
    @define-color overlay1 #7f849c;
    @define-color overlay2 #9399b2;

    @define-color blue      #89b4fa;
    @define-color lavender  #b4befe;
    @define-color sapphire  #74c7ec;
    @define-color sky       #89dceb;
    @define-color teal      #94e2d5;
    @define-color green     #a6e3a1;
    @define-color yellow    #f9e2af;
    @define-color peach     #fab387;
    @define-color maroon    #eba0ac;
    @define-color red       #f38ba8;
    @define-color mauve     #cba6f7;
    @define-color pink      #f5c2e7;
    @define-color flamingo  #f2cdcd;
    @define-color rosewater #f5e0dc;

    * {
      font-family: "Hack", "Font Awesome 6 Free";
      font-size: 13px
    }

    window#waybar {
      background-color: @mantle;
      color: #ffffff;
      transition-property: background-color;
      transition-duration: .5s;
    }

    button { }

    window#waybar.empty #window {
      padding: 0px;
      margin: 0px;
      border: 0px;
      background-color: transparent;
    }

    pulseaudio#waybar.empty #window {
      padding: 0px;
      margin: 0px;
      border: 0px;
      background-color: transparent;
    }

    #workspaces button {
      color: #ffffff;
      border: 2px solid @mantle;
      border-bottom: 2px solid @mauve;
      margin-right: 5px;
      border-radius: 0px;
    }

    #workspaces button:hover {
      background: @mantle;
      background-color: @mantle;
      border-bottom: 2px solid @mauve;
      border-top: 2px solid @mauve;
      margin-right: 5px;
    }

    #workspaces button.visible {
      border-bottom: 2px solid @mauve;
      margin-right: 5px;
    }

    #workspaces button.active {
      border-bottom: 2px solid @teal;
      margin-right: 5px;
    }

    #workspaces button.active:hover {
      border-top: 2px solid @teal;
      margin-right: 5px;
    }

    #mode {
      background-color: @mantle;
    }

    #clock,
    #battery,
    #bluetooth,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #wireplumber,
    #custom-media,
    #tray,
    #mode,
    #idle_inhibitor,
    #scratchpad,
    #mpd,
    #mpris,
    #custom-updates,
    #window {
      color: #ffffff;
      border-bottom: 2px solid @mauve;
      padding-right: 10px;
      padding-left: 10px;
      margin-left: 5px;
    }

    #mpris {
      margin-left: 0px;
    }

    .modules-left {
      margin-left: 5px;
    }

    .modules-right {
      margin-right: 5px;
    }

    .modules-left > widget:first-child > #workspaces {
      margin-left: 0px;
      margin-right: 0px;
    }

    .modules-right > widget:last-child > #workspaces {
      margin-right: 0px;
    }

    @keyframes blink {
      to {
        background-color: #ffffff;
        color: #000000;
      }
    }

    #battery.critical:not(.charging) {
      color: #ffffff;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }
  '';
}
