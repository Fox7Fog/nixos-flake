# Desktop environment and window manager configurations
{ config, pkgs, ... }:

{
  imports = [
    ./desktop-apps/waybar.nix
    ./desktop-apps/wofi.nix
  ];

  # --- Graphics and Display --- 
  # Enable the X.Org server (needed for i3).
  services.xserver = {
    enable = true;
    # Enable the i3 tiling window manager.
    windowManager.i3 = {
      enable = true;
      # Additional packages useful for the i3 environment.
      extraPackages = with pkgs; [
        dmenu # Application launcher
        i3status # Basic status bar
        picom # Compositor for effects (transparency, etc.)
        lxappearance # GTK theme switcher
        i3status-rust # More advanced status bar
        arc-theme # GTK theme
        feh # Wallpaper setter
      ];
    };
    # Basic X11 keyboard layout.
    xkb = {
      layout = "us";
      variant = "";
    };
    # Disable the default LightDM GTK greeter if using SDDM.
    displayManager.lightdm.greeters.slick.enable = false;
  };

  # Enable the SDDM display manager (login screen), often used with Wayland.
  services.displayManager.sddm.enable = true;

  # Enable Picom compositor (for i3 primarily).
  services.picom = {
    enable = true;
    # Basic Picom settings (adjust as needed).
    settings = {
      inactive-opacity = 1;
      active-opacity = 1;
      inactive-opacity-override = true;
      blur-background = true;
      blur-strength = 1;
      opacity-rule = [];
    };
  };

  # Required for Wayland compositors like Hyprland.
  services.seatd.enable = true;

  # Enable Hyprland Wayland compositor.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # For running X11 apps in Wayland.
  };

  # --- Fonts --- 
  # Install a selection of fonts for system use.
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerdfonts
    font-awesome
    ubuntu_font_family
    jetbrains-mono
    terminus_font
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Install required packages for the desktop environment
  environment.systemPackages = with pkgs; [
    # Wayland essentials
    waybar
    wofi
    wl-clipboard
    grim
    slurp
    swappy
    wf-recorder
    hyprpaper
    pavucontrol
    networkmanagerapplet
    blueman
  ];
} 