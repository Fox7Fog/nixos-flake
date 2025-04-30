{ config, pkgs, inputs, ... }:

{
  # Import Hyprland's Home Manager module if needed for specific settings.
  imports = [ 
    inputs.hyprland.homeManagerModules.default
    ./modules/hyprland/config.nix
    ./modules/desktop-apps
  ];

  # Basic Home Manager settings.
  home.username = "fox7fog";
  home.homeDirectory = "/home/fox7fog";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  /*
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;   # link recursively
    executable = true;  # make all files executable
  };
  */

  #  encode the file content in nix configuration file directly
  /*
  home.file.".xxx".text = ''
      xxx
  '';
  */

  /* wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    recommendedEnvironment = false;
    config = {
    };
  };
  */

  # --- User Packages --- 
  # List of packages installed specifically for this user.
  home.packages = with pkgs; [
    # Browsers
    qutebrowser
    links2
    chromium
    
    # File manager
    yazi
    
    # System utilities
    # Laptop-specific utilities
    /*
    brightnessctl # Control screen brightness
    v4l-utils     # Video4Linux tools (webcams, etc.)
    */
    neofetch      # System info display
    thefuck       # Corrects previous console command errors

    # Archives
    zip
    xz
    unzip
    p7zip

    # Command-line Utilities
    ripgrep # Fast recursive grep
    jq      # JSON processor
    yq-go   # YAML processor
    fzf     # Fuzzy finder

    # Networking Tools
    mtr     # Network diagnostic tool
    iperf3
    dnsutils  # dig, nslookup
    ldns      # drill (alternative to dig)
    aria2     # Download utility
    socat     # netcat alternative
    nmap      # Network scanner
    ipcalc    # IP calculator

    # Miscellaneous
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    nix-output-monitor # Enhanced Nix command output

    # Productivity
    hugo # Static site generator
    glow # Markdown previewer

    # System Monitoring
    btop  # Resource monitor
    iotop # I/O monitor
    iftop # Network traffic monitor

    # System Call Monitoring
    strace # System call tracer
    ltrace # Library call tracer
    lsof   # List open files

    # System Tools
    sysstat
    lm_sensors # Hardware sensors
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # --- Program Configurations --- 

  # Git
  programs.git = {
    enable = true;
    userName = "Fox7Fog";
    userEmail = "fox7fog@protonmail.com";
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # Alacritty terminal emulator
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "jonathan";
      plugins = [
        "git"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
      ];
    };
    
    shellAliases = {
      # System management
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#F7F";
      update = "sudo nix flake update /etc/nixos";
      clean = "sudo nix-collect-garbage -d";
      
      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      
      # Directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      
      # List directory contents
      ll = "ls -lah";
      la = "ls -A";
      l = "ls -CF";
      
      # System monitoring
      ports = "sudo lsof -i -P -n | grep LISTEN";
      mem = "free -h";
      cpu = "top -o %CPU";
      
      # Quick edit for configuration
      conf = "cd /etc/nixos";
      hm = "$EDITOR /etc/nixos/home.nix";
    };
    
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      MANPAGER = "less -R --use-color -Dd+r -Du+b";
    };
    
    initExtra = ''
      # Set history size
      HISTSIZE=10000
      SAVEHIST=10000
      
      # Additional key bindings
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      
      # Custom functions
      mkcd() { mkdir -p "$@" && cd "$@"; }
      
      # Welcome message
      echo "Welcome back! Remember to check for updates with 'update'."
    '';
  };

  /*
  This value determines the home Manager release that your
  configuration is compatible with. This helps avoid breakage
  when a new home Manager release introduces backwards
  incompatible changes.
  
  You can update home Manager without changing this value. See
  the home Manager release notes for a list of state version
  changes in each release.
  */
  home.stateVersion = "24.11";

  # Allow Home Manager to manage itself.
  programs.home-manager.enable = true;
}
