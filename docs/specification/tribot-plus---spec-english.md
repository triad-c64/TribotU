# Tribot+

High-level specification covering visual style, layout, input behavior, and commands.

**Team:**
- Adder - Code
- Skyhawk - Visual design and user experience
- Bepp - Datamining and support
- Taper - Additional datamining and support

---

## Overview

Tribot+ runs in text mode using PETSCII with a custom character set. This distinguishes it from the default C64 BASIC look, reduces memory usage, and improves rendering performance.

The interface draws from modern CLI tools such as Claude Code.

---

## Visual Style

### Character Set

- Custom PETSCII font

### Tools

- C64 Charset Minion v0.8 Beta on [CSDB](https://csdb.dk/release/?id=137527)

---

## Layout

The screen is divided into two areas:

| Area        | Position      | Behavior              |
| ----------- | ------------- | --------------------- |
| Output area | Above divider | Scrolls vertically    |
| Input field | Below divider | Fixed, always visible |

---

## Boot Sequence

The boot sequence runs once when the `tribot-plus.prg` file is loaded. It progresses through four stages before the program is ready for input.

### Prerequisites

Tribot+ requires a 16MB REU image (`tribot-plus.reu`) to be mounted before launching the `tribot-plus.prg` file. Mount instructions vary by hardware:

**1541U / U2**
Go to Settings and set REU size to 16MB. Find `tribot-plus.reu` in the file browser and press Return to mount. Then run `tribot-plus.prg`.

**64Ultimate**
Follow the same steps as 1541U / U2. Enable acceleration for a faster search experience.

**Turbo Chameleon**
Find `tribot-plus.reu` in the file browser and press Return to mount. Then run `tribot-plus.prg`. Enable Turbo Mode (No Limit) for a faster search experience.

**WinVICE**
Open Settings → Cartridge/IO Settings → REU Settings. Check "Enable the RAM Expansion Unit". Set REU size to 16384KB. Browse to `tribot-plus.reu` and add it. Then run `tribot-plus.prg`.

Note: Different firmware versions of the above hardware may slightly change how REU mounting is done.

### Stage 1 — Initial Screen

The screen turns black. The following text appears:

    Tribot Plus, Triad

One blank line follows, then:

    Booting...

### Stage 2 — Hardware Detection

System checks run and results are printed line by line as they complete. Each line states the outcome of a single check.

Examples:

    - REU Detected
    - REU Not found!

If an REU is detected, additional checks follow to identify the hardware environment, for example whether the system is a stock Commodore 64 or an Ultimate 64. Further checks and technical details to be defined by Taper.

### Stage 3 — Logo Screens

Once all hardware checks are complete, the screen clears and the TRIAD logo is displayed with the byline:

    Dealer Quality Botnet

The screen then clears again and shows a centrally placed loading message:

    Loading...

### Stage 4 — Ready

When loading is complete, the screen clears and displays:

- The Tribot+ logo
- The introduction text
- The input field

The program is ready for input.

---

## Input Field

The input field is fixed at the bottom of the screen.

### Prompt

- Prefix: `> ` (greater-than sign + space)
- Width: 2 characters
- Remaining width: 38 characters for user input
- The prefix is static and cannot be edited

### Colors

| Element     | Color       |
| ----------- | ----------- |
| Divider     | Dark grey   |
| Prompt `>`  | Medium grey |
| Placeholder | Dark grey   |
| User input  | Yellow      |

### Placeholder

Shown on first launch only, before the user has submitted any input.

Default text: **"Ask me anything..."**

Disappears when the user begins typing. Not shown again after the first question is submitted.

---

## Input Constraints

- Screen width: 40 characters
- Prompt: 2 characters
- Input area: 38 characters

---

## Input Behavior

When input reaches 38 characters, input stops. No further characters are accepted.

---

## Scrollback

The output area supports scrollback navigation using the function keys.

| Key | Action                  |
| --- | ----------------------- |
| F1  | Scroll back 12 lines    |
| F7  | Scroll forward 12 lines |

Each key press scrolls the output area by 12 lines, half of the 25-line screen height. This gives a stepped feel consistent with CLI scrollback behavior. Repeated presses of F1 scroll back to the first output. Repeated presses of F7 scroll forward to the last output.

Holding F1 or F7 scrolls continuously in 12-line increments until the key is released or the boundary of the output is reached.

When the user submits a new question while scrolled back, the output area jumps to the last output before appending the new response. Scrollback position does not affect input or execution.

---

## Execution Flow

The input field accepts questions and commands.

### Submission

On submit, the input moves to the output area with a prompt prefix:

    > user command
    > user question?

A `?` is appended when input is a question.

### Command Detection

On submit, Tribot+ first checks whether the input is a command. A command is identified by a `/` prefix. If a command is recognized, it executes immediately. No database lookup is performed.

### Question Handling

If no command is detected, Tribot+ treats the input as a question and searches the database for a match.

- If a match is found, the result is returned as the response.
- If no match is found, the input is passed to the bogus answer engine.

### Bogus Answer Engine

The bogus answer engine activates when no database match is found. It uses an Eliza-like engine to generate a response that is syntactically correct and sounds plausible, but is not sourced from the database. Its purpose is to avoid dead ends and keep the interaction alive.

### Queue

- The system processes one task at a time.
- Input entered during processing is queued and executed in order.

---

## System Feedback

While processing, an animated indicator appears left of a status message. The message is picked at random from the set below.

    Cogitating...
    Contemplating...
    Deliberating...
    Ruminating...
    Pondering...
    Mulling...
    Musing...
    Percolating...
    Noodling...
    Simmering...
    Marinating...
    Incubating...
    Concocting...
    Scheming...
    Hatching...
    Brewing...
    Calculating...
    Computing...
    Churning...
    Crunching...
    Coalescing...
    Deciphering...
    Germinating...
    Manifesting...
    Reticulating...

---

## Output Area

- Displays questions, commands, and responses.
- Entries appear top to bottom.
- New entries append to the bottom.
- View scrolls automatically.

---

## Response Formatting

Responses are plain text only. No headers or lists are rendered. Long responses wrap to the next line within the 40-character screen width.

---

## Response Color Behavior

Responses move through states as new content arrives.

| State      | Color     | Condition                            |
| ---------- | --------- | ------------------------------------ |
| Current    | White     | The most recently displayed response |
| Superseded | Dark grey | A newer response has scrolled in     |
| Final      | White     | No further responses follow          |

### State Transitions

1. A response appears at the bottom of the output area in white.
2. When a new response is appended, the previous response scrolls upward and fades through the following sequence as it moves:
    - Light grey
    - Medium grey
    - Dark grey
3. This repeats for each subsequent response.
4. The final response remains white.

### Keyword Highlighting

- Applies to the final response only.
- Keywords are extracted from the user's question using exact match.
- Common stop words (e.g. "the", "is", "a") are excluded before matching.
- Each match in the final response is colored yellow.
- Superseded responses carry no highlighting.

---

## Music

Tribot+ plays SID music during normal use. Music is on by default and resets to on each time the program loads.

### Commands

Music is controlled via two commands:

    /music        Toggle music on / off
    /tune 1-4     Select tune (1, 2, 3 or 4)

### Behavior

- Music starts when the program is ready for input.
- `/music` toggles playback on and off immediately.
- `/tune X` switches to the selected tune immediately.
- Toggling music off stops playback immediately.
- Toggling music on resumes the last selected tune.
- Settings reset to default on each program load: music on, tune 1.

### Tunes

| Number | Title      | Author       |
| ------ | ---------- | ------------ |
| 1      | Tune one   | Author one   |
| 2      | Tune two   | Author two   |
| 3      | Tune three | Author three |
| 4      | Tune four  | Author four  |

Tune titles are placeholders and will be updated once SID files are selected.

---

## Charset

Tribot+ supports two custom character sets. Charset 1 is active by default and resets to charset 1 each time the program loads.

### Commands

The character set is controlled via one command:

    /char 1-2     Select charset (1 or 2)

### Behavior

- `/char X` switches to the selected charset immediately.
- Settings reset to default on each program load: charset 1.

### Charsets

| Number | Name           | Author    |
| ------ | -------------- | --------- |
| 1      | Highres_1x1_#8 | Tao/Triad |
| 2      | Highres_1x1_#6 | Tao/Triad |

Charset names are placeholders and will be updated once charsets are finalized.

---

## Commands

Commands use the same input field as questions. All commands require a `/` prefix.

### Reset

Clears the screen. No logo or text is restored.

    /clear | /reset

### Exit

Exits Tribot+ and returns to BASIC (warm reset).

    /exit | /quit

### Help

Displays a list of all available commands. Each entry shows the full command, its alias, and a brief description of what it does.

    /help | /man

### Info

Displays the Tribot+ logo, a short introduction, and technical details about the current version. Mentions `/help` and `/man` for available commands.

    /info

### Music

Toggles music on and off.

    /music

### Tune

Selects one of four available tunes. Replace X with a number between 1 and 4.

    /tune X

### Charset

Selects one of two available character sets. Replace X with 1 or 2.

    /char X

---

## Open Points

- Define what qualifies as a database match - Adder, Taper and Bepp
- Define hardware checks and technical details for Stage 2 - Taper
- Select SID files and confirm tune titles - Taper