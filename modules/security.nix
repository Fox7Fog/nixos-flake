# Security-related configurations
{ config, lib, pkgs, ... }:

{
  # --- Security Settings --- 
  security = {
    # Polkit for managing privileges (e.g., mounting drives).
    polkit.enable = true;
    # RealtimeKit for low-latency audio/scheduling.
    rtkit.enable = true;
  };

  # --- Firewall Configuration ---
  networking.firewall = {
    enable = true;
    # Common ports for services
    allowedTCPPorts = [ 
      22    # SSH
      # Add more ports as needed
    ];
    allowedUDPPorts = [
      # Add UDP ports as needed
    ];
    # Example of port ranges
    # allowedTCPPortRanges = [
    #   { from = 4000; to = 4007; }
    # ];
  };

  # --- SSH Configuration ---
  services.openssh = {
    enable = true;
    # Harden SSH configuration
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  # --- System Hardening ---
  # Kernel hardening
  boot.kernel.sysctl = {
    # Protect against buffer overflows
    "kernel.kptr_restrict" = 2;
    # Restrict dmesg access
    "kernel.dmesg_restrict" = 1;
    # Restrict SysRq
    "kernel.sysrq" = 0;
    # Protect against time-wait assassination
    "net.ipv4.tcp_rfc1337" = 1;
  };
} 