{ pkgs }:
pkgs.stdenv.mkDerivation (finalAttrs: rec {
  pname = "churri";
  version = "0.1.0";

  src = pkgs.lib.cleanSource ./.;

  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.pnpm.configHook
  ];

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-i1dJ7PQ84/2pGFhu6b9s3yM4LOWfNdcPm2BrcqhqgR8=";
  };

  buildPhase = ''
    runHook preBuild

    pnpm run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r build $out/build

    pnpm prune --prod
    cp -r node_modules package.json $out/

    mkdir -p $out/bin
    echo "
      #!${pkgs.bash}/bin/bash 
      ${pkgs.nodejs}/bin/node $out/build
    " > $out/bin/${pname}

    chmod +x $out/bin/${pname}

    runHook postInstall
  '';
})
