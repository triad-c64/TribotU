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

- [ ] [     ] [          ] Stage 1: Bildschirm wird beim Laden schwarz
- [ ] [     ] [          ] Stage 1: Text „Tribot Plus, Triad" erscheint
- [ ] [     ] [          ] Stage 1: Eine Leerzeile zwischen Titel und „Booting..."
- [ ] [     ] [          ] Stage 1: Text „Booting..." erscheint
- [ ] [     ] [          ] Stage 2: Hardwareerkennung läuft und gibt Ergebnisse zeilenweise aus
- [ ] [     ] [          ] Stage 2: REU-Vorhandensein wird erkannt und ausgegeben („REU Detected" / „REU Not found!")
- [ ] [     ] [          ] Stage 2: Weitere Hardwareumgebungsprüfungen folgen nach der REU-Erkennung
- [ ] [     ] [          ] Stage 3: Bildschirm wird nach Hardwareprüfungen geleert
- [ ] [     ] [          ] Stage 3: TRIAD-Logo wird mit Byline „Dealer Quality Botnet" angezeigt
- [ ] [     ] [          ] Stage 3: Bildschirm wird erneut geleert und zeigt „Loading..." zentriert
- [ ] [     ] [          ] Stage 4: Bildschirm wird geleert, wenn der Ladevorgang abgeschlossen ist
- [x] [Taper] [2026/05/09] Stage 4: Tribot+-Logo wird angezeigt
- [x] [Taper] [2026/05/09] Stage 4: Einführungstext wird angezeigt
- [x] [Taper] [2026/05/09] Stage 4: Eingabefeld wird angezeigt und ist bereit für Eingaben

### Visueller Stil

