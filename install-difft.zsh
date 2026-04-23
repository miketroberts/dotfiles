#!/usr/bin/env zsh
set -euo pipefail

# Only install on Linux.
if [[ "$(uname -s)" != "Linux" ]]; then
  echo "Skipping difftastic install: this script only runs on Linux."
  exit 0
fi

REPO="Wilfred/difftastic"
INSTALL_DIR="${HOME}/.local/bin"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"

mkdir -p "${INSTALL_DIR}"

# Map uname -m to common GitHub release architecture names.
case "$(uname -m)" in
  x86_64|amd64)
    ARCH_REGEX='(x86_64|amd64)'
    ;;
  aarch64|arm64)
    ARCH_REGEX='(aarch64|arm64)'
    ;;
  *)
    echo "Unsupported architecture for difftastic install: $(uname -m)" >&2
    exit 1
    ;;
esac

tmpdir="$(mktemp -d)"
cleanup() {
  rm -rf "${tmpdir}"
}
trap cleanup EXIT

echo "Looking up latest difftastic release..."

asset_url="$(
  curl -fsSL "${API_URL}" | python3 -c '
import json, re, sys
data = json.load(sys.stdin)
arch_regex = sys.argv[1]
for asset in data.get("assets", []):
    url = asset.get("browser_download_url", "")
    name = asset.get("name", "")
    if (
        re.search(r"linux", name, re.I)
        and re.search(arch_regex, name, re.I)
        and re.search(r"\.tar\.gz$", name)
    ):
        print(url)
        break
' "${ARCH_REGEX}"
)"

if [[ -z "${asset_url}" ]]; then
  echo "Could not find a suitable Linux release asset for $(uname -m)." >&2
  exit 1
fi

echo "Downloading ${asset_url}..."
archive="${tmpdir}/difftastic.tar.gz"
curl -fL "${asset_url}" -o "${archive}"

echo "Extracting..."
tar -xzf "${archive}" -C "${tmpdir}"

# Find the difft binary anywhere inside the extracted release.
binary_path="$(
  find "${tmpdir}" -type f -name difft | head -n 1
)"

if [[ -z "${binary_path}" ]]; then
  echo "Downloaded archive did not contain a difft binary." >&2
  exit 1
fi

install -m 0755 "${binary_path}" "${INSTALL_DIR}/difft"

echo "Installed difftastic to ${INSTALL_DIR}/difft"

case ":${PATH}:" in
  *":${INSTALL_DIR}:"*) ;;
  *)
    echo "Note: ${INSTALL_DIR} is not currently on your PATH."
    echo 'Add this to your shell config if needed:'
    echo 'export PATH="$HOME/.local/bin:$PATH"'
    ;;
esac
