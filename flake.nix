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
      default = self.templates.base;
    };
  };
}