- [ ] [     ] [          ] Benutzerdefinierter PETSCII-Zeichensatz ist aktiv (nicht der Standard-C64-BASIC-Zeichensatz)
- [ ] [     ] [          ] Zeichensatz 1 (Highres_1x1_#8 von Tao/Triad) ist implementiert
- [ ] [     ] [          ] Zeichensatz 2 (Highres_1x1_#6 von Tao/Triad) ist implementiert
- [ ] [     ] [          ] Zeichensatz 1 ist der Standard beim Programmstart

### Layout

- [x] [Taper] [2026/05/09] Bildschirm ist aufgeteilt in einen Ausgabebereich (oberhalb des Trennstrichs) und ein Eingabefeld (unterhalb)
- [ ] [     ] [          ] Ausgabebereich scrollt vertikal
- [x] [Taper] [2026/05/09] Eingabefeld ist fest und immer sichtbar
- [x] [Taper] [2026/05/09] Trennstrich ist vorhanden und trennt die beiden Bereiche

### Eingabefeld

- [x] [Taper] [2026/05/09] Prompt-Präfix `> ` wird angezeigt (Größer-als-Zeichen + Leerzeichen)
- [x] [Taper] [2026/05/09] Präfix ist statisch und kann nicht bearbeitet oder gelöscht werden
- [x] [Taper] [2026/05/09] Eingabebereich ist 37 Zeichen breit
- [x] [Taper] [2026/05/09] Gesamte Prompt-Breite beträgt 2 Zeichen (Präfix belegt Spalten 1–2)
- [x] [Taper] [2026/05/09] Trennstrich ist dunkelgrau gefärbt
- [ ] [     ] [          ] Prompt `>` ist mittelgrau gefärbt
- [ ] [     ] [          ] Platzhaltertext ist dunkelgrau gefärbt
- [ ] [     ] [          ] Benutzereingabetext ist gelb gefärbt
- [ ] [     ] [          ] Platzhalter „Ask me anything..." wird nur beim ersten Start angezeigt
- [ ] [     ] [          ] Platzhalter verschwindet, wenn der Benutzer beginnt zu tippen
- [ ] [     ] [          ] Platzhalter wird nach der ersten gesendeten Frage nicht mehr angezeigt

### Eingabeverhalten

- [x] [Taper] [2026/05/09] Eingabe ist auf 37 Zeichen begrenzt
- [x] [Taper] [2026/05/09] Nach Erreichen des 37-Zeichen-Limits werden keine weiteren Zeichen akzeptiert

### Scrollback

- [ ] [     ] [          ] F1 scrollt den Ausgabebereich um 12 Zeilen zurück
- [ ] [     ] [          ] F7 scrollt den Ausgabebereich um 12 Zeilen vor
- [ ] [     ] [          ] Wiederholtes Drücken von F1 scrollt bis zur ersten Ausgabezeile zurück
- [ ] [     ] [          ] Wiederholtes Drücken von F7 scrollt bis zur letzten Ausgabezeile vor
- [ ] [     ] [          ] Halten von F1 scrollt kontinuierlich in 12-Zeilen-Schritten, bis losgelassen oder Grenze erreicht
- [ ] [     ] [          ] Halten von F7 scrollt kontinuierlich in 12-Zeilen-Schritten, bis losgelassen oder Grenze erreicht
- [ ] [     ] [          ] Senden einer neuen Frage beim Zurückgscrollen springt die Ansicht zur neuesten Ausgabe, bevor angehängt wird

### Ausführungsablauf

- [ ] [     ] [          ] Gesendete Eingabe wird mit Präfix `> ` im Ausgabebereich wiederholt
- [ ] [     ] [          ] Ein `?` wird der wiederholten Eingabe angehängt, wenn die Eingabe eine Frage ist
- [ ] [     ] [          ] Befehlserkennung prüft beim Senden auf `/`-Präfix
- [ ] [     ] [          ] Erkannte Befehle werden sofort ausgeführt, ohne Datenbankabfrage
- [ ] [     ] [          ] Nicht-Befehlseingaben werden als Frage behandelt und an die Datenbank weitergegeben
- [ ] [     ] [          ] Eine Datenbankübereinstimmung gibt das gefundene Ergebnis als Antwort zurück
- [ ] [     ] [          ] Keine Datenbankübereinstimmung aktiviert die Nonsens-Antwort-Engine
- [ ] [     ] [          ] Die Nonsens-Antwort-Engine erzeugt eine plausible, syntaktisch korrekte Antwort
- [ ] [     ] [          ] Das System verarbeitet jeweils eine Aufgabe (Einzelaufgaben-Warteschlange)
- [ ] [     ] [          ] Während der Verarbeitung eingegebene Eingaben werden in der Warteschlange eingereiht und der Reihe nach ausgeführt

### Systemrückmeldung

- [ ] [     ] [          ] Ein animierter Indikator erscheint links der Statusmeldung während der Verarbeitung
- [ ] [     ] [          ] Statusmeldung wird zufällig aus dem definierten Satz von 25 Meldungen ausgewählt
- [ ] [     ] [          ] Alle 25 Meldungen sind im Meldungspool vorhanden:
  - [ ] [     ] [          ] Cogitating...
  - [ ] [     ] [          ] Contemplating...
  - [ ] [     ] [          ] Deliberating...
  - [ ] [     ] [          ] Ruminating...
  - [ ] [     ] [          ] Pondering...
  - [ ] [     ] [          ] Mulling...
  - [ ] [     ] [          ] Musing...
  - [ ] [     ] [          ] Percolating...
  - [ ] [     ] [          ] Noodling...
  - [ ] [     ] [          ] Simmering...
  - [ ] [     ] [          ] Marinating...
  - [ ] [     ] [          ] Incubating...
  - [ ] [     ] [          ] Concocting...
  - [ ] [     ] [          ] Scheming...
  - [ ] [     ] [          ] Hatching...
  - [ ] [     ] [          ] Brewing...
  - [ ] [     ] [          ] Calculating...
  - [ ] [     ] [          ] Computing...
  - [ ] [     ] [          ] Churning...
  - [ ] [     ] [          ] Crunching...
  - [ ] [     ] [          ] Coalescing...
  - [ ] [     ] [          ] Deciphering...
  - [ ] [     ] [          ] Germinating...
  - [ ] [     ] [          ] Manifesting...
  - [ ] [     ] [          ] Reticulating...

### Ausgabebereich

- [ ] [     ] [          ] Fragen, Befehle und Antworten erscheinen alle im Ausgabebereich
- [ ] [     ] [          ] Einträge erscheinen von oben nach unten in chronologischer Reihenfolge
- [ ] [     ] [          ] Neue Einträge werden unten angehängt
- [ ] [     ] [          ] Ansicht scrollt automatisch, um die neueste Ausgabe anzuzeigen

### Antwortformatierung

- [ ] [     ] [          ] Antworten sind nur Klartext (keine Überschriften, keine Listen gerendert)
- [ ] [     ] [          ] Lange Antworten umbrechen innerhalb der 40-Zeichen-Bildschirmbreite

### Antwortfarbverhalten

- [ ] [     ] [          ] Die zuletzt angezeigte Antwort erscheint in Weiß
- [ ] [     ] [          ] Wenn eine neue Antwort eintrifft, verblasst die vorherige: Weiß → Hellgrau → Mittelgrau → Dunkelgrau
- [ ] [     ] [          ] Die Verblassungssequenz schreitet fort, während die Antwort im Ausgabebereich nach oben wandert
- [ ] [     ] [          ] Die letzte Antwort (die aktuellste, ohne neuere folgende) bleibt weiß
- [ ] [     ] [          ] Schlüsselwort-Hervorhebung gilt nur für die letzte Antwort
- [ ] [     ] [          ] Schlüsselwörter werden aus der Benutzerfrage durch exakte Übereinstimmung extrahiert
- [ ] [     ] [          ] Häufige Stoppwörter werden vor dem Schlüsselwortabgleich ausgeschlossen
- [ ] [     ] [          ] Jede Schlüsselwortübereinstimmung in der letzten Antwort wird gelb gefärbt
- [ ] [     ] [          ] Überholte Antworten haben keine Schlüsselwort-Hervorhebung

### Musik

- [ ] [     ] [          ] SID-Musik spielt standardmäßig, wenn das Programm bereit für Eingaben ist
- [ ] [     ] [          ] Musik wird bei jedem Programmstart auf Ein zurückgesetzt
- [ ] [     ] [          ] Standard-Melodie ist Melodie 1 bei jedem Programmstart
- [ ] [     ] [          ] Befehl `/music` schaltet die Wiedergabe sofort ein und aus
- [ ] [     ] [          ] `/tune 1` wechselt sofort zu Melodie 1
- [ ] [     ] [          ] `/tune 2` wechselt sofort zu Melodie 2
- [ ] [     ] [          ] `/tune 3` wechselt sofort zu Melodie 3
- [ ] [     ] [          ] `/tune 4` wechselt sofort zu Melodie 4
- [ ] [     ] [          ] Musik ausschalten stoppt die Wiedergabe sofort
- [ ] [     ] [          ] Musik einschalten setzt die zuletzt gewählte Melodie fort

### Befehle

- [ ] [     ] [          ] `/clear` leert den Bildschirm und löscht den Scrollback-Puffer
- [ ] [     ] [          ] `/reset` leert den Bildschirm und löscht den Scrollback-Puffer (Alias für `/clear`)
- [ ] [     ] [          ] `/exit` beendet Tribot+ und kehrt zu BASIC zurück (Warmstart)
- [ ] [     ] [          ] `/quit` beendet Tribot+ und kehrt zu BASIC zurück (Alias für `/exit`)
- [ ] [     ] [          ] `/help` zeigt eine Liste aller verfügbaren Befehle mit Aliasen und Beschreibungen
- [ ] [     ] [          ] `/man` zeigt eine Liste aller verfügbaren Befehle (Alias für `/help`)
- [ ] [     ] [          ] `/info` zeigt das Tribot+-Logo, eine kurze Einführung und technische Versionsdetails
- [ ] [     ] [          ] `/info`-Ausgabe erwähnt `/help` und `/man` für verfügbare Befehle
- [ ] [     ] [          ] `/music` schaltet Musik ein/aus
- [ ] [     ] [          ] `/tune X` wählt Melodie (1–4)
- [ ] [     ] [          ] `/char 1` wechselt sofort zu Zeichensatz 1
- [ ] [     ] [          ] `/char 2` wechselt sofort zu Zeichensatz 2

---

## Teil 2 — Feature-Abgleich-Test-Checkliste

> Für den Tester. Überprüfe, ob jedes implementierte Feature sich genau so verhält, wie die Spezifikation beschreibt. Teste auf echter Hardware oder genauer Emulation.

### Bootsequenz

- [ ] [     ] [          ] Beim Laden: Bildschirm wird schwarz, bevor eine Ausgabe erscheint
- [ ] [     ] [          ] „Tribot Plus, Triad" ist der erste angezeigte Text, mit korrekter Groß-/Kleinschreibung
- [ ] [     ] [          ] Genau eine Leerzeile trennt den Titel von „Booting..."
- [ ] [     ] [          ] Hardwareprüfungsergebnisse werden zeilenweise ausgegeben, sobald jede Prüfung abgeschlossen ist
- [ ] [     ] [          ] „REU Detected" erscheint, wenn REU eingebunden ist
- [ ] [     ] [          ] „REU Not found!" erscheint, wenn REU nicht eingebunden ist
- [ ] [     ] [          ] TRIAD-Logo wird korrekt dargestellt, nachdem Hardwareprüfungen den Bildschirm geleert haben
- [ ] [     ] [          ] Byline „Dealer Quality Botnet" erscheint unterhalb des TRIAD-Logos
- [ ] [     ] [          ] „Loading..."-Meldung ist visuell auf dem Bildschirm zentriert
- [ ] [     ] [          ] Abschließender Bildschirm zeigt: Logo, Einführungstext und Eingabefeld an korrekten Positionen

### Layout & Anzeige

- [ ] [     ] [          ] Ausgabebereich belegt den Bereich oberhalb des Trennstrichs
- [ ] [     ] [          ] Eingabefeld belegt den Bereich unterhalb des Trennstrichs
- [ ] [     ] [          ] Trennstrich ist visuell klar zwischen den beiden Bereichen erkennbar
- [ ] [     ] [          ] Bildschirm ist 40 Zeichen breit und 25 Zeilen hoch, wie auf dem C64 erwartet
- [ ] [     ] [          ] Benutzerdefinierter Zeichensatz ist aktiv — Standard-C64-BASIC-Zeichen sind nicht sichtbar

### Eingabefeld

- [ ] [     ] [          ] Prompt `> ` erscheint am Anfang der Eingabezeile mit korrektem Abstand
- [ ] [     ] [          ] Drücken von Backspace oder Delete bis zur Prompt-Grenze entfernt das Präfix nicht
- [ ] [     ] [          ] Platzhalter „Ask me anything..." ist vor dem ersten Tastendruck sichtbar
- [ ] [     ] [          ] Platzhalter verschwindet, sobald der Benutzer eine beliebige Zeichentaste drückt
- [ ] [     ] [          ] Nach dem Absenden der ersten Frage erscheint der Platzhalter nicht erneut
- [ ] [     ] [          ] Vom Benutzer eingegebener Text ist gelb
- [ ] [     ] [          ] Prompt `>` ist mittelgrau
- [ ] [     ] [          ] Platzhaltertext ist dunkelgrau
- [ ] [     ] [          ] Trennstrich ist dunkelgrau

### Eingabeverhalten

- [ ] [     ] [          ] Eingabe stoppt bei Zeichen 37 — das 38. Zeichen wird nicht akzeptiert
- [ ] [     ] [          ] Kein visueller oder akustischer Fehler tritt auf, wenn das Zeichenlimit erreicht wird
- [ ] [     ] [          ] Backspace entfernt das zuletzt eingegebene Zeichen korrekt

### Scrollback

- [ ] [     ] [          ] F1 bewegt die Ausgabeansicht genau 12 Zeilen pro Druck zurück
- [ ] [     ] [          ] F7 bewegt die Ausgabeansicht genau 12 Zeilen pro Druck vor
- [ ] [     ] [          ] F1 an der oberen Grenze stoppt das Scrollen (kein Überlauf oder Fehler)
- [ ] [     ] [          ] F7 an der unteren Grenze stoppt das Scrollen (kein Überlauf oder Fehler)
- [ ] [     ] [          ] Halten von F1 erzeugt kontinuierliches Rückwärtsscrollen
- [ ] [     ] [          ] Halten von F7 erzeugt kontinuierliches Vorwärtsscrollen
- [ ] [     ] [          ] Absenden einer neuen Frage beim Zurückgscrollen: Ansicht springt zur neuesten Ausgabe, dann wird neue Antwort angehängt

### Befehlsbehandlung

- [ ] [     ] [          ] `/clear` leert den Bildschirm sofort und löscht den Scrollback-Puffer (kein Logo oder Einführungstext wird wiederhergestellt)
- [ ] [     ] [          ] `/reset` verhält sich identisch zu `/clear` — Bildschirm und Scrollback werden beide geleert
- [ ] [     ] [          ] `/exit` kehrt ohne Absturz zum BASIC-Prompt zurück
- [ ] [     ] [          ] `/quit` verhält sich identisch zu `/exit`
- [ ] [     ] [          ] `/help`-Ausgabe listet jeden Befehl, jeden Alias und eine Beschreibung für jeden auf
- [ ] [     ] [          ] `/man` erzeugt identische Ausgabe wie `/help`
- [ ] [     ] [          ] `/info` zeigt Logo, Einführung und Versionsinformationen
- [ ] [     ] [          ] `/info` erwähnt `/help` und `/man` namentlich
- [ ] [     ] [          ] `/music` schaltet Musik sichtbar um: aus wenn spielend, an wenn gestoppt
- [ ] [     ] [          ] `/tune 1` bis `/tune 4` wechseln jeweils sofort zur korrekten Melodie
- [ ] [     ] [          ] `/char 1` wechselt sofort zu Zeichensatz 1 ohne Bildschirmkorruption
- [ ] [     ] [          ] `/char 2` wechselt sofort zu Zeichensatz 2 ohne Bildschirmkorruption

### Fragenbehandlung

- [ ] [     ] [          ] Eine erkannte Frage gibt ein Datenbankergebnis zurück
- [ ] [     ] [          ] Eine Frage ohne Datenbankübereinstimmung erhält eine Nonsens-Antwort (keine Stille, kein Fehler)
- [ ] [     ] [          ] Nonsens-Antworten lesen sich als plausible Sätze
- [ ] [     ] [          ] Ein `?` wird der wiederholten Frage im Ausgabebereich angehängt
- [ ] [     ] [          ] Befehle werden NICHT an die Datenbank weitergegeben — sie werden direkt ausgeführt

### Systemrückmeldung

- [ ] [     ] [          ] Der animierte Indikator ist links der Statusmeldung während der Verarbeitung sichtbar
- [ ] [     ] [          ] Der Statusmeldungstext ändert sich bei mehreren Abfragen (Zufälligkeit ist beobachtbar)
- [ ] [     ] [          ] Indikator und Meldung verschwinden oder werden ersetzt, wenn die Antwort erscheint

### Ausgabebereich & Formatierung

- [ ] [     ] [          ] Zeilen, die länger als 40 Zeichen sind, brechen sauber an der Spaltengrenze um
- [ ] [     ] [          ] Keine verirrten Zeichen oder Darstellungsartefakte erscheinen in umgebrochenen Zeilen
- [ ] [     ] [          ] Ausgabe wird unten angehängt und die Ansicht folgt automatisch

### Antwortfarbverhalten

- [ ] [     ] [          ] Die neueste Antwort ist weiß
- [ ] [     ] [          ] Nach Eintreffen einer zweiten Antwort beginnt die erste zu verblassen: Weiß → Hellgrau → Mittelgrau → Dunkelgrau
- [ ] [     ] [          ] Das Verblassen schreitet über mehrere Antworten in der korrekten Reihenfolge fort
- [ ] [     ] [          ] Die letzte (aktuellste nach Eingabestopp) Antwort bleibt weiß
- [ ] [     ] [          ] Schlüsselwort-Hervorhebung ist gelb und erscheint nur in der letzten Antwort
- [ ] [     ] [          ] Schlüsselwörter aus der Benutzerfrage werden in der letzten Antwort hervorgehoben
- [ ] [     ] [          ] Häufige Stoppwörter (z.B. „the", „is", „a") werden nicht hervorgehoben
- [ ] [     ] [          ] Ältere Antworten haben keine Hervorhebung

### Musik

- [ ] [     ] [          ] Musik startet automatisch, wenn das Programm den Bereitschaftszustand erreicht
- [ ] [     ] [          ] `/music` stoppt die Wiedergabe sofort, wenn Musik an ist
- [ ] [     ] [          ] `/music` setzt die zuletzt gewählte Melodie sofort fort, wenn Musik aus ist
- [ ] [     ] [          ] `/tune X` wechselt die Melodie ohne Unterbrechung, wenn Musik bereits spielt
- [ ] [     ] [          ] Nach `/tune X`, dann `/music` aus, dann `/music` an: Die von `/tune X` gewählte Melodie wird fortgesetzt
- [ ] [     ] [          ] Bei frischem Programmstart: Musik ist an und Melodie 1 spielt (Einstellungen wurden zurückgesetzt)

### Zeichensatz

- [ ] [     ] [          ] Bei frischem Programmstart: Zeichensatz 1 ist aktiv
- [ ] [     ] [          ] `/char 2` wechselt den sichtbaren Zeichensatz zu Zeichensatz 2
- [ ] [     ] [          ] `/char 1` wechselt zurück zu Zeichensatz 1
- [ ] [     ] [          ] Nach einer `/char 2`-Sitzung und einem frischen Programmstart: Zeichensatz 1 ist wieder aktiv (Zurücksetzung bestätigt)

---

## Teil 3 — Fehler- & Grenzfall-Test-Checkliste

> Für den Tester. Überprüfe, ob das Programm Randbedingungen, ungültige Eingaben und Hardwarevariationen korrekt behandelt.

### Boot / Hardware

- [ ] [     ] [          ] Programm startet korrekt mit eingebundener REU (16MB)
- [ ] [     ] [          ] Programm startet ohne Absturz, wenn REU nicht eingebunden ist — „REU Not found!" erscheint und Boot setzt sich ordentlich fort
- [ ] [     ] [          ] Programm hängt sich in keiner Bootphase auf
- [ ] [     ] [          ] Bootsequenz wird in angemessener Zeit auf Standard-C64-Hardware abgeschlossen
- [ ] [     ] [          ] Bootsequenz wird korrekt unter 1541U / U2 mit REU abgeschlossen
- [ ] [     ] [          ] Bootsequenz wird korrekt unter 64Ultimate mit REU abgeschlossen
- [ ] [     ] [          ] Bootsequenz wird korrekt unter Turbo Chameleon mit REU abgeschlossen
- [ ] [     ] [          ] Bootsequenz wird korrekt unter WinVICE mit konfigurierter REU abgeschlossen

### Grenzfälle des Eingabefelds

- [ ] [     ] [          ] Drücken von Return auf leerem Eingabefeld tut nichts (kein Absturz, kein leerer Eintrag in der Ausgabe)
- [ ] [     ] [          ] Drücken von Return auf Eingabe, die nur Leerzeichen enthält, tut nichts (oder wird als leer behandelt)
- [ ] [     ] [          ] Eingabe von genau 38 Zeichen füllt das Feld ohne Überlauf
- [ ] [     ] [          ] Eingabe von genau 38 Zeichen und anschließendes Drücken von Return wird korrekt abgesendet
- [ ] [     ] [          ] Drücken von Backspace auf leerem Eingabefeld entfernt das Prompt-Präfix nicht
- [ ] [     ] [          ] Eingabe spezieller PETSCII-Zeichen korrumpiert die Anzeige nicht

### Grenzfälle der Befehle

- [ ] [     ] [          ] Unbekannter Befehl (z.B. `/foo`) erzeugt eine korrekte Antwort — kein Absturz
- [ ] [     ] [          ] `/tune 0` wird abgelehnt oder erzeugt einen korrekten Fehler (außerhalb des Bereichs)
- [ ] [     ] [          ] `/tune 5` wird abgelehnt oder erzeugt einen korrekten Fehler (außerhalb des Bereichs)
- [ ] [     ] [          ] `/char 0` wird abgelehnt oder erzeugt einen korrekten Fehler (außerhalb des Bereichs)
- [ ] [     ] [          ] `/char 3` wird abgelehnt oder erzeugt einen korrekten Fehler (außerhalb des Bereichs)
- [ ] [     ] [          ] `/MUSIC` (Großbuchstaben) wird entweder erkannt oder schlägt korrekt fehl (erwartetes Verhalten definieren)
- [ ] [     ] [          ] `/Tune 1` (gemischte Groß-/Kleinschreibung) wird entweder erkannt oder schlägt korrekt fehl
- [ ] [     ] [          ] Ein Befehl mit abschließenden Leerzeichen (z.B. `/clear `) verhält sich korrekt
- [ ] [     ] [          ] Ein `/` ohne Befehlswort (nur ein Schrägstrich) erzeugt eine korrekte Antwort

### Grenzfälle des Scrollbacks

- [ ] [     ] [          ] F1 gedrückt, wenn bereits am oberen Rand der Ausgabe, führt nicht zu Absturz oder Bildschirmkorruption
- [ ] [     ] [          ] F7 gedrückt, wenn bereits am unteren Rand der Ausgabe, führt nicht zu Absturz oder Bildschirmkorruption
- [ ] [     ] [          ] F1/F7 verwendet, wenn der Ausgabebereich weniger als 12 Inhaltszeilen hat, scrollt korrekt zur Grenze
- [ ] [     ] [          ] Scrollback-Zustand wird korrekt zurückgesetzt, nachdem eine neue Frage gesendet wurde

### Warteschlangenverhalten

- [ ] [     ] [          ] Eingabe von zwei Fragen in schneller Folge: Beide werden verarbeitet und beide Antworten erscheinen in der Reihenfolge
- [ ] [     ] [          ] Keine doppelten Antworten oder verlorene Eingaben, wenn die Warteschlange mehrere Elemente enthält

### Grenzfälle der Antwortanzeige

- [ ] [     ] [          ] Eine Antwort, die genau 40 Zeichen pro Zeile füllt, bricht korrekt zur nächsten Zeile um
- [ ] [     ] [          ] Eine Antwort, die länger als die sichtbare Ausgabebereichshöhe ist, ist über F1/F7 scrollbar
- [ ] [     ] [          ] Schlüsselwort-Hervorhebung funktioniert korrekt, wenn das übereinstimmende Wort mehrfach in der Antwort vorkommt
- [ ] [     ] [          ] Keine Hervorhebungsartefakte erscheinen in überholten Antworten

### Grenzfälle der Musik

- [ ] [     ] [          ] `/music` wiederholt schnell gedrückt führt nicht zu Absturz oder Audio-Desynchronisation
- [ ] [     ] [          ] `/tune X` aufgerufen, wenn Musik aus ist: Musik bleibt aus, aber korrekte Melodie wird für das Einschalten in die Warteschlange gestellt
- [ ] [     ] [          ] Schnelles Wechseln der Melodien (Melodie 1 → 2 → 3 → 4) erzeugt keine Audioartefakte oder Abstürze

### Grenzfälle des Zeichensatzes

- [ ] [     ] [          ] Wechseln des Zeichensatzes während Text auf dem Bildschirm ist: Bestehende Ausgabe wird korrekt im neuen Zeichensatz neu gerendert
- [ ] [     ] [          ] Wechseln des Zeichensatzes während eine Antwort auf den Bildschirm geschrieben wird, korrumpiert die Ausgabe nicht
- [ ] [     ] [          ] Mehrmaliges Wechseln zwischen Zeichensatz 1 und 2 in einer Sitzung erzeugt keine dauerhaften Artefakte

### Allgemeine Stabilität

- [ ] [     ] [          ] Programm läuft in einer verlängerten Sitzung (10+ Abfragen) ohne Speicherkorruption oder visuelle Artefakte
- [ ] [     ] [          ] Programm kehrt sauber zu BASIC zurück bei `/exit` oder `/quit` ohne verbleibenden Zustand
- [ ] [     ] [          ] Keine Bildschirmkorruption tritt nach `/clear` oder `/reset` auf
- [ ] [     ] [          ] Nach `/clear` oder `/reset` erzeugen F1 und F7 keine Bewegung (Scrollback ist leer)
- [ ] [     ] [          ] Nach `/clear` oder `/reset` beginnt neue Ausgabe frisch ohne Überreste des vorherigen Scrollbacks
- [ ] [     ] [          ] Nonsens-Antwort-Engine gibt niemals einen leeren String zurück
- [ ] [     ] [          ] Nonsens-Antwort-Engine erzeugt niemals einen Absturz oder Hänger
