{
  description = "The base nix flake.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { nixpkgs, ... }@inputs: let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    eachSystem = nixpkgs.lib.genAttrs systems;
    withPkgs = system: import nixpkgs {
      system = system;
      config.allowUnfree = true;
    };
  in {
    devShells = eachSystem (system: let
      pkgs = withPkgs system;
      jdk = pkgs.temurin-bin-21;
      androidtools = pkgs.androidenv.composeAndroidPackages {
        cmdLineToolsVersion = "13.0";
        platformTools = "35.0.1";
        buildTools = "34.0.0";
        platformsVersions = [ "32" "33" "34" ];
        emulator = "35.1.4";
        includeSources = false;
        incldeSystemImages = false;
        abiVersions = [ "arm64-v8a" ];
        useGoogleAPIs = false;
        useGoogleTVAddOns = false;
      };
    in { 
      default = pkgs.mkShell {
        packages = [
          jdk
          androidtools.androidsdk
          pkgs.flutter
          pkgs.gradle
        ];
      };
    });
  };
}
