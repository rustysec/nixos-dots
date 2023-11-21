{
  pkgs,
  ...
}:
let
	wallpaper = pkgs.fetchurl {
		url = "https://raw.githubusercontent.com/nixos/nixos-artwork/master/wallpapers/nix-wallpaper-stripes-logo.png";
		sha256 = "d4ca0fc32b70f24062cbe4b1ef4c661e7c4c260a8468e47d60481030ee9b1233";
	};
in {
	wayland.windowManager.hyprland.enable = true;
	wayland.windowManager.hyprland.settings = {
		"$mod" = "SUPER";

		bind = [
			"$mod,        a,      exec, foot"
			"$mod,        RETURN, exec, foot -e tmux new"
            "$mod,        SPACE,  exec, wofi"
			"SUPERSHIFT,  q,      exit"
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

            "$mod,        P,          exec,grim -g \"$(slurp)\" - | wl-copy"
            ",XF86AudioRaiseVolume,   exec,pamixer -ui 2 && dc -e \"[`pamixer --get-volume`]sM 100d `pamixer --get-volume`<Mp\""
            ",XF86AudioLowerVolume,   exec,pamixer -ud 2 && dc -e \"[`pamixer --get-volume`]sM 100d `pamixer --get-volume`<Mp\""
            ",XF86AudioMute,          exec,pamixer --toggle-mute && ( pamixer --get-mute && echo 0 )"
            ",XF86AudioMicMute,       exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle"
            ",XF86MonBrightnessDown,  exec,bash ~/.config/sway/helpers/brightness.sh down"
            ",XF86MonBrightnessUp,    exec,bash ~/.config/sway/helpers/brightness.sh up"
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
			rounding=0;
		};

		general = {
          gaps_in = 5;
          gaps_out = 10;
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

		exec = [
			"swaybg -m fill --image ${wallpaper}"
		];
	};

	wayland.windowManager.hyprland.extraConfig = ''
	general {
		col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
		col.inactive_border = rgba(595959aa)
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
	'';
}
