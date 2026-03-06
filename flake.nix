{
  description = "Nix overlay for Magento development tools";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      overlays.default = final: prev: {
        magento-cache-clean = final.callPackage ./pkgs/magento-cache-clean/package.nix { };
        n98-magerun2 = final.callPackage ./pkgs/n98-magerun2/package.nix { };
      };

      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          inherit (pkgs) magento-cache-clean n98-magerun2;
        }
      );
    };
}
