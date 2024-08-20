{
  description = "Developing with flutter.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { nixpkgs, ... }@inputs: let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    eachSystem = nixpkgs.lib.genAttrs systems;
    withPkgs = system: import nixpkgs {
      system = system;
    };
  in {
    devShells = eachSystem (system: let
      pkgs = withPkgs system;
    in { 
      default = pkgs.mkShell {
        packages = [
          pkgs.flutter
        ];
      };
    });
  };
}
