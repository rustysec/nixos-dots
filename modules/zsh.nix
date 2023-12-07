{ ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      theme = "flazz";
      extraConfig = ''
        source ~/.zsh/catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
        export NIX_STORE=/nix/store
        alias ztheme='(){ export ZSH_THEME="$@" && source $ZSH/oh-my-zsh.sh }'
      '';
    };
  };
}
