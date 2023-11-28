{ pkgs
, ...
}:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_status_modules "application date_time session"
          set -g @catppuccin_date_time_text "%a %b %d, %Y %H:%M:%S"
        '';
      }
    ];

    extraConfig = ''
      set -s escape-time 0

      bind | split-window -h
      bind ? split-window -v

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      bind -n M-a previous-window
      bind -n M-d next-window
      bind -n M-s next-window
      bind -n M-n next-window

      bind -T root F12  \
        set prefix None \;\
        set key-table off \;\
        if -F '#{pane_in_mode}' 'send-keys -X cancel' \;\
        refresh-client -S \;\

      bind -T off F12 \
        set -u prefix \;\
        set -u key-table \;\
        set -u status-style \;\
        set -u window-status-current-style \;\
        set -u window-status-current-format \;\
        refresh-client -S
    '';
  };
}
