{
  lib,
  fetchFromGitHub,
  magento-cache-clean,
  emacsPackages,
}:

emacsPackages.trivialBuild {
  pname = "magento-cache-clean";
  version = "0.1.0-unstable-2026-03-06";

  src = fetchFromGitHub {
    owner = "emacs-magento";
    repo = "magento-cache-clean.el";
    rev = "e696cd90a42313fea0f30fd0a09a0e8965a81938";
    hash = "sha256-AA3Bzu5aI70HKiC135CjcfBRUayqX1cv+wwW+b0cdKY=";
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
