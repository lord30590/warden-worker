#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not a git repository: $REPO_DIR" >&2
  exit 1
fi

if ! git remote get-url upstream >/dev/null 2>&1; then
  echo "Missing upstream remote. Run:" >&2
  echo "git remote add upstream https://github.com/qaz741wsd856/warden-worker.git" >&2
  exit 1
fi

if ! git show-ref --verify --quiet refs/heads/main; then
  git checkout -b main
else
  git checkout main
fi

git fetch upstream
git merge --no-edit --allow-unrelated-histories upstream/main

echo "Upstream merged into local main."
echo "If you configured origin, push with: git push origin main"
