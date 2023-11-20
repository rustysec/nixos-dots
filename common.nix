{
  inputs,
  pkgs,
  nixvim,
  ...
}:
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
  };

  users.users.russ = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Russ Morris";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    greetd.wlgreet
    neovim
    tmux
    wget
    git
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.dconf.enable = true;
  programs.zsh.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  fonts.packages = with pkgs; [
    font-awesome
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

    home.packages = with pkgs; [
      clang
      foot
      swaybg
      ripgrep
      rustup
      virt-manager
    ];

    imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ./modules/hyprland.nix
      ./modules/foot.nix
      ./modules/zsh.nix
      ./modules/nvim/default.nix
      ./modules/waybar.nix
    ];
  };
}
