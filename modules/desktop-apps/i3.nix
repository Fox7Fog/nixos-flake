# i3 window manager configuration
{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "wofi --show drun";
      
      gaps = {
        inner = 5;
        outer = 2;
        smartGaps = true;
      };

      bars = [{
        position = "top";
        statusCommand = "i3status-rust ~/.config/i3status-rust/config-top.toml";
        fonts = {
          names = [ "JetBrainsMono Nerd Font" ];
          size = 11.0;
        };
        colors = {
          background = "#1E1E2E";
          statusline = "#CDD6F4";
          separator = "#45475A";
          focusedWorkspace = {
            border = "#89B4FA";
            background = "#1E1E2E";
            text = "#CDD6F4";
          };
          activeWorkspace = {
            border = "#45475A";
            background = "#1E1E2E";
            text = "#CDD6F4";
          };
          inactiveWorkspace = {
            border = "#45475A";
            background = "#1E1E2E";
            text = "#6C7086";
          };
          urgentWorkspace = {
            border = "#F38BA8";
            background = "#1E1E2E";
            text = "#CDD6F4";
          };
        };
      }];

      keybindings = let
        modifier = "Mod4";
      in {
        "${modifier}+Return" = "exec alacritty";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec wofi --show drun";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exit";
        
        # Focus
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        
        # Move
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        
        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        
        # Move to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        
        # Layout
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+space" = "floating toggle";

        # Laptop-specific bindings
        /*
        # Screen brightness controls
        "XF86MonBrightnessUp" = "exec brightnessctl s +10%";
        "XF86MonBrightnessDown" = "exec brightnessctl s 10%-";
        */
      };

      startup = [
        { command = "nm-applet"; notification = false; }
        { command = "blueman-applet"; notification = false; }
      ];
    };
  };
} 