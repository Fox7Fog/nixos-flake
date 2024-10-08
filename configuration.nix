{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define network hostname.
  networking.hostName = "F7F";

  # Mount other partitions if needed.
  #fileSystems."/home/fox7fog/.dotFiles" = { # The Directory to Mount the Partition.
  #  device = ""; # The Partition is Added Here, examples: "/dev/nvme1n1p1" or "nvme0n1p2" or "sda1".
  #  fsType = ""; # The File System Here, examples: "ntfs", "btrfs", "ext4".
  #  options = [ "rw" "uid=1000" "gid=100" "umask=0022" ]; # uid and gid can be checked by running the 'id' command
  #};

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
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Enable the X11 Windowing System
  services.xserver = {
    # Enable X11.
    enable = true;
    # Configure keymap in X11.
    xkb.layout = "us";
    xkb.variant = "altgr-intl";
    # Enable X11 Nvidia Drivers.
    videoDrivers = [ "nvidia" ];
    # Enable LightDM.
    #displayManager = {
    #  lightdm.enable = true;
    #};
    # Enable i3 Window Manager.
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
          i3status
          i3status-rust
          dmenu
          dunst
          feh
          xfce.thunar
          xfce.thunar-volman
          xfce.thunar-bare
          xfce.thunar-dropbox-plugin
          xfce.thunar-archive-plugin
          xfce.thunar-media-tags-plugin
          lxappearance
          volumeicon
          arc-theme
          cosmic-icons
      ];
    };
  };

  # Enable SDDM display manager for Hyprland.
  services.displayManager.sddm.enable = true;

  # Enable Hyprland.
  programs.hyprland.enable = true;

  # Enable Microcode Updates for Intel CPUs.
  hardware.cpu.intel.updateMicrocode = true;

  # Set the CPU Governor to Performance
  powerManagement.cpuFreqGovernor = "performance";

  # Hardware Related Configuration.
  hardware = {
    # Graphics OpenGL Rendering.
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    # NVidia Graphics.
    nvidia = {
      modesetting.enable = true;
      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
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
  sound.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Nix Packages Configuration.
  nixpkgs.config = {
    allowUnfree = true; # Enable Unfree Packages Support.
    cudaSupport = true; # Enable NVidia Cuda Support.
  };

  # User Account Configuration.
  users.users.fox7fog = {
    isNormalUser = true;
    description = "F7F";
    extraGroups = [ "networkmanager" "whell" ];
    packages = with pkgs; [];
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

  # System Shell Packages.
  environment.shells = with pkgs; [
    zsh
  ];

  # Enable Nix Extra Features.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # NixOS Release for This Configuration.
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on the system were taken.
  system.stateVersion = "24.05";
}
