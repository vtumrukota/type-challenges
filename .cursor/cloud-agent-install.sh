#!/usr/bin/env bash
set -euo pipefail

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

if ! nvm ls 16 >/dev/null 2>&1; then
  nvm install 16
fi

NODE16_BIN="$(find "$NVM_DIR/versions/node" -maxdepth 1 -type d -name 'v16.*' | sort -V | tail -n 1)/bin"
export PATH="$NODE16_BIN:$PATH"

if ! command -v pnpm >/dev/null 2>&1 || ! pnpm -v | grep -q '^6\.'; then
  npm install -g pnpm@6.32.3
fi

pnpm install --frozen-lockfile
