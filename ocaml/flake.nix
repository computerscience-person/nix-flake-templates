{
  description = "The base nix flake.";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    inherit (nixpkgs) lib;
    eachSystem = lib.genAttrs lib.systems.flakeExposed;
    withPkgs = system: (import nixpkgs {
      inherit system;
    });

    perSystem = eachSystem (
      system: let
        pkgs = withPkgs system;
        ocaml' = with pkgs; with ocamlPackages; [
          ocaml
          findlib utop dune
        ];
        ocamlExtras = with pkgs.ocamlPackages; [
          containers eio
        ];
      in
        with pkgs; {
          formatter = alejandra;
          devShells = {
            default = mkShell {
              packages = [
              ] ++ ocaml';
            };
          };
          package = {
            default = {};
          };
        }
    );
    formatter = nixpkgs.lib.mapAttrs (_: v: v.formatter) perSystem;
    devShells = nixpkgs.lib.mapAttrs (_: v: v.devShells) perSystem;
    package = nixpkgs.lib.mapAttrs (_: v: v.package) perSystem;
  in {inherit formatter devShells package;};
}
