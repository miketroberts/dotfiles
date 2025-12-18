#!/usr/bin/zsh

# We want to be using zsh.
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

sync_dotfiles() {
  local source_dir=${1:A}
  local target_dir=${2:A}
  local dry_run=$3
  # Use the provided pattern, or default to hidden files only for the root call
  local pattern=${4:-".*(D)"}

  # Ensure source and target are provided
  [[ -z "$source_dir" || -z "$target_dir" ]] && { echo "Usage: sync_dotfiles <src> <dest> [dry_run_bool]"; return 1 }

  # Expand the items based on the current pattern
  # ~ is used to expand the glob safely within the loop
  for item in $source_dir/${~pattern}; do
    local base_item=$(basename "$item")
    
    # Safety: Always ignore current and parent directory references
    [[ "$base_item" == "." || "$base_item" == ".." ]] && continue
    # Optional: Ignore .git directory
    [[ "$base_item" == ".git" ]] && continue

    local dest_item="$target_dir/$base_item"

    if [[ -d "$item" && ! -L "$item" ]]; then
      # If it's a real directory
      if [[ -d "$dest_item" && ! -L "$dest_item" ]]; then
        # If destination is a directory, descend and change pattern to "everything"
        [[ "$dry_run" == "true" ]] && echo "[DRY-RUN] Descending into $base_item"
        sync_dotfiles "$item" "$dest_item" "$dry_run" "*(D)"
      else
        # Destination is missing or a file: symlink the whole directory
        if [[ "$dry_run" == "true" ]]; then
          echo "[DRY-RUN] Would link directory: $dest_item -> $item"
        else
          echo "Linking directory: $dest_item -> $item"
          ln -sfn "$item" "$dest_item"
        fi
      fi
    else
      # If it's a file or symlink: overwrite the target
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
