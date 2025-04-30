# NixOS Configuration

My personal NixOS system configuration using the Nix Flakes feature.

## System Overview

- **Window Managers**: i3 (X11) and Hyprland (Wayland)
- **Display Manager**: SDDM
- **Shell**: Zsh with Oh My Zsh
- **Terminal**: Alacritty
- **File Manager**: Yazi
- **Browsers**: qutebrowser, Chromium, Links2

## Structure

- `flake.nix` - Main flake configuration and input management
- `configuration.nix` - System-wide NixOS configuration
- `home.nix` - User-specific configuration via Home Manager
- `hardware-configuration.nix` - Hardware-specific settings

## Installation

1. Clone this repository to `/etc/nixos/`:
   ```bash
   sudo git clone https://github.com/your-username/nixos-flake.git /etc/nixos
   ```

2. Build and switch to the configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#F7F
   ```

## Features

- XFS root filesystem with FAT32 boot partition
- PipeWire audio setup
- Comprehensive font selection
- Security features enabled (firewall, polkit)
- Development tools and utilities
- System monitoring tools

## Notes

- System state version: 24.05
- Home Manager state version: 24.11
- Uses both stable (24.11) and unstable Nixpkgs
