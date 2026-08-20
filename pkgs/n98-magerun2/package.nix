{
  lib,
  fetchFromGitHub,
  php83,
}:

php83.buildComposerProject2 (finalAttrs: {
  pname = "n98-magerun2";
  version = "10.0.0";

  src = fetchFromGitHub {
    owner = "netz98";
    repo = "n98-magerun2";
    tag = finalAttrs.version;
    hash = "sha256-WwsvaS1RvsqDwSJVBUVmTf6hiWhsIvNb0qC4q7yx9PY=";
  };

  vendorHash = "sha256-ZUTgOJC026/d+57FNc+ivSkbEQEk/LSJCOgdfPaz6cY=";

  meta = {
    changelog = "https://magerun.net/category/magerun/";
    description = "Swiss army knife for Magento2 developers";
    homepage = "https://magerun.net/";
    license = lib.licenses.mit;
    mainProgram = "n98-magerun2";
  };
})
