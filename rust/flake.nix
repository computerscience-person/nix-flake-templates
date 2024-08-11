{
  description = "The base nix flake.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, ... }@inputs: let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    eachSystem = nixpkgs.lib.genAttrs systems;
    withPkgs = system: nixpkgs.legacyPackages.${system};
    withFenix = system: inputs.fenix.packages.${system};
  in {
    devShells = eachSystem (system: let
      pkgs = withPkgs system;
      fenix = withFenix system;
    in { 
      default = pkgs.mkShell.override { 
        stdenv = pkgs.stdenvAdapters.useMoldLinker pkgs.stdenv;
      } {
        packages = [
          fenix.complete.toolchain
        ];
      };
    });
  };
}
