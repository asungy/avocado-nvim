{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        avocado = (import inputs.nixpkgs {inherit system;}).vimUtils.buildVimPlugin {
          name = "avocado";
          src = ./.;
        };

        nvim-overlay = final: prev: {
          dev-nvim = inputs.nixvim.legacyPackages.${system}.makeNixvim {
            extraPlugins = [avocado];
          };
        };

        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [nvim-overlay];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            dev-nvim
          ];
        };
      }
    );
}
