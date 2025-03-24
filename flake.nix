{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          default = pkgs.callPackage ./package.nix { };
        };

        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.pnpm_10
            pkgs.nodejs
          ];

          shellHook = ''
            pnpm install
          '';
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    )
    // {
      nixosModules.default = import ./module.nix;
    };
}
