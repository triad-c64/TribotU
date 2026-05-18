# Tribot+ — Implementation & Testing Checklist

Use this document for three purposes:

1. **Implementation Tracking** — developer confirms each feature is built.
2. **Alignment Testing** — tester verifies behavior matches the specification.
3. **Bug & Edge Case Testing** — tester verifies the program handles failure and boundary conditions correctly.

Mark items `[x]` when confirmed. Leave `[ ]` open when not yet done or not yet verified.

---

## Part 1 — Implementation Checklist

> For the developer. Check each item once the feature is coded and compiles correctly.

### Boot Sequence

- [x] [Taper] [2026/05/17] Stage 1: Screen turns black on load
- [ ] [     ] [          ] Stage 1: "Tribot Plus, Triad" text appears
- [ ] [     ] [          ] Stage 1: One blank line between title and "Booting..."
- [ ] [     ] [          ] Stage 1: "Booting..." text appears
- [ ] [     ] [          ] Stage 2: Hardware detection runs and prints results line by line
- [ ] [     ] [          ] Stage 2: REU presence is detected and printed ("REU Detected" / "REU Not found!")
- [ ] [     ] [          ] Stage 2: Additional hardware environment checks follow REU detection
- [x] [Taper] [2026/05/17] Stage 3: Screen clears after hardware checks
- [x] [Taper] [2026/05/17] Stage 3: TRIAD logo is displayed with byline "Dealer Quality Botnet"
- [x] [Taper] [2026/05/17] Stage 3: Screen clears again and shows "Loading..." centered
- [x] [Taper] [2026/05/17] Stage 4: Screen clears when loading is complete
- [x] [Taper] [2026/05/09] Stage 4: Tribot+ logo is displayed
- [x] [Taper] [2026/05/09] Stage 4: Introduction text is displayed
- [x] [Taper] [2026/05/09] Stage 4: Input field is displayed and ready for input

### Visual Style

