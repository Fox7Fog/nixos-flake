{
  description = "NixOS configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    username = "fox7fog";
    system = "x86_64-linux";
    
    pkgs = import nixpkgs nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
	        unstable = import nixpkgs-unstable {
	          inherit system;
	          config.allowUnfree = true;
          };
	      })
      ];
    };
  in {
    nixosConfigurations.F7F = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs username; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
	          useGlobalPkgs = true;
            useUserPackages = true;
	          extraSpecialArgs = { inherit inputs; };
            users.${username} = import ./home.nix;
	        };  
        }
      ];
    };
  };
}
