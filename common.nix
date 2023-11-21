{
  inputs,
  pkgs,
  nixvim,
  ...
}:
let
	wallpaper = pkgs.fetchurl {
		url = "https://raw.githubusercontent.com/nixos/nixos-artwork/master/wallpapers/nix-wallpaper-stripes-logo.png";
		sha256 = "d4ca0fc32b70f24062cbe4b1ef4c661e7c4c260a8468e47d60481030ee9b1233";
	};
in
{

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
    };

    openssh = {
      enable = true;
    };

    greetd = {
      enable = true;
      settings = {
        default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
        initial_session = {
          user = "russ";
          command = "Hyprland";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
  };

  security = {
    rtkit.enable = true;
    pam.services.swaylock = {};
    sudo.configFile = ''
Defaults pwfeedback
    '';
  };

  users.users.russ = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Russ Morris";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    greetd.wlgreet
    neovim
    tmux
    wget
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.zsh.enable = true;
  programs.virt-manager.enable = true;
  programs.dconf.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  fonts.packages = with pkgs; [
    font-awesome
    hack-font
    nerdfonts
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.users.russ = { pkgs, ... }: 
  {
    home.stateVersion = "23.05";

    programs.git = {
      enable = true;
      userName = "rustysec";
      userEmail = "russ@infocyte.com";
    };

    dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
    };

    home.packages = with pkgs; [
      clang
      foot
      go
      gopls
      grim
      pamixer
      playerctl
      ripgrep
      rustup
      slurp
      swaybg
      swayidle
      swaylock
      typescript
      virt-manager
      wl-clipboard
    ];

    imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ./modules/foot.nix
      ./modules/hyprland.nix
      ./modules/mako.nix
      ./modules/nvim/default.nix
      ./modules/tmux.nix
      ./modules/waybar.nix
      ./modules/wofi.nix
      ./modules/zsh.nix
    ];

    home.file.".config/locker/menu.sh".text = ''
#!/bin/bash

OPT=$(cat ~/.config/locker/options | wofi --insensitive --dmenu)

case $OPT in
    "Shutdown")
        systemctl poweroff
        ;;
    "Restart")
        systemctl reboot
        ;;
    "Logout")
        hyprctl dispatch exit 0
        ;;
    "Lock")
        /usr/bin/bash ~/.config/locker/locker.sh
        ;;
    *)
        echo "Doing Nothing!"
        ;;
esac
    '';

    home.file.".config/locker/locker.sh".text = ''
#!/bin/bash

swaylock --image ${wallpaper} -f -c 282c34 \
	--inside-color 282c34 \
	--inside-wrong-color ed1515 \
	--ring-wrong-color ed1515 \
	--inside-ver-color f67400 \
	--ring-ver-color f67400 \
	--ring-color 1d99f3 \
	--ring-clear-color 1b668f \
	--line-clear-color 1b668f \
	--inside-clear-color 16a085 \
	--key-hl-color 3daee9 \
	--bs-hl-color b65619
    '';

    home.file.".config/locker/options".text = ''
Lock
Logout
Restart
Shutdown
    '';
  };
}
