# Tribot+ — Implementierungs- & Test-Checkliste

Verwende dieses Dokument für drei Zwecke:

1. **Implementierungsverfolgung** — Der Entwickler bestätigt, dass jedes Feature implementiert wurde.
2. **Abgleichstests** — Der Tester prüft, ob das Verhalten der Spezifikation entspricht.
3. **Fehler- & Grenzfalltests** — Der Tester prüft, ob das Programm Fehler- und Randbedingungen korrekt behandelt.

Markiere Einträge mit `[x]`, wenn bestätigt. Lasse `[ ]` offen, wenn noch nicht erledigt oder nicht verifiziert.

---

## Teil 1 — Implementierungs-Checkliste

> Für den Entwickler. Hake jeden Punkt ab, sobald das Feature implementiert ist und korrekt kompiliert.

### Bootsequenz

- [x] [Taper] [2026/05/17] Stage 1: Bildschirm wird beim Laden schwarz
- [x] [Adder] [2026/05/23] Stage 1: Text „Tribot Plus, Triad" erscheint
- [x] [Adder] [2026/05/23] Stage 1: Eine Leerzeile zwischen Titel und „Booting..."
- [x] [Adder] [2026/05/23] Stage 1: Text „Booting..." erscheint
- [x] [Adder] [2026/05/24] Stage 2: Hardwareerkennung läuft und gibt Ergebnisse zeilenweise aus
- [x] [Adder] [2026/05/23] Stage 2: REU-Vorhandensein wird erkannt und ausgegeben („REU Detected" / „REU Not found!")
- [ ] [     ] [          ] Stage 2: Weitere Hardwareumgebungsprüfungen folgen nach der REU-Erkennung
- [x] [Taper] [2026/05/17] Stage 3: Bildschirm wird nach Hardwareprüfungen geleert
- [x] [Taper] [2026/05/17] Stage 3: TRIAD-Logo wird mit Byline „Dealer Quality Botnet" angezeigt
- [x] [Taper] [2026/05/17] Stage 3: Bildschirm wird erneut geleert und zeigt „Loading..." zentriert
- [x] [Taper] [2026/05/17] Stage 4: Bildschirm wird geleert, wenn der Ladevorgang abgeschlossen ist
- [x] [Taper] [2026/05/09] Stage 4: Tribot+-Logo wird angezeigt
- [x] [Taper] [2026/05/09] Stage 4: Einführungstext wird angezeigt
- [x] [Taper] [2026/05/09] Stage 4: Eingabefeld wird angezeigt und ist bereit für Eingaben

### Visueller Stil

