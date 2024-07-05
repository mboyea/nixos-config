{
  description = "nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  # outputs = { nixpkgs, home-manager, ... } @ inputs:
  outputs = { nixpkgs, ... } @ inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      maybenixpc = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          inputs.disko.nixosModules.default
          (import ./disko.nix { device = "/dev/nvme0n1"; })
          inputs.impermanence.nixosModules.impermanence
        ];
      };
    };
    # homeConfigurations = {
    #   admin = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     modules = [ ./admin/home-manager/home.nix ];
    #   };
    # };
  };
}
