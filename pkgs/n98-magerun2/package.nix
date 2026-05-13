{
  lib,
  fetchFromGitHub,
  php83,
}:

php83.buildComposerProject2 (finalAttrs: {
  pname = "n98-magerun2";
  version = "9.5.0";

  src = fetchFromGitHub {
    owner = "netz98";
    repo = "n98-magerun2";
    tag = finalAttrs.version;
    hash = "sha256-01wGWxj03VGbZjV4NLI5gzelA6mfmT8IKCk6NzUIxlc=";
  };

  vendorHash = "sha256-wr6tc4hgBvDRXA8f8HAc1r7ei7DvVV9YyZOaWNruBrg=";

  meta = {
    changelog = "https://magerun.net/category/magerun/";
    description = "Swiss army knife for Magento2 developers";
    homepage = "https://magerun.net/";
    license = lib.licenses.mit;
    mainProgram = "n98-magerun2";
  };
})
