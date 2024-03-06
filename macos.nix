{ pkgs, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  home.username = "russ";
  home.homeDirectory = "/Users/russ";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    clang
    go
    gopls
    jq
    libclang
    lua-language-server
    marksman
    nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    nil
    ripgrep
    rustup
    typescript
    zola
  ];

  home.file = {

    ".zsh/catppuccin" = {
      source = builtins.fetchGit {
        url = "https://github.com/catppuccin/zsh-syntax-highlighting.git";
        rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  imports = [
    nixvim.homeManagerModules.nixvim
    ./modules/gh.nix
    ./modules/nvim/default.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
  ];

  programs.home-manager.enable = true;
}
