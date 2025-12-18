#!/usr/bin/zsh

# We want to be using zsh.
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

sync_dotfiles() {
  local source_dir=${1:A} # :A expands to absolute path
  local target_dir=${2:A}
  local dry_run=$3

  # Ensure source and target are provided
  [[ -z "$source_dir" || -z "$target_dir" ]] && { echo "Usage: sync_dotfiles <src> <dest> [dry_run_bool]"; return 1 }

  # Iterate over all files/dirs in the source (including hidden ones)
  for item in $source_dir/.*(D); do
    local base_item=$(basename "$item")
    [[ "$base_item" == "." || "$base_item" == ".." ]] && continue
    local dest_item="$target_dir/$base_item"

    if [[ -d "$item" && ! -L "$item" ]]; then
      # It is a real directory
      if [[ -d "$dest_item" && ! -L "$dest_item" ]]; then
        # Destination is also a real directory: descend
        [[ "$dry_run" == "true" ]] && echo "[DRY-RUN] Would descend into $base_item"
        sync_dotfiles "$item" "$dest_item" "$dry_run"
      else
        # Destination doesn't exist or is a file/link: Link the whole dir
        if [[ "$dry_run" == "true" ]]; then
          echo "[DRY-RUN] Would link directory: $dest_item -> $item"
        else
          echo "Linking directory: $dest_item -> $item"
          ln -sfn "$item" "$dest_item"
        fi
      fi
    else
      # It is a file or a symlink
      if [[ "$dry_run" == "true" ]]; then
        echo "[DRY-RUN] Would link file: $dest_item -> $item"
      else
        echo "Linking file: $dest_item -> $item"
        ln -sfn "$item" "$dest_item"
      fi
    fi
  done
}

# Install dependencies.
make install

# Link in all of the configuration.
script_dir=$(dirname "$(readlink -f "$0")")
sync_dotfiles $script_dir ~ false
