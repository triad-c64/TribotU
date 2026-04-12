#!/usr/bin/env bash
# Assembles tribot-plus using KickAssembler.
#
# Usage:
#   ./build.sh [path/to/KickAss.jar]
#
# Defaults to tools/KickAss.jar if no argument is given.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
KICKASS="${1:-$REPO_ROOT/tools/KickAss.jar}"
BUILD_DIR="$REPO_ROOT/build"

if [[ ! -f "$KICKASS" ]]; then
    echo "KickAss.jar not found at: $KICKASS"
    echo "Usage: ./build.sh [path/to/KickAss.jar]"
    exit 1
fi

mkdir -p "$BUILD_DIR"

echo "Assembling src/tribot-plus.src ..."
# Run from src/ so KickAssembler resolves all output paths relative to the sources.
cd "$REPO_ROOT/src"
java -jar "$KICKASS" tribot-plus.src -o "$BUILD_DIR/tribot-plus.prg" -showmem

# KickAssembler writes the symbol file next to the output; move it into build/.
[[ -f "$REPO_ROOT/src/tribot-plus.sym" ]] && mv "$REPO_ROOT/src/tribot-plus.sym" "$BUILD_DIR/tribot-plus.sym"

echo "Done → build/tribot-plus.prg"
