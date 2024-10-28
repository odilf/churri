{ pkgs }:
pkgs.stdenv.mkDerivation (finalAttrs: rec {
  pname = "churri";
  version = "0.1.0";

  src = pkgs.lib.cleanSource ./.;

  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.pnpm.configHook
    pkgs.makeWrapper
  ];

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-g5MmetcF3zn2FeC2euv90z2J2ge6g5aSc8aFK90rxWI=";
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
