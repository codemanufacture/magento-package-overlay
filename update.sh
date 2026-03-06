#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

update_n98_magerun2() {
  echo "Checking n98-magerun2..."
  local pkg_file="$SCRIPT_DIR/pkgs/n98-magerun2/package.nix"
  local current_version
  current_version=$(grep 'version = "' "$pkg_file" | head -1 | sed 's/.*version = "\(.*\)".*/\1/')

  local latest_version
  latest_version=$(curl -sL https://api.github.com/repos/netz98/n98-magerun2/releases/latest | jq -r .tag_name)

  if [ "$current_version" = "$latest_version" ]; then
    echo "n98-magerun2 is up to date at $current_version"
    return
  fi

  echo "Updating n98-magerun2 $current_version -> $latest_version"

  local src_hash
  src_hash=$(nix-prefetch-url --unpack "https://github.com/netz98/n98-magerun2/archive/refs/tags/${latest_version}.tar.gz" 2>/dev/null | tail -1)
  src_hash=$(nix hash convert --hash-algo sha256 --to sri "$src_hash")

  sed -i "s|version = \"$current_version\"|version = \"$latest_version\"|" "$pkg_file"

  # Update src hash (first occurrence)
  sed -i "0,/hash = \"sha256-.*\"/s||hash = \"$src_hash\"|" "$pkg_file"

  # Set vendorHash to empty to trigger rebuild and get correct hash
  sed -i "s|vendorHash = \"sha256-.*\"|vendorHash = \"\"|" "$pkg_file"

  echo "Building to determine new vendorHash..."
  local build_output
  build_output=$(nix build "$SCRIPT_DIR#n98-magerun2" -L 2>&1 || true)
  local vendor_hash
  vendor_hash=$(echo "$build_output" | grep "got:" | sed 's/.*got: *//')

  if [ -n "$vendor_hash" ]; then
    sed -i "s|vendorHash = \"\"|vendorHash = \"$vendor_hash\"|" "$pkg_file"
    echo "Updated n98-magerun2 to $latest_version"
  else
    echo "ERROR: Could not determine vendorHash for n98-magerun2"
    return 1
  fi
}

update_magento_cache_clean() {
  echo "Checking magento-cache-clean..."
  local pkg_file="$SCRIPT_DIR/pkgs/magento-cache-clean/package.nix"
  local current_rev
  current_rev=$(grep 'rev = "' "$pkg_file" | sed 's/.*rev = "\(.*\)".*/\1/')

  local latest_commit
  latest_commit=$(curl -sL 'https://api.github.com/repos/mage-os/magento-cache-clean/commits?per_page=1' | jq -r '.[0].sha')
  local commit_date
  commit_date=$(curl -sL "https://api.github.com/repos/mage-os/magento-cache-clean/commits/$latest_commit" | jq -r '.commit.committer.date' | cut -dT -f1)

  if [ "$current_rev" = "$latest_commit" ]; then
    echo "magento-cache-clean is up to date at $current_rev"
    return
  fi

  echo "Updating magento-cache-clean $current_rev -> $latest_commit"

  local new_hash
  new_hash=$(nix-prefetch-url --unpack "https://github.com/mage-os/magento-cache-clean/archive/${latest_commit}.tar.gz" 2>/dev/null | tail -1)
  new_hash=$(nix hash convert --hash-algo sha256 --to sri "$new_hash")

  local base_version
  base_version=$(grep 'version = "' "$pkg_file" | sed 's/.*version = "\([^-]*\).*/\1/')
  local new_version="${base_version}-unstable-${commit_date}"

  sed -i "s|version = \".*\"|version = \"$new_version\"|" "$pkg_file"
  sed -i "s|rev = \".*\"|rev = \"$latest_commit\"|" "$pkg_file"
  sed -i "s|hash = \"sha256-.*\"|hash = \"$new_hash\"|" "$pkg_file"

  echo "Updated magento-cache-clean to $latest_commit ($commit_date)"
}

update_magento_cache_clean_el() {
  echo "Checking magento-cache-clean.el..."
  local pkg_file="$SCRIPT_DIR/pkgs/magento-cache-clean-el/package.nix"
  local current_rev
  current_rev=$(grep 'rev = "' "$pkg_file" | sed 's/.*rev = "\(.*\)".*/\1/')

  local latest_commit
  latest_commit=$(curl -sL 'https://api.github.com/repos/emacs-magento/magento-cache-clean.el/commits?per_page=1' | jq -r '.[0].sha')
  local commit_date
  commit_date=$(curl -sL "https://api.github.com/repos/emacs-magento/magento-cache-clean.el/commits/$latest_commit" | jq -r '.commit.committer.date' | cut -dT -f1)

  if [ "$current_rev" = "$latest_commit" ]; then
    echo "magento-cache-clean.el is up to date at $current_rev"
    return
  fi

  echo "Updating magento-cache-clean.el $current_rev -> $latest_commit"

  local new_hash
  new_hash=$(nix-prefetch-url --unpack "https://github.com/emacs-magento/magento-cache-clean.el/archive/${latest_commit}.tar.gz" 2>/dev/null | tail -1)
  new_hash=$(nix hash convert --hash-algo sha256 --to sri "$new_hash")

  local base_version
  base_version=$(grep 'version = "' "$pkg_file" | sed 's/.*version = "\([^-]*\).*/\1/')
  local new_version="${base_version}-unstable-${commit_date}"

  sed -i "s|version = \".*\"|version = \"$new_version\"|" "$pkg_file"
  sed -i "s|rev = \".*\"|rev = \"$latest_commit\"|" "$pkg_file"
  sed -i "s|hash = \"sha256-.*\"|hash = \"$new_hash\"|" "$pkg_file"

  echo "Updated magento-cache-clean.el to $latest_commit ($commit_date)"
}

update_n98_magerun2
update_magento_cache_clean
update_magento_cache_clean_el
