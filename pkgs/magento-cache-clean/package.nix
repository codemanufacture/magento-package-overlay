{
  lib,
  stdenv,
  fetchFromGitHub,
  nodejs,
  makeWrapper,
}:

stdenv.mkDerivation {
  pname = "magento-cache-clean";
  version = "1.1.4-unstable-2026-05-07";

  src = fetchFromGitHub {
    owner = "mage-os";
    repo = "magento-cache-clean";
    rev = "6826efb6ce29e912467aeca7bb3a03f00f9828fe";
    hash = "sha256-sErYYccMaB4fqR1uoUVrSSFR7TsAkfk+hgw+1i5M5dU=";
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
