{
  description = "A simple http/2 & http/1.1 spec compliant proxy helper for Node. ";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }: let
    name = "http2-proxy"; 
  in
    flake-utils.lib.eachDefaultSystem(system: let

      pkgs = import nixpkgs { inherit system; };

      pkg = with pkgs; buildNpmPackage {
        inherit name;

        buildInputs = [
          pkgs.nodejs-16_x
        ];

        src = ./.;
        npmDepsHash = "sha256-w4mK0TEFjyTB9eKf0pTrmIcqGflPzNWZ1jOVFk5m/ls=";
      };

    in {
      packages.default = pkg;
      packages.${name} = pkg;
    });
}

