{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles.russ = {
      bookmarks = { };
      extensions = [ ];
      settings = {
        "browser.download.panel.shown" = true;
        "browser.download.autoHideButton" = false;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.homepage" = "about:home";
        "browser.tabs.inTitlebar" = 0;
        "media.eme.enabled" = true;
        "signon.rememberSignon" = false;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
