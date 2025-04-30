{ config, lib, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./i3.nix
    ./i3status-rust.nix
  ];
} 