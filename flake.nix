{
  description = "Flake for HomeAssistant on RPI5";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };
  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };
  outputs =
    { self, nixpkgs, nixos-raspberrypi, ... }@inputs:
    {
      nixosConfigurations = {
        homeassistant = nixos-raspberrypi.lib.nixosSystemFull {
          specialArgs = inputs;
          modules = [
            ./hosts/homeassistant/configuration.nix
          ];
        };
      };
    };
}
