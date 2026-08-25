{
  lib,
  fetchFromGitHub,
  php83,
}:

php83.buildComposerProject2 (finalAttrs: {
  pname = "n98-magerun2";
  version = "10.0.1";

  src = fetchFromGitHub {
    owner = "netz98";
    repo = "n98-magerun2";
    tag = finalAttrs.version;
    hash = "sha256-ejpRRfkyjLAiPMuUm4q9EQLj3/V7rwCcJzpt9ePTxvA=";
  };

  vendorHash = "sha256-Z/v4r181ePMJES6jwy2dfv/V2YJwnIdwHmR0y5FNdKw=";

  meta = {
    changelog = "https://magerun.net/category/magerun/";
    description = "Swiss army knife for Magento2 developers";
    homepage = "https://magerun.net/";
    license = lib.licenses.mit;
    mainProgram = "n98-magerun2";
  };
})
