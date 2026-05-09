# Tribot+

Tribot+ is a text-mode question-and-answer bot for the Commodore 64, developed by Triad. It runs in PETSCII with a custom character set and draws its interface style from modern CLI tools. The database is stored in a 16MB REU image and searched on each query. When no match is found, an Eliza-like engine generates a plausible response to keep the interaction alive.

---

## Requirements

- A Commodore 64 or compatible hardware
- A 16MB RAM Expansion Unit (REU)
- The `tribot-plus.reu` database image
- The `tribot-plus.prg` executable

---

## Setup

Mount the `tribot-plus.reu` image before running the program. Instructions vary by hardware.

**1541U / U2**  
Go to Settings and set REU size to 16MB. Find `tribot-plus.reu` in the file browser and press Return to mount. Then run `tribot-plus.prg`.

**64Ultimate**  
Follow the same steps as 1541U / U2. Enable acceleration for a faster search experience.

**Turbo Chameleon**  
Find `tribot-plus.reu` in the file browser and press Return to mount. Then run `tribot-plus.prg`. Enable Turbo Mode (No Limit) for a faster search experience.

**WinVICE**  
Open Settings → Cartridge/IO Settings → REU Settings. Check "Enable the RAM Expansion Unit". Set REU size to 16384KB. Browse to `tribot-plus.reu` and add it. Then run `tribot-plus.prg`.

**Note:**  
Different firmware versions of the above hardware may slightly change how REU mounting is done.

---

## Usage

Type a question and press Return. Tribot+ searches the database and returns a response. Commands are entered the same way, prefixed with `/`.

| Command           | Description                    |
| ----------------- | ------------------------------ |
| `/help` `/man`    | List all available commands    |
| `/info`           | Show version and introduction  |
| `/clear` `/reset` | Clear the screen               |
| `/exit` `/quit`   | Exit and return to BASIC       |

---

## Building from source

### Requirements

- Java (for KickAssembler)
- `tools/KickAss.jar` — KickAssembler v5.25
- `tools/exomizer` — Exomizer binary (Linux x86-64)

### Commands

```
./build.sh build   Assemble source  →  build/tribot-plus.prg
./build.sh dist    Assemble + crunch →  build/tribot-plus.prg
                                        dist/tribot-plus-exo.prg  (self-extracting)
./build.sh help    Show usage
```

`build` produces a standard PRG loading at $0801. `dist` runs the assembled PRG through Exomizer (`sfx sys`) to produce a self-decrunching PRG — roughly 78% smaller than the uncompressed build.

Tool paths can be overridden via environment variables:

```
KICKASS=/path/to/KickAss.jar ./build.sh build
EXOMIZER=/path/to/exomizer   ./build.sh dist
```

The `build/` and `dist/` directories are tracked in the repository as empty. Their contents are ignored by git.

---

## Documentation

The full technical specification is available in two languages:

- [English](docs/specification/tribot-plus---spec-english.md)
- [Deutsch](docs/specification/tribot-plus---spec-deutsch.md)

Both documents cover visual style, layout, boot sequence, input behavior, execution flow, and response rendering.

---

## Team

- Adder — Code
- Skyhawk — Visual design and user experience
- Bepp — Datamining and support
- Taper — Additional datamining and support