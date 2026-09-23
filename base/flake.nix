{
  description = "The base nix flake.";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    systems = ["x86_64-linux" "aarch64-linux"];
    eachSystem = nixpkgs.lib.genAttrs systems;
    withPkgs = system: (import nixpkgs {
      inherit system;
    });

    perSystem = eachSystem (
      system: let
        pkgs = withPkgs system;
      in
        with pkgs; {
          formatter = alejandra;
          devShells = {
            default = mkShell {
              packages = [
              ];
            };
          };
        }
    );
    formatter = nixpkgs.lib.mapAttrs (_: v: v.formatter) perSystem;
    devShells = nixpkgs.lib.mapAttrs (_: v: v.devShells) perSystem;
  in {inherit formatter devShells;};
}
