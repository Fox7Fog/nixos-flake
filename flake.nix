{
  description = "My NixOS System Flake";
  
  # These are the building blocks from external sources.
  inputs = {
    # Base Nix packages collection for the stable NixOS version.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # Unstable channel for potentially newer packages.
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Manages user-specific configurations (dotfiles, packages).
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs"; # Ensures HM uses the same stable nixpkgs.
    };
    
    # The Hyprland Wayland compositor source.
    hyprland.url = "github:hyprwm/Hyprland";
    # Additional plugins for Hyprland.
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "nixpkgs-unstable"; # Plugins often need newer libraries.
    };
  };
  
  # This defines what the flake actually builds.
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    # Define reusable values.
    username = "fox7fog";
    system = "x86_64-linux"; # Target architecture.
    
    # Create the primary package set from the stable channel.
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true; # Allow installing non-FOSS packages.
      # Overlays allow customizing the package set.
      overlays = [
        # This overlay adds packages from the unstable channel under `pkgs.unstable`.
        (final: prev: {
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];
    };
  in {
    # Define the main NixOS system configuration.
    nixosConfigurations.F7F = nixpkgs.lib.nixosSystem {
      inherit system;
      # Pass flake inputs and username down to the modules.
      specialArgs = { inherit inputs username; };
      # List of configuration files to include.
      modules = [
        # Main system configuration.
        ./configuration.nix
        # Home Manager module for NixOS integration.
        home-manager.nixosModules.home-manager
        # Inline module to configure Home Manager itself.
        {
          home-manager = {
            useGlobalPkgs = true; # Use system's nixpkgs for HM packages.
            useUserPackages = true; # Install HM packages to user profile.
            extraSpecialArgs = { inherit inputs; }; # Pass inputs to home.nix.
            # Import the user-specific configuration.
            users.${username} = import ./home.nix;
          };
        }
      ];
    };
  };
}
