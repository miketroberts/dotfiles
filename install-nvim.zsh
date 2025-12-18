#!/usr/bin/zsh

# Configuration
TARGET_VERSION="0.10.0"
DOWNLOAD_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
INSTALL_DIR="$HOME/local/nvim"
PARENT_DIR="$HOME/local"
TEMP_ARCHIVE="/tmp/nvim-linux-x86_64.tar.gz"

# 1. Check current version
# We use 'command -v' to check if nvim exists at all first
if command -v nvim >/dev/null 2>&1; then
    current_version=$(nvim --version | head -n 1 | cut -d' ' -f2)
    current_version=${current_version#v} # Strip 'v' prefix
    
    autoload is-at-least
    if is-at-least "$TARGET_VERSION" "$current_version"; then
        echo "Nvim $current_version is already installed (>= $TARGET_VERSION). Nothing to do."
        exit 0
    else
        echo "Current Nvim ($current_version) is older than $TARGET_VERSION. Updating..."
    fi
else
    echo "Nvim is not installed. Proceeding with installation..."
fi

# 2. Prepare directories
echo "Preparing directory: $INSTALL_DIR"
mkdir -p "$PARENT_DIR"
# Delete existing nvim directory if it exists
[[ -d "$INSTALL_DIR" ]] && rm -rf "$INSTALL_DIR"

# 3. Download the archive
echo "Downloading latest Neovim release..."
if ! curl -L "$DOWNLOAD_URL" -o "$TEMP_ARCHIVE"; then
    echo "Error: Failed to download Neovim."
    exit 1
fi

# 4. Extract
echo "Extracting to $INSTALL_DIR..."
# Create the specific nvim folder
mkdir -p "$INSTALL_DIR"

# Extracting with --strip-components=1 ensures the contents of the 
# 'nvim-linux-x86_64' folder go directly into ~/local/nvim
tar -xzf "$TEMP_ARCHIVE" -C "$INSTALL_DIR" --strip-components=1

# 5. Cleanup
rm "$TEMP_ARCHIVE"

echo "Success! Neovim has been installed to $INSTALL_DIR"
echo "Note: Ensure $INSTALL_DIR/bin is in your PATH."