- [x] [Taper] [2026/05/17] Custom PETSCII charset is active (not default C64 BASIC charset)
- [x] [Taper] [2026/05/17] Charset 1 (Highres_1x1_#8 by Tao/Triad) is implemented
- [ ] [Taper] [2026/05/17] Charset 2 (Highres_1x1_#6 by Tao/Triad) is implemented
- [x] [Taper] [2026/05/17] Charset 1 is the default on program load

### Layout

- [x] [Taper] [2026/05/09] Screen is split into an output area (above divider) and input field (below divider)
- [x] [Taper] [2026/05/17] Output area scrolls vertically
- [x] [Taper] [2026/05/09] Input field is fixed and always visible
- [x] [Taper] [2026/05/09] Divider is present and separates the two areas

### Input Field

- [x] [Taper] [2026/05/09] Prompt prefix `> ` is displayed (greater-than + space)
- [x] [Taper] [2026/05/09] Prefix is static and cannot be edited or deleted
- [x] [Taper] [2026/05/09] Input area is 37 characters wide
- [x] [Taper] [2026/05/09] Total prompt width is 2 characters (prefix occupies columns 1–2)
- [x] [Taper] [2026/05/09] Divider is colored dark grey
- [x] [Taper] [2026/05/17] Prompt `>` is colored medium grey
- [ ] [     ] [2026/05/17] Placeholder text is colored dark grey
- [ ] [     ] [          ] User input text is colored yellow
- [ ] [     ] [          ] Placeholder "Ask me anything..." is shown on first launch only
- [ ] [     ] [          ] Placeholder disappears when the user begins typing
- [ ] [     ] [          ] Placeholder is not shown again after the first question is submitted

### Input Behavior

- [x] [Taper] [2026/05/09] Input is capped at 37 characters
- [x] [Taper] [2026/05/09] No further characters are accepted once the 37-character limit is reached

### Scrollback

- [x] [Taper] [2026/05/17] F1 scrolls the output area back by 1 line
- [x] [Taper] [2026/05/17] F7 scrolls the output area forward by 1 line
- [ ] [     ] [          ] Holding F1 scrolls continuously in 1-line steps until released or boundary reached
- [ ] [     ] [          ] Holding F7 scrolls continuously in 12-line steps until released or boundary reached
- [x] [Taper] [2026/05/17] Submitting a new question while scrolled back jumps the view to the latest output before appending

### Execution Flow

- [x] [Taper] [2026/05/17] Submitted input is echoed to the output area with `> ` prefix
- [x] [Taper] [2026/05/17] A `?` is appended to echoed input when the submission is a question
- [x] [Taper] [2026/05/17] Command detection checks for `/` prefix on submit
- [ ] [     ] [          ] Recognized commands execute immediately with no database lookup
- [x] [Taper] [2026/05/17] Non-command input is treated as a question and passed to the database
- [x] [Taper] [2026/05/17] A database match returns the matched result as the response
- [x] [Taper] [2026/05/17] No database match activates the bogus answer engine
- [x] [Taper] [2026/05/17] Bogus answer engine generates a plausible, syntactically correct response
- [x] [Taper] [2026/05/17] The system processes one task at a time (single-task queue)

### System Feedback

- [x] [Taper] [2026/05/17] An animated indicator appears left of the status message during processing
- [x] [Taper] [2026/05/17] Status message is picked at random from the defined set of 25 messages
- [x] [Taper] [2026/05/17] All 25 messages are present in the message pool:
  - [x] [Taper] [2026/05/17] Cogitating...
  - [x] [Taper] [2026/05/17] Contemplating...
  - [x] [Taper] [2026/05/17] Deliberating...
  - [x] [Taper] [2026/05/17] Ruminating...
  - [x] [Taper] [2026/05/17] Pondering...
  - [x] [Taper] [2026/05/17] Mulling...
  - [x] [Taper] [2026/05/17] Musing...
  - [x] [Taper] [2026/05/17] Percolating...
  - [x] [Taper] [2026/05/17] Noodling...
  - [x] [Taper] [2026/05/17] Simmering...
  - [x] [Taper] [2026/05/17] Marinating...
  - [x] [Taper] [2026/05/17] Incubating...
  - [x] [Taper] [2026/05/17] Concocting...
  - [x] [Taper] [2026/05/17] Scheming...
  - [x] [Taper] [2026/05/17] Hatching...
  - [x] [Taper] [2026/05/17] Brewing...
  - [x] [Taper] [2026/05/17] Calculating...
  - [x] [Taper] [2026/05/17] Computing...
  - [x] [Taper] [2026/05/17] Churning...
  - [x] [Taper] [2026/05/17] Crunching...
  - [x] [Taper] [2026/05/17] Coalescing...
  - [x] [Taper] [2026/05/17] Deciphering...
  - [x] [Taper] [2026/05/17] Germinating...
  - [x] [Taper] [2026/05/17] Manifesting...
  - [x] [Taper] [2026/05/17] Reticulating...

### Output Area

- [x] [Taper] [2026/05/17] Questions, commands, and responses all appear in the output area
- [x] [Taper] [2026/05/17] Entries appear top to bottom in chronological order
- [x] [Taper] [2026/05/17] New entries append to the bottom
- [x] [Taper] [2026/05/17] View scrolls automatically to show the latest output

### Response Formatting

- [x] [Taper] [2026/05/17] Responses are plain text only (no headers, no lists rendered)
- [x] [Taper] [2026/05/17] Long responses wrap within the 40-character screen width

### Response Color Behavior

- [x] [Taper] [2026/05/17] The response is white
- [ ] [     ] [          ] Keyword highlighting applies to the response only
- [ ] [     ] [          ] Keywords are extracted from the user's question using exact match
- [ ] [     ] [          ] Common stop words are excluded before keyword matching
- [ ] [     ] [          ] Each keyword match in the final response is colored yellow

### Music

- [x] [Taper] [2026/05/17] SID music plays by default when the program is ready for input
- [x] [Taper] [2026/05/17] Music resets to on each time the program loads
- [x] [Taper] [2026/05/17] Default tune is tune 1 on each program load
- [x] [Taper] [2026/05/17] `/music` command toggles playback on and off immediately
- [x] [Taper] [2026/05/17] `/tune 1` switches to tune 1 immediately
- [x] [Taper] [2026/05/17] `/tune 2` switches to tune 2 immediately
- [x] [Taper] [2026/05/17] Toggling music off stops playback immediately
- [x] [Taper] [2026/05/17] Toggling music on resumes the last selected tune

### Commands

- [x] [Taper] [2026/05/17] `/clear` clears the screen and purges the scrollback buffer
- [ ] [     ][          ] `/reset` clears the screen and purges the scrollback buffer (alias for `/clear`)
- [x] [Taper] [[2026/05/17] `/exit` exits Tribot+ and returns to BASIC (warm reset)
- [ ] [     ] [          ] `/quit` exits Tribot+ and returns to BASIC (alias for `/exit`)
- [x] [Taper] [2026/05/17] `/help` displays a list of all available commands with aliases and descriptions
- [x] [Taper] [2026/05/17] `/man` displays a list of all available commands (alias for `/help`)
- [x] [Taper] [2026/05/17] `/info` displays the Tribot+ logo, short introduction, and technical version details
- [x] [Taper] [2026/05/17] `/info` output mentions `/help` and `/man` for available commands
- [x] [Taper] [2026/05/17] `/music` toggles music on/off
- [ ] [     ] [          ] `/tunes` List tunes and composer
- [x] [Taper] [2026/05/17] `/tune X` selects tune
- [x] [Taper] [2026/05/17] `/char 1` switches to charset 1 immediately
- [ ] [     ] [          ] `/char 2` switches to charset 2 immediately

---

## Part 2 — Feature Alignment Test Checklist

> For the tester. Verify that each implemented feature behaves exactly as the specification describes. Test on real hardware or accurate emulation.

### Boot Sequence

- [ ] [     ] [          ] On load: screen turns black before any output appears
- [ ] [     ] [          ] "Tribot Plus, Triad" is the first text shown, with correct capitalization
- [ ] [     ] [          ] Exactly one blank line separates the title from "Booting..."
- [ ] [     ] [          ] Hardware check results print one line at a time as each check completes
- [ ] [     ] [          ] "REU Detected" appears when REU is mounted
- [ ] [     ] [          ] "REU Not found!" appears when REU is not mounted
- [x] [Taper] [2026/05/17] TRIAD logo renders correctly after hardware checks clear the screen
- [x] [Taper] [2026/05/17] "Dealer Quality Botnet" byline appears below the TRIAD logo
- [x] [Taper] [2026/05/17] "Loading..." message is visually centered on the screen
- [ ] [     ] [          ] Add delay to the boot sequence.
- [x] [Taper] [2026/05/17] Final screen shows: logo, introduction text, and the input field in correct positions

### Layout & Display

- [x] [Taper] [2026/05/17] Output area occupies the region above the divider
- [x] [Taper] [2026/05/17] Input field occupies the region below the divider
- [x] [Taper] [2026/05/17] Divider is visually distinct between the two areas
- [x] [Taper] [2026/05/17] Screen is 40 characters wide and 25 lines tall as expected on C64
- [x] [Taper] [2026/05/17] Custom charset is active — default C64 BASIC characters are not visible

### Input Field

- [x] [Taper] [2026/05/17] Prompt `> ` appears at the start of the input line with correct spacing
- [x] [Taper] [2026/05/17] Pressing Backspace or Delete to the prompt boundary does not remove the prefix
- [ ] [     ] [          ] Placeholder "Ask me anything..." is visible before the first keystroke
- [ ] [     ] [          ] Placeholder disappears as soon as the user presses any character key
- [ ] [     ] [          ] After the first question is submitted, the placeholder does not reappear
- [ ] [     ] [          ] Text typed by the user is yellow
- [x] [Taper] [2026/05/17] Prompt `>` is medium grey
- [ ] [     ] [          ] Placeholder text is dark grey
- [x] [Taper] [2026/05/17] Divider is dark grey

### Input Behavior

- [x] [Taper] [2026/05/17] Typing stops at character 37 — the 38th character is not accepted
- [x] [Taper] [2026/05/17] No visual or auditory glitch occurs when the character limit is reached
- [x] [Taper] [2026/05/17] Backspace correctly removes the last typed character

### Scrollback

- [x] [Taper] [2026/05/17] F1 moves the output view back exactly 1 lines per press
- [x] [Taper] [2026/05/17] F7 moves the output view forward exactly 1 lines per press
- [x] [Taper] [2026/05/17] F1 at the top boundary stops scrolling (no wrap-around or error)
- [x] [Taper] [2026/05/17] F7 at the bottom boundary stops scrolling (no wrap-around or error)
- [ ] [     ] [          ] Holding F1 produces continuous backward scrolling
- [ ] [     ] [          ] Holding F7 produces continuous forward scrolling
- [x] [Taper] [2026/05/17] Submitting a new question while scrolled back: view jumps to latest output, then new response appends

### Command Handling

- [x] [Taper] [2026/05/17] `/clear` clears the screen immediately and purges the scrollback buffer (no logo or intro text restored)
- [ ] [     ] [          ] `/reset` produces identical behavior to `/clear` — screen and scrollback both cleared
- [x] [Taper] [2026/05/17] `/exit` returns to BASIC prompt without crashing
- [ ] [     ] [          ] `/quit` produces identical behavior to `/exit`
- [x] [Taper] [2026/05/17] `/help` output lists every command, every alias, and a description for each
- [x] [Taper] [2026/05/17] `/man` produces identical output to `/help`
- [x] [Taper] [2026/05/17] `/info` shows logo, introduction, and version information
- [x] [Taper] [2026/05/17] `/info` mentions `/help` and `/man` by name
- [x] [Taper] [2026/05/17] `/music` visibly toggles music: off when playing, on when stopped
- [ ] [     ] [          ] `/tunes` List tunes and composer
- [x] [Taper] [2026/05/17] `/tune 1` through `/tune 2` each switch to the correct tune immediately
- [ ] [     ] [          ] `/char 1` switches to charset 1 immediately with no screen corruption
- [ ] [     ] [          ] `/char 2` switches to charset 2 immediately with no screen corruption

### Question Handling

- [x] [Taper] [2026/05/17] A recognized question returns a database result
- [x] [Taper] [2026/05/17] A question with no database match receives a bogus answer (not silence, not an error)
- [x] [Taper] [2026/05/17] Bogus answers read as plausible sentences
- [x] [Taper] [2026/05/17] A `?` is appended to the echoed question in the output area
- [x] [Taper] [2026/05/17] Commands are NOT passed to the database — they execute directly

### System Feedback

- [x] [Taper] [2026/05/17] The animated indicator is visible to the left of the status message during processing
- [x] [Taper] [2026/05/17] The status message text changes across multiple queries (randomness is observable)

### Output Area & Formatting

- [x] [Taper] [2026/05/17] Lines longer than 40 characters wrap cleanly at the column boundary
- [x] [Taper] [2026/05/17] No stray characters or rendering artifacts appear on word-wrapped lines
- [x] [Taper] [2026/05/17] Output appends to the bottom and the view follows automatically

### Response Color Behavior

- [x] [Taper] [2026/05/17] The response is white
- [ ] [     ] [          ] Keyword highlighting is yellow and appears only in the final response
- [x] [Taper] [2026/05/17] Common stop words (e.g., "the", "is", "a") are not highlighted
- [ ] [     ] [          ] Older responses have no highlighting

### Music

- [x] [Taper] [2026/05/17] Music starts automatically when the program reaches the ready state
- [x] [Taper] [2026/05/17] `/music` stops playback immediately when music is on
- [x] [Taper] [2026/05/17] `/music` resumes the last selected tune immediately when music is off
- [x] [Taper] [2026/05/17] `/tune X` switches tune without interruption when music is already playing
- [x] [Taper] [2026/05/17] After `/tune X` then `/music` off then `/music` on: the tune selected by `/tune X` resumes
- [x] [Taper] [2026/05/17] On fresh program load: music is on and tune 1 is playing (settings have reset)

### Charset

- [x] [Taper] [2026/05/17] On fresh program load: charset 1 is active
- [ ] [     ] [          ] `/char 2` switches the visible charset to charset 2
- [ ] [     ] [          ] `/char 1` switches back to charset 1
- [x] [Taper] [2026/05/17] After a `/char 2` session and a fresh program load: charset 1 is active again (reset confirmed)

---

## Part 3 — Bug & Edge Case Test Checklist

> For the tester. Verify the program handles boundary conditions, invalid input, and hardware variation correctly.

### Boot / Hardware

- [x] [Taper] [2026/05/17] Program boots correctly with REU mounted (16MB)
- [x] [Taper] [2026/05/17] Program boots without crash when REU is not mounted — "REU Not found!" appears, but if you mount REU it continues.
- [x] [Taper] [2026/05/17] Program does not hang at any boot stage
- [ ] [     ] [          ] Boot sequence completes in a reasonable time on stock C64 hardware
- [ ] [     ] [          ] Boot sequence completes correctly under 1541U / U2 with REU
- [ ] [     ] [          ] Boot sequence completes correctly under 64Ultimate with REU
- [ ] [     ] [          ] Boot sequence completes correctly under Turbo Chameleon with REU
- [ ] [     ] [          ] Boot sequence completes correctly under WinVICE with REU configured

### Input Field Edge Cases

- [x] [Taper] [2026/05/17] Pressing Return on an empty input field does nothing (no crash, no empty entry in output)
- [ ] [     ] [          ] Pressing Return on input that is only spaces does nothing (or is treated as empty)
- [x] [Taper] [2026/05/17] Typing exactly 37 characters fills the field without overflow
- [x] [Taper] [2026/05/17] Typing exactly 37 characters then pressing Return submits correctly
- [x] [Taper] [2026/05/17] Pressing Backspace on an empty input field does not remove the prompt prefix

### Command Edge Cases

- [ ] [     ] [          ] Unknown command (e.g., `/foo`) produces a graceful response — no crash
- [ ] [     ] [          ] `/tune 0` is rejected or produces a graceful error (out of range)
- [ ] [     ] [          ] `/tune 3` is rejected or produces a graceful error (out of range)
- [ ] [     ] [          ] `/char 0` is rejected or produces a graceful error (out of range)
- [ ] [     ] [          ] `/char 3` is rejected or produces a graceful error (out of range)
- [ ] [     ] [          ] A command typed with trailing spaces (e.g., `/clear `) behaves correctly
- [ ] [     ] [          ] A `/` with no command word (just a slash) produces a graceful response

### Scrollback Edge Cases

- [X] [Taper] 2026/05/17] F1 pressed when already at the top of output does not crash or corrupt the screen
- [X] [Taper] [2026/05/17] F7 pressed when already at the bottom of output does not crash or corrupt the screen
- [X] [Taper] [2026/05/17] F1/F7 used when the output area has fewer than 12 lines of content scrolls to boundary correctly
- [X] [Taper] [2026/05/17] Scrollback state resets correctly after a new question is submitted

### Response Display Edge Cases

- [X] [Taper] [2026/05/17] A response that exactly fills 40 characters per line wraps correctly to the next line
- [X] [Taper] [2026/05/17] A response longer than the visible output area height is scrollable via F1/F7
- [ ] [     ] [          ] Keyword highlighting works correctly when the matched word appears multiple times in the response
- [ ] [     ] [          ] No highlighting artifacts appear in superseded responses

### Music Edge Cases

- [ ] [     ] [          ] `/music` pressed repeatedly in quick succession does not crash or desync audio
- [ ] [     ] [          ] `/tune X` called when music is off: music remains off, but correct tune queued for when music is toggled back on
- [ ] [     ] [          ] Switching tunes rapidly (tune 1 → tune 2) does not produce audio glitches or crashes

### Charset Edge Cases

- [ ] [     ] [          ] Switching charset while text is on screen: existing output re-renders correctly in the new charset
- [ ] [     ] [          ] Switching charset while a response is being written to the screen does not corrupt output
- [ ] [     ] [          ] Switching between charset 1 and charset 2 multiple times in a session produces no persistent artifacts

### General Stability

- [X] [Taper] [2026/05/17] Program runs for an extended session (10+ queries) without memory corruption or visual glitches
- [x] [Taper] [2026/05/17] Program returns cleanly to BASIC on `/exit` or `/quit` with no leftover state
- [ ] [     ] [          ] No screen corruption occurs after `/clear` or `/reset`
- [X] [Taper] [2026/05/17] After `/clear` or `/reset`, F1 and F7 produce no movement (scrollback is empty)
- [X] [Taper] [2026/05/17] After `/clear` or `/reset`, new output starts fresh with no remnants from the previous scrollback
- [X] [Taper] [2026/05/17] Bogus answer engine never returns an empty string
- [X] [Taper] [2026/05/17] Bogus answer engine never produces a crash or hang