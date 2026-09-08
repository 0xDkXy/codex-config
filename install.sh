#!/usr/bin/env bash
set -euo pipefail

if (( $# )); then
    echo 'Usage: [CODEX_HOME=/path/to/codex] ./install.sh' >&2
    exit 1
fi

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
codex_dir=${CODEX_HOME:-"$HOME/.codex"}
files=(config.toml AGENTS.md agents/explorer.toml agents/worker.toml agents/reviewer.toml)

# Check every destination before replacing any files.
for file in "${files[@]}"; do
    if [[ "$repo_dir/$file" -ef "$codex_dir/$file" || -d "$codex_dir/$file" ]]; then
        echo "Refusing to overwrite the source file or a directory: $codex_dir/$file" >&2
        exit 1
    fi
done

mkdir -p -- "$codex_dir/agents"
for file in "${files[@]}"; do
    cp --backup=numbered --remove-destination --no-target-directory -- \
        "$repo_dir/$file" "$codex_dir/$file"
done

printf 'Installed to %s\nExisting files were backed up beside their replacements as FILE.~N~.\n' "$codex_dir"
