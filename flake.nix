{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  outputs = { self, nixpkgs }: let
    meta = builtins.fromTOML (builtins.readFile "${self}/meta.toml");
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.runCommand "build-project" { } ''
      mkdir -p $out/${meta.version}
      cp -r ${self}/proto ./proto
      chmod -R u+w ./proto
      tar -cf $out/${meta.version}/kernel-paniks-proto-${meta.version}.tar proto/
    '';
  };
}