- [x] [Taper] [2026/05/17] Benutzerdefinierter PETSCII-Zeichensatz ist aktiv (nicht der Standard-C64-BASIC-Zeichensatz)
- [x] [Taper] [2026/05/17] Zeichensatz 1 (Highres_1x1_#8 von Tao/Triad) ist implementiert
- [x] [Adder] [2026/05/17] Zeichensatz 2 (Highres_1x1_#6 von Tao/Triad) ist implementiert
- [x] [Taper] [2026/05/17] Zeichensatz 1 ist der Standard beim Programmstart
- [ ] [     ] [          ] Entferne den Text "Tribot plus, Triad" über dem PETSCII-Logo.

### Layout

- [x] [Taper] [2026/05/09] Bildschirm ist aufgeteilt in einen Ausgabebereich (oberhalb des Trennstrichs) und ein Eingabefeld (unterhalb)
- [x] [Taper] [2026/05/17] Ausgabebereich scrollt vertikal
- [x] [Taper] [2026/05/09] Eingabefeld ist fest und immer sichtbar
- [x] [Taper] [2026/05/09] Trennstrich ist vorhanden und trennt die beiden Bereiche

### Eingabefeld

- [x] [Taper] [2026/05/09] Prompt-Präfix `> ` wird angezeigt (Größer-als-Zeichen + Leerzeichen)
- [x] [Taper] [2026/05/09] Präfix ist statisch und kann nicht bearbeitet oder gelöscht werden
- [x] [Taper] [2026/05/09] Eingabebereich ist 37 Zeichen breit
- [x] [Taper] [2026/05/09] Gesamte Prompt-Breite beträgt 2 Zeichen (Präfix belegt Spalten 1–2)
- [x] [Taper] [2026/05/09] Trennstrich ist dunkelgrau gefärbt
- [x] [Taper] [2026/05/17] Prompt `>` ist mittelgrau gefärbt
- [x] [Adder] [2026/05/23] Platzhaltertext ist dunkelgrau gefärbt
- [x] [Adder] [2026/05/23] Benutzereingabetext ist gelb gefärbt
- [x] [Adder] [2026/05/23] Platzhalter „Ask me anything..." wird nur beim ersten Start angezeigt
- [x] [Adder] [2026/05/23] Platzhalter verschwindet, wenn der Benutzer beginnt zu tippen
- [x] [Adder] [2026/05/23] Platzhalter wird nach der ersten gesendeten Frage nicht mehr angezeigt

### Eingabeverhalten

- [x] [Adder] [2026/05/23] Eingabe ist auf 38 Zeichen begrenzt
- [x] [Adder] [2026/05/23] Nach Erreichen des 38-Zeichen-Limits werden keine weiteren Zeichen akzeptiert

### Scrollback

- [x] [Taper] [2026/05/17] F1 scrollt den Ausgabebereich um 1 Zeile zurück
- [x] [Taper] [2026/05/17] F7 scrollt den Ausgabebereich um 1 Zeile vor
- [x] [Adder] [2026/05/23] Halten von F1 scrollt kontinuierlich in 1-Zeilen-Schritten, bis losgelassen oder Grenze erreicht
- [x] [Adder] [2026/05/23] Halten von F7 scrollt kontinuierlich in 1-Zeilen-Schritten, bis losgelassen oder Grenze erreicht
- [x] [Taper] [2026/05/17] Senden einer neuen Frage beim Zurückgscrollen springt die Ansicht zur neuesten Ausgabe, bevor angehängt wird

### Ausführungsablauf

- [x] [Taper] [2026/05/17] Gesendete Eingabe wird mit Präfix `> ` im Ausgabebereich wiederholt
- [x] [Taper] [2026/05/17] Ein `?` wird der wiederholten Eingabe angehängt, wenn die Eingabe eine Frage ist
- [x] [Taper] [2026/05/17] Befehlserkennung prüft beim Senden auf `/`-Präfix
- [x] [Adder] [2026/05/23] Erkannte Befehle werden sofort ausgeführt, ohne Datenbankabfrage
- [x] [Taper] [2026/05/17] Nicht-Befehlseingaben werden als Frage behandelt und an die Datenbank weitergegeben
- [x] [Taper] [2026/05/17] Eine Datenbankübereinstimmung gibt das gefundene Ergebnis als Antwort zurück
- [x] [Taper] [2026/05/17] Keine Datenbankübereinstimmung aktiviert die Nonsens-Antwort-Engine
- [x] [Taper] [2026/05/17] Die Nonsens-Antwort-Engine erzeugt eine plausible, syntaktisch korrekte Antwort
- [x] [Taper] [2026/05/17] Das System verarbeitet jeweils eine Aufgabe (Einzelaufgaben-Warteschlange)

### Systemrückmeldung

- [x] [Taper] [2026/05/17] Ein animierter Indikator erscheint links der Statusmeldung während der Verarbeitung
- [x] [Taper] [2026/05/17] Statusmeldung wird zufällig aus dem definierten Satz von 25 Meldungen ausgewählt
- [x] [Taper] [2026/05/17] Alle 25 Meldungen sind im Meldungspool vorhanden:
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

### Ausgabebereich

- [x] [Taper] [2026/05/17] Fragen, Befehle und Antworten erscheinen alle im Ausgabebereich
- [x] [Taper] [2026/05/17] Einträge erscheinen von oben nach unten in chronologischer Reihenfolge
- [x] [Taper] [2026/05/17] Neue Einträge werden unten angehängt
- [x] [Taper] [2026/05/17] Ansicht scrollt automatisch, um die neueste Ausgabe anzuzeigen

### Antwortformatierung

- [x] [Taper] [2026/05/17] Antworten sind nur Klartext (keine Überschriften, keine Listen gerendert)
- [x] [Taper] [2026/05/17] Lange Antworten umbrechen innerhalb der 40-Zeichen-Bildschirmbreite

### Antwortfarbverhalten

- [x] [Taper] [2026/05/17] Die Antwort ist weiß
- [x] [IMPOS] [2026/05/23] Schlüsselwort-Hervorhebung gilt nur für die Antwort
- [x] [IMPOS] [2026/05/23] Schlüsselwörter werden aus der Benutzerfrage durch exakte Übereinstimmung extrahiert
- [x] [IMPOS] [2026/05/23] Häufige Stoppwörter werden vor dem Schlüsselwortabgleich ausgeschlossen
- [x] [IMPOS] [2026/05/23] Jede Schlüsselwortübereinstimmung in der Antwort wird gelb gefärbt

### Musik

- [x] [Taper] [2026/05/17] SID-Musik spielt standardmäßig, wenn das Programm bereit für Eingaben ist
- [x] [Taper] [2026/05/17] Musik wird bei jedem Programmstart auf Ein zurückgesetzt
- [x] [Taper] [2026/05/17] Standard-Melodie ist Melodie 1 bei jedem Programmstart
- [x] [Taper] [2026/05/17] Befehl `/music` schaltet die Wiedergabe sofort ein und aus
- [x] [Taper] [2026/05/17] `/tune 1` wechselt sofort zu Melodie 1
- [x] [Taper] [2026/05/17] `/tune 2` wechselt sofort zu Melodie 2
- [x] [Taper] [2026/05/17] Musik ausschalten stoppt die Wiedergabe sofort
- [x] [Taper] [2026/05/17] Musik einschalten setzt die zuletzt gewählte Melodie fort

### Befehle

- [x] [Taper] [2026/05/17] `/clear` leert den Bildschirm und löscht den Scrollback-Puffer
- [x] [Adder] [2026/05/23] `/reset` leert den Bildschirm und löscht den Scrollback-Puffer (Alias für `/clear`)
- [x] [Taper] [2026/05/17] `/exit` beendet Tribot+ und kehrt zu BASIC zurück (Warmstart)
- [x] [Adder] [2026/05/23] `/quit` beendet Tribot+ und kehrt zu BASIC zurück (Alias für `/exit`)
- [x] [Taper] [2026/05/17] `/help` zeigt eine Liste aller verfügbaren Befehle mit Aliasen und Beschreibungen
- [x] [Taper] [2026/05/17] `/man` zeigt eine Liste aller verfügbaren Befehle (Alias für `/help`)
- [x] [Taper] [2026/05/17] `/info` zeigt das Tribot+-Logo, eine kurze Einführung und technische Versionsdetails
- [x] [Taper] [2026/05/17] `/info`-Ausgabe erwähnt `/help` und `/man` für verfügbare Befehle
- [x] [Taper] [2026/05/17] `/music` schaltet Musik ein/aus
- [x] [Adder] [2026/05/23] `/tunes` listet Titel und Komponist auf
- [x] [Taper] [2026/05/17] `/tune X` wählt Melodie
- [x] [Taper] [2026/05/17] `/char 1` wechselt sofort zu Zeichensatz 1
- [x] [Adder] [2026/05/23] `/char 2` wechselt sofort zu Zeichensatz 2

---

## Teil 2 — Feature-Abgleich-Test-Checkliste

> Für den Tester. Überprüfe, ob jedes implementierte Feature sich genau so verhält, wie die Spezifikation beschreibt. Teste auf echter Hardware oder genauer Emulation.

### Bootsequenz

- [x] [Adder] [2026/05/23] Beim Laden: Bildschirm wird schwarz, bevor eine Ausgabe erscheint
- [x] [Adder] [2026/05/23] „Tribot Plus, Triad" ist der erste angezeigte Text, mit korrekter Groß-/Kleinschreibung
- [x] [Adder] [2026/05/23] Genau eine Leerzeile trennt den Titel von „Booting..."
- [x] [HOW]   [2026/05/23] Hardwareprüfungsergebnisse werden zeilenweise ausgegeben, sobald jede Prüfung abgeschlossen ist
- [x] [Adder] [2026/05/23] „REU Detected" erscheint, wenn REU eingebunden ist
- [x] [Adder] [2026/05/23] „REU Not found!" erscheint, wenn REU nicht eingebunden ist
- [x] [Taper] [2026/05/17] TRIAD-Logo wird korrekt dargestellt, nachdem Hardwareprüfungen den Bildschirm geleert haben
- [x] [Taper] [2026/05/17] Byline „Dealer Quality Botnet" erscheint unterhalb des TRIAD-Logos
- [x] [Taper] [2026/05/17] „Loading..."-Meldung ist visuell auf dem Bildschirm zentriert
- [x] [Adder] [2026/05/23] Verzögerung zur Bootsequenz hinzufügen.
- [x] [Taper] [2026/05/17] Abschließender Bildschirm zeigt: Logo, Einführungstext und Eingabefeld an korrekten Positionen

### Layout & Anzeige

- [x] [Taper] [2026/05/17] Ausgabebereich belegt den Bereich oberhalb des Trennstrichs
- [x] [Taper] [2026/05/17] Eingabefeld belegt den Bereich unterhalb des Trennstrichs
- [x] [Taper] [2026/05/17] Trennstrich ist visuell klar zwischen den beiden Bereichen erkennbar
- [x] [Taper] [2026/05/17] Bildschirm ist 40 Zeichen breit und 25 Zeilen hoch, wie auf dem C64 erwartet
- [x] [Taper] [2026/05/17] Benutzerdefinierter Zeichensatz ist aktiv — Standard-C64-BASIC-Zeichen sind nicht sichtbar

### Eingabefeld

- [x] [Taper] [2026/05/17] Prompt `> ` erscheint am Anfang der Eingabezeile mit korrektem Abstand
- [x] [Taper] [2026/05/17] Drücken von Backspace oder Delete bis zur Prompt-Grenze entfernt das Präfix nicht
- [x] [Adder] [2026/05/23] Platzhalter „Ask me anything..." ist vor dem ersten Tastendruck sichtbar
- [x] [Adder] [2026/05/23] Platzhalter verschwindet, sobald der Benutzer eine beliebige Zeichentaste drück
- [x] [Adder] [2026/05/23] Nach dem Absenden der ersten Frage erscheint der Platzhalter nicht erneut
- [x] [Adder] [2026/05/23] Vom Benutzer eingegebener Text ist gelb
- [x] [Taper] [2026/05/17] Prompt `>` ist mittelgrau
- [x] [Adder] [2026/05/23] Platzhaltertext ist dunkelgrau
- [x] [Taper] [2026/05/17] Trennstrich ist dunkelgrau

### Eingabeverhalten

- [x] [Taper] [2026/05/17] Eingabe stoppt bei Zeichen 37 — das 38. Zeichen wird nicht akzeptiert
- [x] [Taper] [2026/05/17] Kein visueller oder akustischer Fehler tritt auf, wenn das Zeichenlimit erreicht wird
- [x] [Taper] [2026/05/17] Backspace entfernt das zuletzt eingegebene Zeichen korrekt

### Scrollback

- [x] [Taper] [2026/05/17] F1 bewegt die Ausgabeansicht genau 1 Zeile pro Druck zurück
- [x] [Taper] [2026/05/17] F7 bewegt die Ausgabeansicht genau 1 Zeile pro Druck vor
- [x] [Taper] [2026/05/17] F1 an der oberen Grenze stoppt das Scrollen (kein Überlauf oder Fehler)
- [x] [Taper] [2026/05/17] F7 an der unteren Grenze stoppt das Scrollen (kein Überlauf oder Fehler)
- [x] [IMPOS] [2026/05/23] Halten von F1 erzeugt kontinuierliches Rückwärtsscrollen
- [x] [IMPOS] [2026/05/23] Halten von F7 erzeugt kontinuierliches Vorwärtsscrollen
- [x] [Taper] [2026/05/17] Absenden einer neuen Frage beim Zurückgscrollen: Ansicht springt zur neuesten Ausgabe, dann wird neue Antwort angehängt

### Befehlsbehandlung

- [x] [Taper] [2026/05/17] `/clear` leert den Bildschirm sofort und löscht den Scrollback-Puffer (kein Logo oder Einführungstext wird wiederhergestellt)
- [x] [Adder] [2026/05/23] `/reset` verhält sich identisch zu `/clear` — Bildschirm und Scrollback werden beide geleert
- [x] [Taper] [2026/05/17] `/exit` kehrt ohne Absturz zum BASIC-Prompt zurück
- [x] [Adder] [2026/05/23] `/quit` verhält sich identisch zu `/exit`
- [x] [Taper] [2026/05/17] `/help`-Ausgabe listet jeden Befehl, jeden Alias und eine Beschreibung für jeden auf
- [x] [Taper] [2026/05/17] `/man` erzeugt identische Ausgabe wie `/help`
- [x] [Taper] [2026/05/17] `/info` zeigt Logo, Einführung und Versionsinformationen
- [x] [Taper] [2026/05/17] `/info` erwähnt `/help` und `/man` namentlich
- [x] [Taper] [2026/05/17] `/music` schaltet Musik sichtbar um: aus wenn spielend, an wenn gestoppt
- [x] [Adder] [2026/05/23] `/tunes` listet Titel und Komponist auf
- [x] [Taper] [2026/05/17] `/tune 1` bis `/tune 2` wechseln jeweils sofort zur korrekten Melodie
- [x] [Adder] [2026/05/23] `/char 1` wechselt sofort zu Zeichensatz 1 ohne Bildschirmkorruption
- [x] [Adder] [2026/05/23] `/char 2` wechselt sofort zu Zeichensatz 2 ohne Bildschirmkorruption

### Fragenbehandlung

- [x] [Taper] [2026/05/17] Eine erkannte Frage gibt ein Datenbankergebnis zurück
- [x] [Taper] [2026/05/17] Eine Frage ohne Datenbankübereinstimmung erhält eine Nonsens-Antwort (keine Stille, kein Fehler)
- [x] [Taper] [2026/05/17] Nonsens-Antworten lesen sich als plausible Sätze
- [x] [Taper] [2026/05/17] Ein `?` wird der wiederholten Frage im Ausgabebereich angehängt
- [x] [Taper] [2026/05/17] Befehle werden NICHT an die Datenbank weitergegeben — sie werden direkt ausgeführt

### Systemrückmeldung

- [x] [Taper] [2026/05/17] Der animierte Indikator ist links der Statusmeldung während der Verarbeitung sichtbar
- [x] [Taper] [2026/05/17] Der Statusmeldungstext ändert sich bei mehreren Abfragen (Zufälligkeit ist beobachtbar)

### Ausgabebereich & Formatierung

- [x] [Taper] [2026/05/17] Zeilen, die länger als 40 Zeichen sind, brechen sauber an der Spaltengrenze um
- [x] [Taper] [2026/05/17] Keine verirrten Zeichen oder Darstellungsartefakte erscheinen in umgebrochenen Zeilen
- [x] [Taper] [2026/05/17] Ausgabe wird unten angehängt und die Ansicht folgt automatisch

### Antwortfarbverhalten

- [x] [Taper] [2026/05/17] Die Antwort ist weiß
- [x] [IMPOS] [2026/05/23] Schlüsselwort-Hervorhebung ist gelb und erscheint nur in der Antwort
- [x] [Taper] [2026/05/17] Häufige Stoppwörter (z.B. „the", „is", „a") werden nicht hervorgehoben
- [ ] [     ] [          ] Ältere Antworten haben keine Hervorhebung

### Musik

- [x] [Taper] [2026/05/17] Musik startet automatisch, wenn das Programm den Bereitschaftszustand erreicht
- [x] [Taper] [2026/05/17] `/music` stoppt die Wiedergabe sofort, wenn Musik an ist
- [x] [Taper] [2026/05/17] `/music` setzt die zuletzt gewählte Melodie sofort fort, wenn Musik aus ist
- [x] [Taper] [2026/05/17] `/tune X` wechselt die Melodie ohne Unterbrechung, wenn Musik bereits spielt
- [x] [Taper] [2026/05/17] Nach `/tune X`, dann `/music` aus, dann `/music` an: Die von `/tune X` gewählte Melodie wird fortgesetzt
- [x] [Taper] [2026/05/17] Bei frischem Programmstart: Musik ist an und Melodie 1 spielt (Einstellungen wurden zurückgesetzt)

### Zeichensatz

- [x] [Taper] [2026/05/17] Bei frischem Programmstart: Zeichensatz 1 ist aktiv
- [x] [Adder] [2026/05/23] `/char 2` wechselt den sichtbaren Zeichensatz zu Zeichensatz 2
- [x] [Adder] [2026/05/23] `/char 1` wechselt zurück zu Zeichensatz 1
- [x] [Taper] [2026/05/17] Nach einer `/char 2`-Sitzung und einem frischen Programmstart: Zeichensatz 1 ist wieder aktiv (Zurücksetzung bestätigt)

---

## Teil 3 — Fehler- & Grenzfall-Test-Checkliste

> Für den Tester. Überprüfe, ob das Programm Randbedingungen, ungültige Eingaben und Hardwarevariationen korrekt behandelt.

### Boot / Hardware

- [x] [Taper] [2026/05/17] Programm startet korrekt mit eingebundener REU (16MB)
- [x] [Taper] [2026/05/17] Programm startet ohne Absturz, wenn REU nicht eingebunden ist — „REU Not found!" erscheint, aber wenn REU eingebunden wird, setzt es fort.
- [x] [Taper] [2026/05/17] Programm hängt sich in keiner Bootphase auf
- [x] [Adder] [2026/05/23] Bootsequenz wird in angemessener Zeit auf Standard-C64-Hardware abgeschlossen
- [x] [Adder] [2026/05/23] Bootsequenz wird korrekt unter 1541U / U2 mit REU abgeschlossen
- [ ] [     ] [          ] Bootsequenz wird korrekt unter 64Ultimate mit REU abgeschlossen
- [ ] [     ] [          ] Bootsequenz wird korrekt unter Turbo Chameleon mit REU abgeschlossen
- [x] [Adder] [2026/05/23] Bootsequenz wird korrekt unter WinVICE mit konfigurierter REU abgeschlossen

### Grenzfälle des Eingabefelds

- [x] [Taper] [2026/05/17] Drücken von Return auf leerem Eingabefeld tut nichts (kein Absturz, kein leerer Eintrag in der Ausgabe)
- [x] [Adder] [2026/05/23] Drücken von Return auf Eingabe, die nur Leerzeichen enthält, tut nichts (oder wird als leer behandelt)
- [x] [Taper] [2026/05/17] Eingabe von genau 37 Zeichen füllt das Feld ohne Überlauf
- [x] [Taper] [2026/05/17] Eingabe von genau 37 Zeichen und anschließendes Drücken von Return wird korrekt abgesendet
- [x] [Taper] [2026/05/17] Drücken von Backspace auf leerem Eingabefeld entfernt das Prompt-Präfix nicht

### Grenzfälle der Befehle

- [x] [Adder] [2026/05/23] Unbekannter Befehl (z.B. `/foo`) erzeugt eine korrekte Antwort — kein Absturz
- [x] [Adder] [2026/05/23] `/tune 0` wird abgelehnt oder erzeugt einen korrekten Fehler (außerhalb des Bereichs)
- [x] [Adder] [2026/05/23] `/tune 3` wird abgelehnt oder erzeugt einen korrekten Fehler (außerhalb des Bereichs)
- [x] [Adder] [2026/05/23] `/char 0` wird abgelehnt oder erzeugt einen korrekten Fehler (außerhalb des Bereichs)
- [x] [Adder] [2026/05/23] `/char 3` wird abgelehnt oder erzeugt einen korrekten Fehler (außerhalb des Bereichs)
- [x] [Adder] [2026/05/23] Ein Befehl mit abschließenden Leerzeichen (z.B. `/clear `) verhält sich korrekt
- [x] [Adder] [2026/05/23] Ein `/` ohne Befehlswort (nur ein Schrägstrich) erzeugt eine korrekte Antwort

### Grenzfälle des Scrollbacks

- [X] [Taper] [2026/05/17] F1 gedrückt, wenn bereits am oberen Rand der Ausgabe, führt nicht zu Absturz oder Bildschirmkorruption
- [X] [Taper] [2026/05/17] F7 gedrückt, wenn bereits am unteren Rand der Ausgabe, führt nicht zu Absturz oder Bildschirmkorruption
- [X] [Taper] [2026/05/17] F1/F7 verwendet, wenn der Ausgabebereich weniger als 12 Inhaltszeilen hat, scrollt korrekt zur Grenze
- [X] [Taper] [2026/05/17] Scrollback-Zustand wird korrekt zurückgesetzt, nachdem eine neue Frage gesendet wurde

### Grenzfälle der Antwortanzeige

- [X] [Taper] [2026/05/17] Eine Antwort, die genau 40 Zeichen pro Zeile füllt, bricht korrekt zur nächsten Zeile um
- [X] [Taper] [2026/05/17] Eine Antwort, die länger als die sichtbare Ausgabebereichshöhe ist, ist über F1/F7 scrollbar
- [x] [IMPOS] [2026/05/23] Schlüsselwort-Hervorhebung funktioniert korrekt, wenn das übereinstimmende Wort mehrfach in der Antwort vorkommt
- [x] [Adder] [2026/05/23] Keine Hervorhebungsartefakte erscheinen in überholten Antworten

### Grenzfälle der Musik

- [x] [Adder] [2026/05/23] `/music` wiederholt schnell gedrückt führt nicht zu Absturz oder Audio-Desynchronisation
- [x] [Adder] [2026/05/23] `/tune X` aufgerufen, wenn Musik aus ist: Musik bleibt aus, aber korrekte Melodie wird für das Einschalten in die Warteschlange gestellt
- [x] [Adder] [2026/05/23] Schnelles Wechseln der Melodien (Melodie 1 → 2) erzeugt keine Audioartefakte oder Abstürze

### Grenzfälle des Zeichensatzes

- [x] [Adder] [2026/05/23] Wechseln des Zeichensatzes während Text auf dem Bildschirm ist: Bestehende Ausgabe wird korrekt im neuen Zeichensatz neu gerendert
- [x] [Adder] [2026/05/23] Wechseln des Zeichensatzes während eine Antwort auf den Bildschirm geschrieben wird, korrumpiert die Ausgabe nicht
- [x] [Adder] [2026/05/23] Mehrmaliges Wechseln zwischen Zeichensatz 1 und 2 in einer Sitzung erzeugt keine dauerhaften Artefakte

### Allgemeine Stabilität

- [X] [Taper] [2026/05/17] Programm läuft in einer verlängerten Sitzung (10+ Abfragen) ohne Speicherkorruption oder visuelle Artefakte
- [x] [Taper] [2026/05/17] Programm kehrt sauber zu BASIC zurück bei `/exit` oder `/quit` ohne verbleibenden Zustand
- [x] [Adder] [2026/05/23] Keine Bildschirmkorruption tritt nach `/clear` oder `/reset` auf
- [X] [Taper] [2026/05/17] Nach `/clear` oder `/reset` erzeugen F1 und F7 keine Bewegung (Scrollback ist leer)
- [X] [Taper] [2026/05/17] Nach `/clear` oder `/reset` beginnt neue Ausgabe frisch ohne Überreste des vorherigen Scrollbacks
- [X] [Taper] [2026/05/17] Nonsens-Antwort-Engine gibt niemals einen leeren String zurück
- [X] [Taper] [2026/05/17] Nonsens-Antwort-Engine erzeugt niemals einen Absturz oder Hänger
