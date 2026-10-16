{
  lib,
  fetchFromGitHub,
  magento-cache-clean,
  emacsPackages,
}:

emacsPackages.trivialBuild {
  pname = "magento-cache-clean";
  version = "0.1.0-unstable-2026-10-15";

  src = fetchFromGitHub {
    owner = "emacs-magento";
    repo = "magento-cache-clean.el";
    rev = "8d7102675188ed8fd6cf66479d58cca1a3c5fda1";
    hash = "sha256-oRmAgT/Vwl7olZ6LHjhNAM1FUUVmnWC+qnKj6jwuODU=";
  };

  postPatch = ''
    substituteInPlace magento-cache-clean.el \
      --replace-fail '"cache-clean"' '"${magento-cache-clean}/bin/cache-clean"'
  '';

  meta = {
    description = "Emacs integration for mage-os/magento-cache-clean";
    homepage = "https://github.com/emacs-magento/magento-cache-clean.el";
    license = lib.licenses.gpl3Plus;
  };
}
