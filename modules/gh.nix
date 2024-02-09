{ pkgs
, ...
}: {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
    extensions = [
      pkgs.gh-dash
    ];
  };

  programs.gh-dash.enable = true;
}
