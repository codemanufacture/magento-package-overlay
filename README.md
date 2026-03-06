# magento-package-overlay

Nix overlay providing up-to-date Magento development tools.

## Packages

| Package | Version | Source |
|---------|---------|--------|
| `n98-magerun2` | 9.3.0 | [netz98/n98-magerun2](https://github.com/netz98/n98-magerun2) |
| `magento-cache-clean` | 1.1.4-unstable | [mage-os/magento-cache-clean](https://github.com/mage-os/magento-cache-clean) |

## Usage

### As a flake overlay

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    magento-overlay.url = "github:codemanufacture/magento-package-overlay";
  };

  outputs = { nixpkgs, magento-overlay, ... }: {
    # NixOS configuration
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [
        { nixpkgs.overlays = [ magento-overlay.overlays.default ]; }
      ];
    };

    # Or in a devShell
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ magento-overlay.overlays.default ];
      };
    in pkgs.mkShell {
      packages = [ pkgs.n98-magerun2 pkgs.magento-cache-clean ];
    };
  };
}
```

### Run directly

```sh
nix run github:codemanufacture/magento-package-overlay#n98-magerun2
nix run github:codemanufacture/magento-package-overlay#magento-cache-clean
```

## Updates

Packages are automatically updated every 6 hours via GitHub Actions. The update script can also be run manually:

```sh
./update.sh
```
