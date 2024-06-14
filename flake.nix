{
  description = "My flake templates";
  outputs = { self }: {
    templates = {
      base = {
        path = ./base;
        description = "The base flake";
      };
      default = self.templates.base;
    };
  };
}
