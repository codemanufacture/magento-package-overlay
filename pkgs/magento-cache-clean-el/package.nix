{
  lib,
  fetchFromGitHub,
  magento-cache-clean,
  emacsPackages,
}:

emacsPackages.trivialBuild {
  pname = "magento-cache-clean";
  version = "0.1.0-unstable-2026-10-22";

  src = fetchFromGitHub {
    owner = "emacs-magento";
    repo = "magento-cache-clean.el";
    rev = "2ab0511deb4989f6c00d3c21c85843c2acfb9128";
    hash = "sha256-ssXVlO0R7syjgTbNhDOKWhiSJpL5GtUNwiT88hsYQLQ=";
  };

  postPatch = ''
    substituteInPlace magento-cache-clean.el \
      --replace-fail '("cache-clean" . nil)' '("cache-clean" . nil) ("${magento-cache-clean}/bin/cache-clean" . nil)'
  '';

  meta = {
    description = "Emacs integration for mage-os/magento-cache-clean";
    homepage = "https://github.com/emacs-magento/magento-cache-clean.el";
    license = lib.licenses.gpl3Plus;
  };
}
