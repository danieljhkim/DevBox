#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-}"
[[ -n "$TAG" ]] || { echo "Usage: $0 <tag like v0.1.0>" >&2; exit 1; }

VERSION="${TAG#v}"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST="$ROOT/dist"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

# Basic tool checks (packaging is expected to run in CI, but keep it explicit)
command -v tar >/dev/null 2>&1 || { echo "Error: tar is required" >&2; exit 1; }

rm -rf "$DIST"
mkdir -p "$DIST"

mkdir -p "$STAGE/devbox"

# Required runtime files
[[ -f "$ROOT/devbox" ]] || { echo "Error: $ROOT/devbox not found" >&2; exit 1; }
[[ -d "$ROOT/bin" ]] || { echo "Error: $ROOT/bin directory not found" >&2; exit 1; }
[[ -f "$ROOT/bin/devbox" ]] || { echo "Error: $ROOT/bin/devbox not found" >&2; exit 1; }
[[ -f "$ROOT/bin/install-devbox" ]] || { echo "Error: $ROOT/bin/install-devbox not found" >&2; exit 1; }
cp -a "$ROOT/devbox" "$STAGE/devbox/"     # entrypoint at repo root
cp -a "$ROOT/bin"   "$STAGE/devbox/"

# Contract directory (hidden). This is required for a functional release bundle.
[[ -d "$ROOT/.box" ]] || { echo "Error: $ROOT/.box directory not found" >&2; exit 1; }
cp -a "$ROOT/.box" "$STAGE/devbox/"

# Optional runtime/support files (include what you want shipped)
[[ -d "$ROOT/settings" ]] && cp -a "$ROOT/settings" "$STAGE/devbox/"
[[ -d "$ROOT/docs" ]]     && cp -a "$ROOT/docs" "$STAGE/devbox/"

# Optional documentation in root (harmless to include)
for f in README.md QUICK_START.md SECURITY.md CHANGELOG.md CONFORMANCE.md SPEC.md LICENSE.md; do
  [[ -f "$ROOT/$f" ]] && cp -a "$ROOT/$f" "$STAGE/devbox/"
done

chmod +x \
  "$STAGE/devbox/devbox" \
  "$STAGE/devbox/bin/devbox" \
  "$STAGE/devbox/bin/install-devbox" \
  2>/dev/null || true

ASSET="devbox_${VERSION}_all.tar.gz"
tar -C "$STAGE" -czf "$DIST/$ASSET" devbox

(
  cd "$DIST"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$ASSET" > checksums.txt
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$ASSET" > checksums.txt
  else
    echo "Error: sha256sum or shasum is required to generate checksums" >&2
    exit 1
  fi
)

echo "Built:"
echo "  $DIST/$ASSET"
echo "  $DIST/checksums.txt"