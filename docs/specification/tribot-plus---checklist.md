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

- [ ] Stage 1: Screen turns black on load
- [ ] Stage 1: "Tribot Plus, Triad" text appears
- [ ] Stage 1: One blank line between title and "Booting..."
- [ ] Stage 1: "Booting..." text appears
- [ ] Stage 2: Hardware detection runs and prints results line by line
- [ ] Stage 2: REU presence is detected and printed ("REU Detected" / "REU Not found!")
- [ ] Stage 2: Additional hardware environment checks follow REU detection
- [ ] Stage 3: Screen clears after hardware checks
- [ ] Stage 3: TRIAD logo is displayed with byline "Dealer Quality Botnet"
- [ ] Stage 3: Screen clears again and shows "Loading..." centered
- [ ] Stage 4: Screen clears when loading is complete
- [X] Stage 4: Tribot+ logo is displayed
- [X] Stage 4: Introduction text is displayed
- [X] Stage 4: Input field is displayed and ready for input

### Visual Style

- [ ] Custom PETSCII character set is active (not default C64 BASIC charset)
- [ ] Charset 1 (Highres_1x1_#8 by Tao/Triad) is implemented
- [ ] Charset 2 (Highres_1x1_#6 by Tao/Triad) is implemented
- [ ] Charset 1 is the default on program load

### Layout

- [X] Screen is split into an output area (above divider) and input field (below divider)
- [ ] Output area scrolls vertically
- [X] Input field is fixed and always visible
- [X] Divider is present and separates the two areas

### Input Field

- [X] Prompt prefix `> ` is displayed (greater-than + space)
- [X] Prefix is static and cannot be edited or deleted
- [X] Input area is 37 characters wide
- [X] Total prompt width is 2 characters (prefix occupies columns 1–2)
- [X] Divider is colored dark grey
- [ ] Prompt `>` is colored medium grey
- [ ] Placeholder text is colored dark grey
- [ ] User input text is colored yellow
- [ ] Placeholder "Ask me anything..." is shown on first launch only
- [ ] Placeholder disappears when the user begins typing
- [ ] Placeholder is not shown again after the first question is submitted

### Input Behavior

- [X] Input is capped at 37 characters
- [X] No further characters are accepted once the 37-character limit is reached

### Scrollback

- [ ] F1 scrolls the output area back by 12 lines
- [ ] F7 scrolls the output area forward by 12 lines
- [ ] Repeated F1 presses scroll back to the first output line
- [ ] Repeated F7 presses scroll forward to the last output line
- [ ] Holding F1 scrolls continuously in 12-line steps until released or boundary reached
- [ ] Holding F7 scrolls continuously in 12-line steps until released or boundary reached
- [ ] Submitting a new question while scrolled back jumps the view to the latest output before appending

### Execution Flow

- [ ] Submitted input is echoed to the output area with `> ` prefix
- [ ] A `?` is appended to echoed input when the submission is a question
- [ ] Command detection checks for `/` prefix on submit
- [ ] Recognized commands execute immediately with no database lookup
- [ ] Non-command input is treated as a question and passed to the database
- [ ] A database match returns the matched result as the response
- [ ] No database match activates the bogus answer engine
- [ ] Bogus answer engine generates a plausible, syntactically correct response
- [ ] The system processes one task at a time (single-task queue)
- [ ] Input entered during processing is queued and executed in order

### System Feedback

- [ ] An animated indicator appears left of the status message during processing
- [ ] Status message is picked at random from the defined set of 25 messages
- [ ] All 25 messages are present in the message pool:
  - [ ] Cogitating...
  - [ ] Contemplating...
  - [ ] Deliberating...
  - [ ] Ruminating...
  - [ ] Pondering...
  - [ ] Mulling...
  - [ ] Musing...
  - [ ] Percolating...
  - [ ] Noodling...
  - [ ] Simmering...
  - [ ] Marinating...
  - [ ] Incubating...
  - [ ] Concocting...
  - [ ] Scheming...
  - [ ] Hatching...
  - [ ] Brewing...
  - [ ] Calculating...
  - [ ] Computing...
  - [ ] Churning...
  - [ ] Crunching...
  - [ ] Coalescing...
  - [ ] Deciphering...
  - [ ] Germinating...
  - [ ] Manifesting...
  - [ ] Reticulating...

### Output Area

- [ ] Questions, commands, and responses all appear in the output area
- [ ] Entries appear top to bottom in chronological order
- [ ] New entries append to the bottom
- [ ] View scrolls automatically to show the latest output

### Response Formatting

- [ ] Responses are plain text only (no headers, no lists rendered)
- [ ] Long responses wrap within the 40-character screen width

### Response Color Behavior

- [ ] The most recently displayed response appears in white
- [ ] When a new response arrives, the previous response fades: white → light grey → medium grey → dark grey
- [ ] The fade sequence progresses as the response moves upward through the output area
- [ ] The final response (last one, no newer follows) remains white
- [ ] Keyword highlighting applies to the final response only
- [ ] Keywords are extracted from the user's question using exact match
- [ ] Common stop words are excluded before keyword matching
- [ ] Each keyword match in the final response is colored yellow
- [ ] Superseded responses carry no keyword highlighting

### Music

- [ ] SID music plays by default when the program is ready for input
- [ ] Music resets to on each time the program loads
- [ ] Default tune is tune 1 on each program load
- [ ] `/music` command toggles playback on and off immediately
- [ ] `/tune 1` switches to tune 1 immediately
- [ ] `/tune 2` switches to tune 2 immediately
- [ ] `/tune 3` switches to tune 3 immediately
- [ ] `/tune 4` switches to tune 4 immediately
- [ ] Toggling music off stops playback immediately
- [ ] Toggling music on resumes the last selected tune

### Commands

- [ ] `/clear` clears the screen and purges the scrollback buffer
- [ ] `/reset` clears the screen and purges the scrollback buffer (alias for `/clear`)
- [ ] `/exit` exits Tribot+ and returns to BASIC (warm reset)
- [ ] `/quit` exits Tribot+ and returns to BASIC (alias for `/exit`)
- [ ] `/help` displays a list of all available commands with aliases and descriptions
- [ ] `/man` displays a list of all available commands (alias for `/help`)
- [ ] `/info` displays the Tribot+ logo, short introduction, and technical version details
- [ ] `/info` output mentions `/help` and `/man` for available commands
- [ ] `/music` toggles music on/off
- [ ] `/tune X` selects tune (1–4)
- [ ] `/char 1` switches to charset 1 immediately
- [ ] `/char 2` switches to charset 2 immediately

---

## Part 2 — Feature Alignment Test Checklist

> For the tester. Verify that each implemented feature behaves exactly as the specification describes. Test on real hardware or accurate emulation.

### Boot Sequence

- [ ] On load: screen turns black before any output appears
- [ ] "Tribot Plus, Triad" is the first text shown, with correct capitalization
- [ ] Exactly one blank line separates the title from "Booting..."
- [ ] Hardware check results print one line at a time as each check completes
- [ ] "REU Detected" appears when REU is mounted
- [ ] "REU Not found!" appears when REU is not mounted
- [ ] TRIAD logo renders correctly after hardware checks clear the screen
- [ ] "Dealer Quality Botnet" byline appears below the TRIAD logo
- [ ] "Loading..." message is visually centered on the screen
- [ ] Final screen shows: logo, introduction text, and the input field in correct positions

### Layout & Display

- [ ] Output area occupies the region above the divider
- [ ] Input field occupies the region below the divider
- [ ] Divider is visually distinct between the two areas
- [ ] Screen is 40 characters wide and 25 lines tall as expected on C64
- [ ] Custom charset is active — default C64 BASIC characters are not visible

### Input Field

- [ ] Prompt `> ` appears at the start of the input line with correct spacing
- [ ] Pressing Backspace or Delete to the prompt boundary does not remove the prefix
- [ ] Placeholder "Ask me anything..." is visible before the first keystroke
- [ ] Placeholder disappears as soon as the user presses any character key
- [ ] After the first question is submitted, the placeholder does not reappear
- [ ] Text typed by the user is yellow
- [ ] Prompt `>` is medium grey
- [ ] Placeholder text is dark grey
- [ ] Divider is dark grey

### Input Behavior

- [ ] Typing stops at character 37 — the 38th character is not accepted
- [ ] No visual or auditory glitch occurs when the character limit is reached
- [ ] Backspace correctly removes the last typed character

### Scrollback

- [ ] F1 moves the output view back exactly 12 lines per press
- [ ] F7 moves the output view forward exactly 12 lines per press
- [ ] F1 at the top boundary stops scrolling (no wrap-around or error)
- [ ] F7 at the bottom boundary stops scrolling (no wrap-around or error)
- [ ] Holding F1 produces continuous backward scrolling
- [ ] Holding F7 produces continuous forward scrolling
- [ ] Submitting a new question while scrolled back: view jumps to latest output, then new response appends

### Command Handling

- [ ] `/clear` clears the screen immediately and purges the scrollback buffer (no logo or intro text restored)
- [ ] `/reset` produces identical behavior to `/clear` — screen and scrollback both cleared
- [ ] `/exit` returns to BASIC prompt without crashing
- [ ] `/quit` produces identical behavior to `/exit`
- [ ] `/help` output lists every command, every alias, and a description for each
- [ ] `/man` produces identical output to `/help`
- [ ] `/info` shows logo, introduction, and version information
- [ ] `/info` mentions `/help` and `/man` by name
- [ ] `/music` visibly toggles music: off when playing, on when stopped
- [ ] `/tune 1` through `/tune 4` each switch to the correct tune immediately
- [ ] `/char 1` switches to charset 1 immediately with no screen corruption
- [ ] `/char 2` switches to charset 2 immediately with no screen corruption

### Question Handling

- [ ] A recognized question returns a database result
- [ ] A question with no database match receives a bogus answer (not silence, not an error)
- [ ] Bogus answers read as plausible sentences
- [ ] A `?` is appended to the echoed question in the output area
- [ ] Commands are NOT passed to the database — they execute directly

### System Feedback

- [ ] The animated indicator is visible to the left of the status message during processing
- [ ] The status message text changes across multiple queries (randomness is observable)
- [ ] The indicator and message disappear or are replaced when the response appears

### Output Area & Formatting

- [ ] Lines longer than 40 characters wrap cleanly at the column boundary
- [ ] No stray characters or rendering artifacts appear on word-wrapped lines
- [ ] Output appends to the bottom and the view follows automatically

### Response Color Behavior

- [ ] The newest response is white
- [ ] After a second response arrives, the first response begins fading: white → light grey → medium grey → dark grey
- [ ] The fade progresses across multiple responses in the correct sequence
- [ ] The final (most recent after input stops) response stays white
- [ ] Keyword highlighting is yellow and appears only in the final response
- [ ] Keywords from the user's question are highlighted in the final response
- [ ] Common stop words (e.g., "the", "is", "a") are not highlighted
- [ ] Older responses have no highlighting

### Music

- [ ] Music starts automatically when the program reaches the ready state
- [ ] `/music` stops playback immediately when music is on
- [ ] `/music` resumes the last selected tune immediately when music is off
- [ ] `/tune X` switches tune without interruption when music is already playing
- [ ] After `/tune X` then `/music` off then `/music` on: the tune selected by `/tune X` resumes
- [ ] On fresh program load: music is on and tune 1 is playing (settings have reset)

### Charset

- [ ] On fresh program load: charset 1 is active
- [ ] `/char 2` switches the visible charset to charset 2
- [ ] `/char 1` switches back to charset 1
- [ ] After a `/char 2` session and a fresh program load: charset 1 is active again (reset confirmed)

---

## Part 3 — Bug & Edge Case Test Checklist

> For the tester. Verify the program handles boundary conditions, invalid input, and hardware variation correctly.

### Boot / Hardware

- [ ] Program boots correctly with REU mounted (16MB)
- [ ] Program boots without crash when REU is not mounted — "REU Not found!" appears and boot continues gracefully
- [ ] Program does not hang at any boot stage
- [ ] Boot sequence completes in a reasonable time on stock C64 hardware
- [ ] Boot sequence completes correctly under 1541U / U2 with REU
- [ ] Boot sequence completes correctly under 64Ultimate with REU
- [ ] Boot sequence completes correctly under Turbo Chameleon with REU
- [ ] Boot sequence completes correctly under WinVICE with REU configured

### Input Field Edge Cases

- [ ] Pressing Return on an empty input field does nothing (no crash, no empty entry in output)
- [ ] Pressing Return on input that is only spaces does nothing (or is treated as empty)
- [ ] Typing exactly 38 characters fills the field without overflow
- [ ] Typing exactly 38 characters then pressing Return submits correctly
- [ ] Pressing Backspace on an empty input field does not remove the prompt prefix
- [ ] Typing special PETSCII characters does not corrupt the display

### Command Edge Cases

- [ ] Unknown command (e.g., `/foo`) produces a graceful response — no crash
- [ ] `/tune 0` is rejected or produces a graceful error (out of range)
- [ ] `/tune 5` is rejected or produces a graceful error (out of range)
- [ ] `/char 0` is rejected or produces a graceful error (out of range)
- [ ] `/char 3` is rejected or produces a graceful error (out of range)
- [ ] `/MUSIC` (uppercase) is either recognized or fails gracefully (define expected behavior)
- [ ] `/Tune 1` (mixed case) is either recognized or fails gracefully
- [ ] A command typed with trailing spaces (e.g., `/clear `) behaves correctly
- [ ] A `/` with no command word (just a slash) produces a graceful response

### Scrollback Edge Cases

- [ ] F1 pressed when already at the top of output does not crash or corrupt the screen
- [ ] F7 pressed when already at the bottom of output does not crash or corrupt the screen
- [ ] F1/F7 used when the output area has fewer than 12 lines of content scrolls to boundary correctly
- [ ] Scrollback state resets correctly after a new question is submitted

### Queue Behavior

- [ ] Entering two questions in rapid succession: both are processed and both responses appear in order
- [ ] No duplicate responses or dropped inputs when the queue holds multiple items

### Response Display Edge Cases

- [ ] A response that exactly fills 40 characters per line wraps correctly to the next line
- [ ] A response longer than the visible output area height is scrollable via F1/F7
- [ ] Keyword highlighting works correctly when the matched word appears multiple times in the response
- [ ] No highlighting artifacts appear in superseded responses

### Music Edge Cases

- [ ] `/music` pressed repeatedly in quick succession does not crash or desync audio
- [ ] `/tune X` called when music is off: music remains off, but correct tune queued for when music is toggled back on
- [ ] Switching tunes rapidly (tune 1 → tune 2 → tune 3 → tune 4) does not produce audio glitches or crashes

### Charset Edge Cases

- [ ] Switching charset while text is on screen: existing output re-renders correctly in the new charset
- [ ] Switching charset while a response is being written to the screen does not corrupt output
- [ ] Switching between charset 1 and charset 2 multiple times in a session produces no persistent artifacts

### General Stability

- [ ] Program runs for an extended session (10+ queries) without memory corruption or visual glitches
- [ ] Program returns cleanly to BASIC on `/exit` or `/quit` with no leftover state
- [ ] No screen corruption occurs after `/clear` or `/reset`
- [ ] After `/clear` or `/reset`, F1 and F7 produce no movement (scrollback is empty)
- [ ] After `/clear` or `/reset`, new output starts fresh with no remnants from the previous scrollback
- [ ] Bogus answer engine never returns an empty string
- [ ] Bogus answer engine never produces a crash or hang