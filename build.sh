#!/usr/bin/env bash
# Assembles and optionally exomizes tribot-plus.
#
# Usage:
#   ./build.sh <command>
#
# Run './build.sh help' for full details.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
KICKASS="${KICKASS:-$REPO_ROOT/tools/KickAss.jar}"
EXOMIZER="${EXOMIZER:-$REPO_ROOT/tools/exomizer}"
BUILD_DIR="$REPO_ROOT/build"
DIST_DIR="$REPO_ROOT/dist"

# ── helpers ────────────────────────────────────────────────────────────────────

usage() {
    cat <<'EOF'
Usage: ./build.sh <command>

Commands:
  build   Assemble tribot-plus.src  →  build/tribot-plus.prg
  dist    Assemble then exomize     →  build/tribot-plus.prg
                                       dist/tribot-plus-exo.prg  (self-extracting)
  help    Show this help

Environment variables (override default tool paths):
  KICKASS    Path to KickAss.jar  (default: tools/KickAss.jar)
  EXOMIZER   Path to exomizer     (default: tools/exomizer)

Examples:
  ./build.sh build
  ./build.sh dist
  KICKASS=/opt/tools/KickAss.jar ./build.sh dist
EOF
}

do_assemble() {
    if [[ ! -f "$KICKASS" ]]; then
        echo "KickAss.jar not found at: $KICKASS"
        echo "Set the KICKASS env var or place the jar at tools/KickAss.jar."
        exit 1
    fi

    mkdir -p "$BUILD_DIR"

    echo "Assembling src/tribot-plus.src ..."
    cd "$REPO_ROOT/src"
    java -jar "$KICKASS" tribot-plus.src -o "$BUILD_DIR/tribot-plus.prg" -showmem

    [[ -f "$REPO_ROOT/src/tribot-plus.sym" ]] && \
        mv "$REPO_ROOT/src/tribot-plus.sym" "$BUILD_DIR/tribot-plus.sym"

    echo "Done → build/tribot-plus.prg"
}

do_exomize() {
    if [[ ! -f "$EXOMIZER" ]]; then
        echo "exomizer not found at: $EXOMIZER"
        echo "Set the EXOMIZER env var or place the binary at tools/exomizer."
        exit 1
    fi

    if [[ ! -f "$BUILD_DIR/tribot-plus.prg" ]]; then
        echo "build/tribot-plus.prg not found — run './build.sh build' first."
        exit 1
    fi

    mkdir -p "$DIST_DIR"

    echo "Exomizing build/tribot-plus.prg ..."
    "$EXOMIZER" sfx sys "$BUILD_DIR/tribot-plus.prg" \
        -o "$DIST_DIR/tribot-plus-exo.prg" -q

    echo "Done → dist/tribot-plus-exo.prg"
}

# ── dispatch ───────────────────────────────────────────────────────────────────

COMMAND="${1:-}"

case "$COMMAND" in
    build)
        do_assemble
        ;;
    dist)
        do_assemble
        do_exomize
        ;;
    help|--help|-h)
        usage
        ;;
    "")
        echo "No command given."
        echo
        usage
        ;;
    *)
        echo "Unknown command: $COMMAND"
        echo
        usage
        exit 1
        ;;
esac
