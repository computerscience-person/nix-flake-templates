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
      default = self.templates.base;
    };
  };
}
