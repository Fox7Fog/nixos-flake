# Hyprland configuration
{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      # Monitor Configuration
      monitor = [
        "eDP-1,highrr,auto,1"
      ];

      # Program Variables
      "$terminal" = "alacritty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun --conf ~/.config/hypr/wofi/config --style ~/.config/hypr/wofi/style.css";

      # Autostart Programs
      exec-once = [
        "waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css"
        "nm-applet"
        "blueman-applet"
        "hyprpaper"
      ];

      # Environment Variables
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_QPA_PLATFORM,wayland"
        "GDK_SCALE,1"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      # Cursor Configuration
      cursor = {
        no_hardware_cursors = true;
      };

      # General Settings
      general = {
        gaps_in = 1;
        gaps_out = 2;
        border_size = 2;
        "col.active_border" = "rgba(00ff99aa) rgba(00ff99aa) 45deg";
        "col.inactive_border" = "rgba(363944aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration Settings
      decoration = {
        rounding = 4;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
      };

      # Animation Settings
      animations = {
        enabled = true;
        bezier = "myBezier, 0.01, 1, 0.1, 1";
        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, myBezier, popin 80%"
          "border, 1, 7, myBezier"
          "borderangle, 1, 6, myBezier"
          "fade, 1, 5, myBezier"
          "workspaces, 1, 2, myBezier"
        ];
      };

      # Layout Settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # Misc Settings
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = false;
        vfr = true;
      };

      # Input Configuration
      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      # Gesture Configuration
      gestures = {
        workspace_swipe = false;
      };

      # Device-specific Configuration
      device = {
        name = "epic-mouse-v1";
        sensitivity = "-0.3";
      };

      # Key Bindings
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod SHIFT, Q, killactive"
        "$mainMod SHIFT, E, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, F, fullscreen"
        "$mainMod, K, exec, killall waybar"
        "$mainMod, B, exec, waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css"

        # Screenshot bindings
        "$mainMod SHIFT, S, exec, ~/.dotFiles/wayland-setup/bashScripts/hyprland-screenshot.sh --select"
        "$mainMod SHIFT, F, exec, ~/.dotFiles/wayland-setup/bashScripts/hyprland-screenshot.sh --full"
        "$mainMod SHIFT, W, exec, ~/.dotFiles/wayland-setup/bashScripts/hyprland-screenshot.sh --window"

        # Focus movement
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Workspace switching
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move windows to workspaces
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Moving windows within workspace
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Window swapping
        "$mainMod SHIFT, left, swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up, swapwindow, u"
        "$mainMod SHIFT, down, swapwindow, d"

        # Window resizing
        "$mainMod ALT, right, resizeactive, 10 0"
        "$mainMod ALT, left, resizeactive, -10 0"
        "$mainMod ALT, up, resizeactive, 0 -10"
        "$mainMod ALT, down, resizeactive, 0 10"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Media key bindings
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Media control bindings
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Window rules
      windowrule = [
        "opacity 0.3 override 0.3 override,title:(.*)(- Youtube)$"
      ];

      # Window rules v2
      windowrulev2 = [
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "float,class:^(zen-alpha)$,title:^(Picture-in-Picture)$"
        "float,class:^(org.gnome.Calculator)$,title:^(Calculator)$"
        "float,class:^(org.kde.kcalc)$,title:^(KCalc)$"
        "suppressevent maximize, class:.*"
      ];
    };
  };
} 