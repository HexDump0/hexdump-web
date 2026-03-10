#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONTENT_DIR="$SCRIPT_DIR/content"

# Find font directory dynamically
if [[ -f "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" ]]; then
  FONT_DIR="$HOME/.local/share/fonts"
elif [[ -f "/usr/share/fonts/TTF/JetBrainsMonoNerdFont-Regular.ttf" ]]; then
  FONT_DIR="/usr/share/fonts/TTF"
else
  echo "Error: JetBrains Mono Nerd Font not found in common locations."
  exit 1
fi

D2_THEME='vars: {
  d2-config: {
    dark-theme-overrides: {
      N1: "#ffffff"
      N2: "#a1a1aa"
      N3: "#3f3f46"
      N4: "#27272a"
      N5: "#232326"
      N6: "#1f1f22"
      N7: "#18181b"

      B1: "#60a5fa"
      B2: "#93c5fd"
      B3: "#3f3f46"
      B4: "#27272a"
      B5: "#232326"
      B6: "#1f1f22"
    }
  }
}'

build_d2() {
  local input="$1"
  local output="${input%.d2}.svg"
  local tmpfile
  tmpfile="$(mktemp)"

  printf '%s\n' "$D2_THEME" > "$tmpfile"
  cat "$input" >> "$tmpfile"

  d2 \
    --dark-theme 200 \
    --pad=60 \
    --center \
    --font-regular="$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" \
    --font-bold="$FONT_DIR/JetBrainsMonoNerdFont-Bold.ttf" \
    --font-italic="$FONT_DIR/JetBrainsMonoNerdFont-Italic.ttf" \
    --font-semibold="$FONT_DIR/JetBrainsMonoNerdFont-SemiBold.ttf" \
    --font-mono="$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" \
    --font-mono-bold="$FONT_DIR/JetBrainsMonoNerdFont-Bold.ttf" \
    --font-mono-italic="$FONT_DIR/JetBrainsMonoNerdFont-Italic.ttf" \
    --font-mono-semibold="$FONT_DIR/JetBrainsMonoNerdFont-SemiBold.ttf" \
    "$tmpfile" "$output"

  rm -f "$tmpfile"
  echo "  Built: $output"
}

build_all_d2() {
  local d2_files
  d2_files="$(find "$CONTENT_DIR" -name '*.d2' -type f 2>/dev/null || true)"
  if [[ -z "$d2_files" ]]; then
    echo "No .d2 files found."
    return
  fi
  echo "Building d2 diagrams..."
  while IFS= read -r f; do
    build_d2 "$f"
  done <<< "$d2_files"
}

patch_markdown() {
  echo "Patching markdown references (.d2 → .svg)..."
  find "$CONTENT_DIR" -name '*.md' -type f -exec \
    sed -i 's/\(!\?\[.*\](.*\)\.d2)/\1.svg)/g' {} +
}

d2_checksum() {
  find "$CONTENT_DIR" -name '*.d2' -type f -exec md5sum {} + 2>/dev/null | sort | md5sum | cut -d' ' -f1
}

watch_d2() {
  echo "Watching for .d2 file changes (polling every 2s)..."
  local prev_hash
  prev_hash="$(d2_checksum)"
  while true; do
    sleep 2
    local curr_hash
    curr_hash="$(d2_checksum)"
    if [[ "$curr_hash" != "$prev_hash" ]]; then
      echo ""
      echo "D2 change detected, rebuilding..."
      build_all_d2
      patch_markdown
      prev_hash="$curr_hash"
    fi
  done
}

case "${1:-}" in
  build)
    build_all_d2
    patch_markdown
    npm run css:build
    zola build
    ;;
  serve)
    build_all_d2
    patch_markdown
    watch_d2 &
    D2_PID=$!
    trap "kill $D2_PID 2>/dev/null" EXIT
    npx concurrently \
      --names "css,zola" \
      --prefix-colors "cyan,green" \
      "npm run css" \
      "zola serve --drafts"
    ;;
  *)
    echo "Usage: ./hx <build|serve>"
    exit 1
    ;;
esac
