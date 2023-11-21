{
  pkgs,
  ...
}:
{
  services.mako = {
    enable = true;
    font = "Hack Nerd Font 10";
    backgroundColor = "#232627aa";
    textColor = "#fcfcfc";
    borderColor = "#1abc9c";
    bordernSize = 4;
    defaultTimeout = 10000;
  };
}
