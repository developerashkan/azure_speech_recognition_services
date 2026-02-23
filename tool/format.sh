#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

mapfile -t dart_files < <(git ls-files '*.dart')

if [[ ${#dart_files[@]} -eq 0 ]]; then
  echo "No Dart files found to format."
  exit 0
fi

dart format "${dart_files[@]}"
