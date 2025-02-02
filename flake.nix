{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/5633bcff0c6162b9e4b5f1264264611e950c8ec7"; # Problem with pnpm.fetchDeps
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
            pkgs.pnpm_9
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
