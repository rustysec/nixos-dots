{
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
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

      bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

      set-option -g status-interval 1
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'

      # Status bar colors.
      set-window-option -g status-style fg=default,bg=default

      # Window list colors.
      set-window-option -g window-status-style fg=black,bg=blue,none
      set-window-option -g window-status-current-style fg=black,bold,bg=lightgreen
      set-window-option -g window-status-activity-style fg=white,bg=darkcyan,none

      # Pane divider colors.
      set-option -g pane-border-style fg=yellow,bg=default
      set-option -g pane-active-border-style fg=red,bold,bg=default,bright

      # Set left and right sections.
      set-option -g status-left-length 20
      set-option -g status-right-length 60
      set-option -g status-left "#[fg=black,bg=lightgreen]"
      set-option -g status-right "#[fg=black,bg=lightgreen] Session: #S | #(whoami)@#H | %a %b %d, %Y // %H:%M:%S"

      # Set format of items in window list.
      setw -g window-status-format " #I:#W#F "
      setw -g window-status-current-format " #I:#W#F "

      # Set alignment of windows list.
      set-option -g status-justify left

      # Identify activity in non-current windows.
      set-window-option -g monitor-activity on
      set-option -g visual-activity off

      # Undercurl
      # set -g default-terminal "$\{TERM}"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
    '';
  };
}
