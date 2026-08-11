{
  lib,
  stdenv,
  fetchFromGitHub,
  nodejs,
  makeWrapper,
}:

stdenv.mkDerivation {
  pname = "magento-cache-clean";
  version = "1.1.4-unstable-2026-08-10";

  src = fetchFromGitHub {
    owner = "mage-os";
    repo = "magento-cache-clean";
    rev = "71730b963a5be94092c418d83bd2ab18c8650370";
    hash = "sha256-nj8Z7cikBRFXnmWY4xDnYHzxkSO79upVWRdgEG843ZU=";
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
