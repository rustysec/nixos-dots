{ pkgs
, ...
}:
let
  bash_git = pkgs.fetchFromGitHub {
    owner = "magicmonty";
    repo = "bash-git-prompt";
    rev = "33b8b78d369d8115b3ab5e95c710748e5b43d6d6";
    hash = "sha256-UkZM1P2+u0CTncpmi+5wMBkrbOojOtyBmb135B3vBww=";
  };
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      source ${bash_git}/gitprompt.sh
    '';
  };
}
