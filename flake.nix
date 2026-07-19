let
    meta = builtins.fromTOML (builtins.readFile ./meta.toml);
in
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.runCommand "build-project" { } ''
      mkdir -p $out
      mkdir -p $out/${meta.version}

      tar -cf $out/${meta.version}/kernel-paniks-proto-${meta.version}.tar \
        -C ${self} proto/
    '';
  };
}
