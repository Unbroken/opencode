#!/usr/bin/env bash
set -euo pipefail

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'missing required command: %s\n' "$1" >&2
    exit 1
  fi
}

root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
pkg="$root/packages/opencode"
ext="$root/sdks/vscode"
bin="${XDG_BIN_DIR:-$HOME/.local/bin}"
name="${OPENCODE_LINK_NAME:-opencode}"

os=$(uname -s | tr '[:upper:]' '[:lower:]')
arch=$(uname -m)

case "$arch" in
  aarch64 | arm64) arch="arm64" ;;
  x86_64 | amd64) arch="x64" ;;
esac

out="$pkg/dist/opencode-$os-$arch/bin/opencode"
link="$bin/$name"
vsix="$ext/dist/opencode-local.vsix"

need bun
need node
need npm

printf 'building opencode for %s-%s\n' "$os" "$arch"
bun run --cwd "$pkg" build --single

if [ ! -x "$out" ]; then
  printf 'build succeeded but binary was not found at %s\n' "$out" >&2
  exit 1
fi

mkdir -p "$bin"
ln -sfn "$out" "$link"

printf 'linked %s -> %s\n' "$link" "$out"

printf 'building local VS Code extension\n'
(
  cd "$ext"
  bun install --frozen-lockfile
  bun x --package @vscode/vsce vsce package --no-dependencies -o "dist/$(basename "$vsix")"
)

printf 'built VS Code extension at %s\n' "$vsix"
