#!/usr/bin/env bash
# Assembles tribot-plus using KickAssembler.
# Requires Java and KickAss.jar on the path or in the same directory.
#
# Usage:
#   ./build.sh [path/to/KickAss.jar]

set -euo pipefail

KICKASS="${1:-KickAss.jar}"
SOURCE="src/tribot-plus.src"
OUTPUT="tribot-plus.prg"

if [[ ! -f "$KICKASS" ]]; then
    echo "KickAss.jar not found. Pass the path as the first argument:"
    echo "  ./build.sh /path/to/KickAss.jar"
    exit 1
fi

mkdir -p build

echo "Assembling $SOURCE ..."
java -jar "$KICKASS" "$SOURCE" -o "build/$OUTPUT"
echo "Done → build/$OUTPUT"
