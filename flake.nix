{
  description = "My flake templates";
  outputs = { self }: {
    templates = {
      base = {
        path = ./base;
        description = "The base flake";
      };
      ocaml = {
        path = ./ocaml;
        description = "Developing with OCaml.";
      };
      rust = {
        path = ./rust;
        description = "Developing with Rust, using fenix complete toolchain.";
      };
      flutter = {
        path = ./dart/flutter;
        description = "Developing with Flutter.";
      };
      flutter-android = {
        path = ./dart/flutter/with_android;
        description = "Developing with Flutter and Android Studio.";
      };
      default = self.templates.base;
    };
  };
}
