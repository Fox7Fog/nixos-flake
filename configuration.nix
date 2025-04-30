{ config, pkgs, ... }:

{
  imports = [
    # Hardware-specific settings
    ./hardware-configuration.nix
    # Our modular configurations
    ./modules/desktop.nix
    ./modules/security.nix
    ./modules/hardware.nix
  ];

  # --- Bootloader Configuration --- 
  boot = {
    loader = {
      # Using systemd-boot for EFI systems.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true; # Needed for boot entry management.
    };
  };

  # --- Networking --- 
  # Sets the hostname for the machine.
  networking.hostName = "F7F";
  # Use NetworkManager for managing network connections (WiFi, Ethernet).
  networking.networkmanager.enable = true;
  # Explicitly enable the system firewall.
  networking.firewall.enable = true;

  # --- Localization --- 
  # Set the system time zone.
  time.timeZone = "America/Sao_Paulo";
  # Default language and formats.
  i18n.defaultLocale = "en_US.UTF-8";
  # Finer-grained settings for specific locale categories.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # --- Console Setup --- 
  # Settings for the virtual console (TTY).
  console = {
    earlySetup = true;
    font = "sun12x22"; # A readable font for the TTY.
    useXkbConfig = true; # Use X11 keymap settings in TTY.
  };

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
  # Enable Hyprland Wayland compositor.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # For running X11 apps in Wayland.
  };

  # --- Hardware Settings --- 
  # Apply CPU microcode updates.
  hardware.cpu.intel.updateMicrocode = true;
  # Set the CPU Governor to Performance (Commented out - consider power usage)
  # powerManagement.cpuFreqGovernor = "performance";
  hardware = {
    # Enable OpenGL support.
    graphics = {
      enable = true;
    };
    # Enable Bluetooth support.
    bluetooth = {
      enable = true;
      powerOnBoot = true; # Turn on Bluetooth automatically.
    };
    # Use PipeWire for audio, so disable PulseAudio.
    pulseaudio.enable = false;
    
    # Laptop-specific hardware settings
    /*
    acpilight.enable = true;  # Backlight control
    power-management = {
      enable = true;
      powertop.enable = true;
    };
    */
  };

  # --- Security Settings --- 
  security = {
    # Polkit for managing privileges (e.g., mounting drives).
    polkit.enable = true;
    # RealtimeKit for low-latency audio/scheduling.
    rtkit.enable = true;
  };

  # --- Audio Setup --- 
  # Enable PipeWire for managing audio streams.
  services.pipewire = {
    enable = true;
    alsa.enable = true; # ALSA compatibility.
    alsa.support32Bit = true; # For 32-bit ALSA apps.
    pulse.enable = true; # PulseAudio compatibility layer.
    jack.enable = true; # JACK compatibility.
    wireplumber.enable = true; # Session manager for PipeWire.
  };

  # --- Nix Configuration --- 
  # Allow installation of packages with non-free licenses.
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Enable experimental Nix features like flakes and the new CLI.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # --- User Account --- 
  users.users.fox7fog = {
    isNormalUser = true;
    description = "F7F";
    # Add user to groups needed for system access (networking, admin).
    extraGroups = [ "networkmanager" "wheel" ];
    # Set the default shell for this user (managed by Home Manager too).
    shell = pkgs.zsh;
    # Example for SSH keys:
    # openssh.authorizedKeys.keys = [ "ssh-rsa AAA... user@host" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrjJv42A3N720HbDWzUTKwL7ZbMua0mS60IFabYbQ1j fox7fog@protonmail.com" ];
  };

  # --- System-Wide Packages --- 
  # Minimal set of essential command-line tools.
  # Most user applications are installed via Home Manager.
  environment = {
    systemPackages = with pkgs; [
      wget
      git
      alsa-utils # Audio utilities (alsamixer, etc.)
    ];
    shells = with pkgs; [ zsh ];
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
  ];

  # --- System Programs --- 
  # Utilities enabled system-wide.
  programs = {
    # Enable My Traceroute network diagnostic tool.
    mtr.enable = true;
    # Enable GnuPG agent for managing PGP keys (and SSH keys).
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    # Hyprland is configured above in Graphics section.
  };

  # --- System Services --- 
  services = {
    # Enable the SSH daemon for remote access.
    openssh.enable = true;
    # Enable Picom compositor (for i3 primarily).
    picom = {
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
    seatd.enable = true;
    # Ollama AI service (disabled - run manually when needed).
    # ollama.enable = true;
    # Mullvad VPN service (disabled).
    # mullvad-vpn.enable = true;
  };

  # --- System State --- 
  # Pins the system state version to avoid unexpected breakages.
  system.stateVersion = "24.05";
}
