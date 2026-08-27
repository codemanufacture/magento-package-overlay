{
  lib,
  fetchFromGitHub,
  php83,
}:

php83.buildComposerProject2 (finalAttrs: {
  pname = "n98-magerun2";
  version = "10.0.2";

  src = fetchFromGitHub {
    owner = "netz98";
    repo = "n98-magerun2";
    tag = finalAttrs.version;
    hash = "sha256-T1RuVU9PN5Ub1iRwRlJtwKnuGd5HzmnTbfeABQkmjLc=";
  };

  vendorHash = "sha256-YX4XHzQf6uURbsDUWUQr2Jn+XI1XIFoPp1UpExvo4Ac=";

  meta = {
    changelog = "https://magerun.net/category/magerun/";
    description = "Swiss army knife for Magento2 developers";
    homepage = "https://magerun.net/";
    license = lib.licenses.mit;
    mainProgram = "n98-magerun2";
  };
})
