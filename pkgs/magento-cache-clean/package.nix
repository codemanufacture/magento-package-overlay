{
  lib,
  stdenv,
  fetchFromGitHub,
  nodejs,
  makeWrapper,
}:

stdenv.mkDerivation {
  pname = "magento-cache-clean";
  version = "1.1.4-unstable-2026-07-02";

  src = fetchFromGitHub {
    owner = "mage-os";
    repo = "magento-cache-clean";
    rev = "07eaeef0f37e7fed6cb2143f92878742bf2c39b5";
    hash = "sha256-vesIqJHxmqq2LLax/BzXG6eAwdumbuq0pR+9qO+EWRQ=";
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
