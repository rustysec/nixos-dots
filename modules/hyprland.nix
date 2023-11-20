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
			"$mod, a, exec, foot"
			"SUPERSHIFT, q, exit"
		];

		misc = {
			disable_hyprland_logo = true;
			disable_splash_rendering = true;
		};

		decoration = {
			rounding=10;
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
