{
  nodejs,
  pnpm_9,
  bash,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: rec {
  pname = "churri";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [
    nodejs
    pnpm_9.configHook
  ];

  pnpmDeps = pnpm_9.fetchDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-ZOrxjOEpVGO7xkQxwsSseg3cksRPH0rbJEa3hbqe9EI=";
  };

  buildPhase = ''
    runHook preBuild

    ls -l

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
    #!${bash}/bin/bash 
    ${nodejs}/bin/node $out/build
    " > $out/bin/${pname}

    chmod +x $out/bin/${pname}

    runHook postInstall
  '';
})
