#!/usr/bin/env bash
# Build process tests for Tribot+.
#
# Usage:
#   ./test.sh
#
# All tests run from the repository root. Exit code is 0 on full pass, 1 on
# any failure.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
PASS=0
FAIL=0

# ── helpers ──────────────────────────────────────────────────────────────────

green() { printf '\033[0;32m'; }
red()   { printf '\033[0;31m'; }
reset() { printf '\033[0m'; }

ok() {
    green; printf "  PASS"; reset; echo "  $1"
    (( PASS++ )) || true
}

fail() {
    red; printf "  FAIL"; reset; echo "  $1"
    (( FAIL++ )) || true
}

assert_exit_ok()   { [[ $1 -eq 0 ]]  && ok "$2"   || fail "$2"; }
assert_exit_fail() { [[ $1 -ne 0 ]]  && ok "$2"   || fail "$2"; }
assert_exists()    { [[ -e "$1"   ]]  && ok "$2"   || fail "$2"; }
assert_not_exists(){ [[ ! -e "$1" ]]  && ok "$2"   || fail "$2"; }
assert_min_size()  {
    local bytes
    bytes=$(wc -c < "$1" 2>/dev/null || echo 0)
    [[ $bytes -ge $2 ]] && ok "$3" || fail "$3 (got ${bytes}B, want >=${2}B)"
}
assert_contains()  { echo "$1" | grep -qF "$2" && ok "$3" || fail "$3"; }

# ── setup ────────────────────────────────────────────────────────────────────

cd "$REPO_ROOT"

# ── 1. Source layout ─────────────────────────────────────────────────────────

echo
echo "Source layout"

assert_exists "src/tribot-plus.src"  "src/tribot-plus.src present"
assert_exists "src/variables.src"    "src/variables.src present"
assert_exists "src/math.src"         "src/math.src present"
assert_exists "src/keyboard.src"     "src/keyboard.src present"
assert_exists "src/embedder.src"     "src/embedder.src present"
assert_exists "src/tokenize.src"     "src/tokenize.src present"
assert_exists "src/extract.src"      "src/extract.src present"
assert_exists "src/eliza.src"        "src/eliza.src present"
assert_exists "src/hash16.src"       "src/hash16.src present"

assert_not_exists "keyboard_best.src" "keyboard_best.src not at repo root"

# ── 2. Required assets ───────────────────────────────────────────────────────

echo
echo "Required assets"

assert_exists "data/lookup_tables.bin"  "data/lookup_tables.bin present"
assert_min_size "data/lookup_tables.bin" 1 "lookup_tables.bin non-empty"

assert_exists "tools/KickAss.jar"  "tools/KickAss.jar present"
assert_min_size "tools/KickAss.jar" 100000 "KickAss.jar looks like a real jar (>=100KB)"

# ── 3. Build script ──────────────────────────────────────────────────────────

echo
echo "Build script"

assert_exists "build.sh" "build.sh present"
[[ -x "build.sh" ]] && ok "build.sh is executable" || fail "build.sh is not executable"

# Missing jar → non-zero exit
OUT=$(bash build.sh /nonexistent/KickAss.jar 2>&1)
assert_exit_fail $? "build.sh exits non-zero when jar not found"
assert_contains "$OUT" "not found" "build.sh prints helpful error for missing jar"

# ── 4. Full assembly ─────────────────────────────────────────────────────────

echo
echo "Full assembly"

rm -rf build/
OUT=$(bash build.sh 2>&1)
BUILD_STATUS=$?

assert_exit_ok $BUILD_STATUS "build.sh exits 0"
assert_contains "$OUT" "Done →" "build.sh reports success"
assert_exists "build/tribot-plus.prg" "tribot-plus.prg created in build/"
assert_min_size "build/tribot-plus.prg" 8192 "tribot-plus.prg is at least 8KB"

# Verify the PRG has the correct C64 load address in the first two bytes ($08, $01 = $0801).
LOAD_LO=$(xxd -p -l 1 build/tribot-plus.prg | tr '[:lower:]' '[:upper:]')
LOAD_HI=$(xxd -p -s 1 -l 1 build/tribot-plus.prg | tr '[:lower:]' '[:upper:]')
[[ "$LOAD_LO" == "01" && "$LOAD_HI" == "08" ]] \
    && ok "PRG load address is \$0801 (BASIC upstart)" \
    || fail "PRG load address mismatch: expected 01 08, got $LOAD_LO $LOAD_HI"

# No stray build artifacts left outside build/.
assert_not_exists "src/tribot-plus.sym" "no stray .sym in src/"
assert_not_exists "tribot-plus.prg"     "no stray .prg at repo root"

# ── 5. Memory map sanity ─────────────────────────────────────────────────────
#
# KickAssembler prints segment names in its output.  Cross-check that the
# expected segments are all present.

echo
echo "Memory map"

SEGMENTS=("Basic Upstart" "Embedder" "TOKENIZEER" "HASH16" "TRIBOT ULTIMATE"
          "STRING_FUNCTION" "KEYBOARD" "Math" "ELIZA")
for SEG in "${SEGMENTS[@]}"; do
    assert_contains "$OUT" "$SEG" "segment '$SEG' assembled"
done

# ── summary ──────────────────────────────────────────────────────────────────

echo
TOTAL=$(( PASS + FAIL ))
if [[ $FAIL -eq 0 ]]; then
    green; echo "All $TOTAL tests passed."; reset
    exit 0
else
    red; echo "$FAIL/$TOTAL tests failed."; reset
    exit 1
fi
