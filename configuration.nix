{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader. 
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    /*
    kernelParams = [
      # Framebuffer and memory settings
      "i915.stolenmem=64M" # Testing...
      "i915.gtt_size=2048" # Testing...
    ];
    initrd.kernelModules = [ "i915" ]; # Testing...
    kernelPackages = pkgs.linuxPackages_latest; # Testing...
    */
  };

  # Define network hostname.
  networking.hostName = "F7F";

  # Mount other partitions if needed.
  /*
  fileSystems."/home/fox7fog/.dotFiles" = { # The Directory to Mount the Partition.
    device = ""; # The Partition is Added Here, examples: "/dev/nvme1n1p1" or "nvme0n1p2" or "sda1".
    fsType = ""; # The File System Here, examples: "ntfs", "btrfs", "ext4".
    options = [ "rw" "uid=1000" "gid=100" "umask=0022" ]; # uid and gid can be checked by running the 'id' command
  };
  */

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure the Time Zone.
  time.timeZone = "America/Sao_Paulo";

  # Select Locale Properties.
  i18n.defaultLocale = "en_US.UTF-8";
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

  # Set fonts for TTY
  console = {
    earlySetup = true;
    font = "sun12x22";
    useXkbConfig = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
      xfce.noDesktop = true;
    };
    # Enable i3 Window Manager in X11
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        picom
        lxappearance
        i3status-rust
        arc-theme
        feh
      ];
    };
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager.lightdm.greeters.slick.enable = false;
  };

  # Enable SDDM display manager for Hyprland.
  services.displayManager.sddm.enable = true;

  # Enable Microcode Updates for Intel CPUs.
  hardware.cpu.intel.updateMicrocode = true;

  # Set the CPU Governor to Performance
  # powerManagement.cpuFreqGovernor = "performance";

  # Hardware Related Configuration.
  hardware = {
    # Graphics OpenGL Rendering.
    graphics = {
      enable = true;
    };
    # NVidia Graphics.
    /* nvidia = {
      modesetting.enable = true;
      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    }; */
    # Enable Bluetooth.
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    # Disable PulseAudio to use PipeWire.
    pulseaudio.enable = false;
  };

  # Security.
  security = {
    # Polkit is used for controlling system-wide privileges.
    polkit.enable = true;
    # Realtime Policy and Watchdog Daemon.
    rtkit.enable = true;
  };

  # Enable Sound with PipeWire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Nix Packages Configuration.
  nixpkgs.config = {
    allowUnfree = true; # Enable Unfree Packages Support.
  };

  # User Account Configuration.
  users.users.fox7fog = {
    isNormalUser = true;
    description = "F7F";
    extraGroups = [ "networkmanager" "wheel" ];
    # shell = pkgs.zsh;
    # openssh.authorizedKeys.keys [ "" ];
    # 
  };

  # List Environment System Wide Packages.
  environment.systemPackages = with pkgs; [
    # Web Browsers.
    firefox-esr
    qutebrowser
    w3m
    links2
    lynx
    chromium
    microsoft-edge
    # System Tools.
    brightnessctl
    v4l-utils
    wget
    git
    alsa-utils
    # Terminal File Managers.
    ranger
    yazi
    # Terminal Emulators.
    alacritty
    # ZSH Packages
    thefuck
    oh-my-zsh
  ];

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

  # System Shell Packages.
  environment.shells = with pkgs; [
    zsh
  ];
  
  programs = {
    # My Traceroute (MTR)
    mtr.enable = true;
    # GNU Privacy Guard (GnuPG)
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    # Sway
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland.enable = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
	      theme = "jonathan";
	      plugins = [
          "git"
	        # "zsh-autosuggestions"
	        # "zsh-syntax-highlighting"
	      ];
      };
    };
  };

  # Environment variables for Wayland
  /* environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  }; */

  # Enable Nix Extra Features.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon
    openssh.enable = true;
    picom = {
      enable = true;
      settings = {
        inactive-opacity = 1;
        active-opacity = 1;
        inactive-opacity-override = true;
        blur-backgroun = true;
        blur-strenght = 1;
        opacity-rule = [];
      };
    };
    # dbus.enable = true;
    seatd.enable = true;
    # Ollama
    ollama.enable = true;
    # Mullvad VPN
    #  mullvad-vpn.enable = true;
  };

  # NixOS Release for This Configuration.
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on the system were taken.
  system.stateVersion = "24.05";
}
