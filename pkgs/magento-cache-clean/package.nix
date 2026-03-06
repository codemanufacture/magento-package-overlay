{
  lib,
  stdenv,
  fetchFromGitHub,
  nodejs,
  makeWrapper,
}:

stdenv.mkDerivation {
  pname = "magento-cache-clean";
  version = "1.1.4-unstable-2025-10-28";

  src = fetchFromGitHub {
    owner = "mage-os";
    repo = "magento-cache-clean";
    rev = "1aa55fda2769f14c83abd358f026946e67d60880";
    hash = "sha256-BbKS1b1nYkbFnIry+m7vh98DV5H734lHhnLMldWcg/0=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/magento-cache-clean $out/bin
    cp -r bin node_modules $out/lib/magento-cache-clean/

    makeWrapper ${nodejs}/bin/node $out/bin/cache-clean \
      --add-flags "$out/lib/magento-cache-clean/bin/cache-clean.js"

    runHook postInstall
  '';

  meta = {
    description = "File watcher based cache cleaner for Magento 2";
    homepage = "https://github.com/mage-os/magento-cache-clean";
    license = lib.licenses.bsd3;
    mainProgram = "cache-clean";
  };
}
