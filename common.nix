{ inputs
, pkgs
, ...
}:
let
  # wallpaper_stripes = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/nixos/nixos-artwork/master/wallpapers/nix-wallpaper-stripes-logo.png";
  #   sha256 = "d4ca0fc32b70f24062cbe4b1ef4c661e7c4c260a8468e47d60481030ee9b1233";
  # };
  wallpaper_lock = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-nineish-dark-gray.png";
    hash = "sha256-nhIUtCy/Hb8UbuxXeL3l3FMausjQrnjTVi1B3GkL9B8=";
  };
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/m9/wallhaven-m9lxe9.jpg";
    hash = "sha256-d1vJ+RuCHNBu0keOA9ACQne0yzZ28C8rWpLl0a0Drkg=";
  };
in
{
  system.stateVersion = "23.11";

  networking = {
    networkmanager.enable = true;
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  nixpkgs.config.allowUnfree = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = 1024 * 8;
    }
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "quiet" ];
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    initrd.systemd.enable = true;
  };

  hardware = {
    enableAllFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
    };

    openssh = {
      enable = true;
    };

    fstrim.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd /etc/greetd/hyprland.sh";
        initial_session = {
          user = "russ";
          command = "/etc/greetd/hyprland.sh";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    blueman.enable = true;
    thermald.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = { };
    sudo.configFile = ''
      Defaults pwfeedback
    '';
  };

  users.users.russ = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Russ Morris";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" ];
    packages = [ ];
  };

  environment.systemPackages = with pkgs; [
    bash-completion
    blueman
    file
    git
    glib
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    greetd.wlgreet
    kanshi
    mate.mate-polkit
    neovim
    networkmanagerapplet
    nil
    nixpkgs-fmt
    pavucontrol
    psmisc
    tmux
    unzip
    wget
    xdg-desktop-portal-hyprland
    zip
  ];

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    bash.blesh.enable = true;
    dconf.enable = true;
    light.enable = true;
    ssh.startAgent = true;
    virt-manager.enable = true;
    zsh.enable = true;
  };


  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            # pkgs.OVMFFull.fd

            (pkgs.OVMFFull.override
              {
                secureBoot = true;
                tpmSupport = true;
              }).fd
          ];
        };
      };
    };

    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  fonts.packages = with pkgs; [
    font-awesome
    hack-font
    nerdfonts
    roboto
  ];

  systemd = {
    user.services.polkit-mate-authentication-agent-1 = {
      after = [ "graphical-session.target" ];
      description = "polkit-mate-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = "${pkgs.qemu_kvm}/share/qemu/edk2-x86_64-secure-code.fd";
    };

    "ovmf/edk2-i386-vars.fd" = {
      source = "${pkgs.qemu_kvm}/share/qemu/edk2-i386-vars.fd";
    };

    "greetd/hyprland.sh" = {
      text = ''#!/usr/bin/env bash
Hyprland
'';
      mode = "0555";
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      keep-derivations = false;
    };
    optimise.automatic = true;
  };

  imports = [
    ./samba.nix
  ];

  home-manager.users.russ = { pkgs, ... }:
    {
      home.stateVersion = "23.11";

      nixpkgs.config.allowUnfree = true;

      services.blueman-applet.enable = true;
      services.network-manager-applet.enable = true;

      programs.git = {
        enable = true;
        userName = "rustysec";
        userEmail = "russ@infocyte.com";
      };

      home.sessionPath = [
        "$HOME/.cargo/bin"
      ];

      home.file.".ssh/config".text = ''
        AddKeysToAgent yes
      '';

      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };

      home.pointerCursor = {
        name = "Catppuccin-Mocha-Dark-Cursors";
        size = 24;
        package = pkgs.catppuccin-cursors.mochaDark;
      };

      gtk = {
        enable = true;
        font = {
          name = "Roboto";
          package = pkgs.roboto;
        };
        iconTheme = {
          name = "Papirus";
          package = pkgs.papirus-icon-theme;
        };
        theme = {
          name = "Catppuccin-Mocha-Standard-Blue-Dark";
          package = pkgs.catppuccin-gtk.override {
            accents = [ "blue" ];
            size = "standard";
            tweaks = [ ];
            variant = "mocha";
          };
        };
        cursorTheme = {
          name = "Catppuccin-Mocha-Dark-Cursors";
          size = 24;
          package = pkgs.catppuccin-cursors.frappeDark;
        };
        gtk3.extraConfig = {
          Settings = ''
            gtk-application-prefer-dark-theme=1
          '';
        };
        gtk4.extraConfig = {
          Settings = ''
            gtk-application-prefer-dark-theme=1
          '';
        };
      };

      home.packages = with pkgs; [
        catppuccin-cursors.mochaDark
        catppuccin-gtk
        clang
        firefox
        foot
        go
        google-chrome
        gopls
        grim
        jq
        libclang
        libnotify
        marksman
        nodejs
        nodePackages.typescript
        nodePackages.typescript-language-server
        osslsigncode
        pamixer
        papirus-icon-theme
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
        zola
      ];

      imports = [
        inputs.nixvim.homeManagerModules.nixvim
        ./modules/firefox.nix
        ./modules/foot.nix
        ./modules/fuzzel.nix
        (import ./modules/hyprland.nix {
          inherit wallpaper;
        })
        ./modules/bash.nix
        ./modules/kanshi.nix
        ./modules/mako.nix
        ./modules/nvim/default.nix
        (import ./modules/swaylock.nix
          {
            inherit wallpaper_lock;
          })
        ./modules/tmux.nix
        ./modules/waybar.nix
        ./modules/wofi.nix
        ./modules/zsh.nix
      ];

      home.file.".config/locker/menu.sh".text = ''
        OPT=$(cat ~/.config/locker/options | fuzzel -d -l 5)

        case $OPT in
          "⏻ Shutdown")
            systemctl poweroff
            ;;
          " Restart")
            systemctl reboot
            ;;
          "󰩈 Logout")
            hyprctl dispatch exit 0
            ;;
          " Lock")
            swaylock
            ;;
          *)
            echo "Doing Nothing!"
            ;;
        esac
      '';

      home.file.".config/locker/options".text = ''
         Lock
        󰩈 Logout
         Restart
        ⏻ Shutdown
      '';

      home.file.".zsh/catppuccin" = {
        source = builtins.fetchGit {
          url = "https://github.com/catppuccin/zsh-syntax-highlighting.git";
          rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
        };
      };
    };
}
