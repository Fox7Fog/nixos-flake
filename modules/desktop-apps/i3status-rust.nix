# i3status-rust configuration
{ config, lib, pkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = [
          {
            block = "cpu";
            interval = 1;
            format = " $icon $utilization ";
          }
          {
            block = "memory";
            format = " $icon $mem_used_percents ";
            format_alt = " $icon_swap $swap_used_percents ";
          }
          {
            block = "sound";
            step_width = 3;
          }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
          # Laptop-specific blocks
          /*
          {
            block = "battery";
            format = " $icon $percentage $time ";
            device = "BAT0";
          }
          */
          {
            block = "net";
            format = " $icon {$signal_strength $ssid $frequency|Wired} ";
            format_alt = " $icon {$signal_strength $ssid $frequency|Wired} $ip ";
          }
        ];
        theme = "modern";
        icons = "awesome6";
      };
    };
  };
} 