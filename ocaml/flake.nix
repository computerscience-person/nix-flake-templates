{
  description = "The base nix flake.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { nixpkgs, ... }@inputs: let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    eachSystem = nixpkgs.lib.genAttrs systems;
    withPkgs = system: nixpkgs.legacyPackages.${system};
  in {
    devShells = eachSystem (system: let
      pkgs = withPkgs system;
      ocamlDeps = with pkgs.ocamlPackages; [
        # OCaml itself
        ocaml
        # OCaml libraries
        core stdio
        # OCaml utils
        findlib utop
      ];
      utils = with pkgs; [
        just dune_3
      ];
    in { 
      default = pkgs.mkShell {
        packages = [] ++ ocamlDeps ++ utils;
      };
    });
  };
}
