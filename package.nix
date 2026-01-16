{
  nodejs,
  pnpm_10,
  pnpmConfigHook,
  fetchPnpmDeps,
  bash,
  stdenv,
  lib,
}:
stdenv.mkDerivation (finalAttrs: rec {
  pname = "churri";
  version = "0.1.0";

  src = lib.cleanSource ./.;

  nativeBuildInputs = [
    nodejs
    (pnpmConfigHook.override { pnpm = pnpm_10; })
    pnpm_10
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 2;
    hash = "sha256-+ZEd7Gofbxq1dFs+1soHBIRZEDtIGHs/1iKM4wk1J2E=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    pnpm run build
    cp -r build $out/build

    pnpm prune --prod
    # Clean up broken symlinks left behind by `pnpm prune`
    # https://github.com/pnpm/pnpm/issues/3645
    find node_modules -xtype l -delete

    cp -r node_modules package.json $out/

    mkdir -p $out/bin
    echo "\
    #!${bash}/bin/bash 
    ${nodejs}/bin/node $out/build
    " > $out/bin/${pname}

    chmod ugo+x $out/bin/${pname}

    runHook postInstall
  '';
})
