{
  description = "Tverdyy NixOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins?ref=yazi-v0.2.5";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-yazi-plugins,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.tverdyy = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
