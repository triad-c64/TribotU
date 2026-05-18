# Tribot+

Übergeordnete Spezifikation für visuellen Stil, Layout, Eingabeverhalten und Befehle.

**Team:**
- Adder - Code
- Skyhawk - Visuelles Design und User Experience
- Bepp - Datamining und Support
- Taper - Zusätzliches Datamining und Support

---

## Übersicht

Tribot+ läuft im Textmodus mit PETSCII und einem eigenen Zeichensatz. Dies unterscheidet es vom Standard-C64-BASIC-Look, reduziert den Speicherbedarf und verbessert die Renderleistung.

Die Benutzeroberfläche orientiert sich an modernen CLI-Tools wie Claude Code.

---

## Visueller Stil

### Zeichensatz

- Eigener PETSCII-Font

### Werkzeuge

- C64 Charset Minion v0.8 Beta auf [CSDB](https://csdb.dk/release/?id=137527)

---

## Layout

Der Bildschirm ist in zwei Bereiche unterteilt:

| Bereich         | Position                | Verhalten              |
| --------------- | ----------------------- | ---------------------- |
| Ausgabebereich  | Oberhalb des Trenners   | Scrollt vertikal       |
| Eingabefeld     | Unterhalb des Trenners  | Fest, immer sichtbar   |

---

## Startsequenz

Die Startsequenz läuft einmalig beim Laden der Datei `tribot-plus.prg`. Sie durchläuft vier Stufen, bevor das Programm bereit für Eingaben ist.

### Voraussetzungen

Tribot+ benötigt ein 16MB REU-Image (`tribot-plus.reu`), das vor dem Starten der `tribot-plus.prg` Datei eingebunden werden muss. Die Einbindung variiert je nach Hardware:

**1541U / U2**
Unter Einstellungen die REU-Größe auf 16MB setzen. `tribot-plus.reu` im Dateibrowser suchen und mit Return einbinden. Danach `tribot-plus.prg` starten.

**64Ultimate**
Gleiche Schritte wie bei 1541U / U2. Beschleunigung aktivieren für ein schnelleres Sucherlebnis.

**Turbo Chameleon**
`tribot-plus.reu` im Dateibrowser suchen und mit Return einbinden. Danach `tribot-plus.prg` starten. Turbo-Modus (No Limit) aktivieren für ein schnelleres Sucherlebnis.

**WinVICE**
Einstellungen → Cartridge/IO-Einstellungen → REU-Einstellungen öffnen. "RAM-Erweiterungseinheit aktivieren" ankreuzen. REU-Größe auf 16384KB setzen. `tribot-plus.reu` suchen und hinzufügen. Danach `tribot-plus.prg` starten.

Hinweis: Unterschiedliche Firmware-Versionen der oben genannten Hardware können die REU-Einbindung geringfügig verändern.

### Stufe 1 — Startbildschirm

Der Bildschirm wird schwarz. Folgender Text erscheint:

    Tribot Plus, Triad

Es folgt eine Leerzeile, dann:

    Booting...

### Stufe 2 — Hardware-Erkennung

Systemprüfungen laufen und Ergebnisse werden zeilenweise ausgegeben. Jede Zeile gibt das Ergebnis einer einzelnen Prüfung aus.

Beispiele:

    - REU Detected
    - REU Not found!

Wird eine REU erkannt, folgen weitere Prüfungen zur Identifikation der Hardware-Umgebung, zum Beispiel ob es sich um einen Standard-Commodore 64 oder einen Ultimate 64 handelt. Weitere Prüfungen und technische Details werden von Taper definiert.

### Stufe 3 — Logo-Bildschirme

Sobald alle Hardware-Prüfungen abgeschlossen sind, wird der Bildschirm gelöscht und das TRIAD-Logo mit dem Zusatz angezeigt:

    Dealer Quality Botnet

Der Bildschirm wird erneut gelöscht und zeigt eine zentrierte Lademeldung:

    Loading...

### Stufe 4 — Bereit

Wenn das Laden abgeschlossen ist, wird der Bildschirm gelöscht und zeigt:

- Das Tribot+-Logo
- Den Einführungstext
- Das Eingabefeld

Das Programm ist bereit für Eingaben.

---

## Eingabefeld

Das Eingabefeld ist fest am unteren Bildschirmrand platziert.

### Eingabeaufforderung

- Präfix: `> ` (Größer-als-Zeichen + Leerzeichen)
- Breite: 2 Zeichen
- Verbleibende Breite: 38 Zeichen für die Benutzereingabe
- Das Präfix ist statisch und kann nicht bearbeitet werden

### Farben

| Element                  | Farbe       |
| ------------------------ | ----------- |
| Trenner                  | Dunkelgrau  |
| Eingabeaufforderung `>`  | Mittelgrau  |
| Platzhalter              | Dunkelgrau  |
| Benutzereingabe          | Gelb        |

### Platzhalter

Wird nur beim ersten Start angezeigt, bevor der Benutzer eine Eingabe gemacht hat.

Standardtext: **"Ask me anything..."**

Verschwindet, wenn der Benutzer zu tippen beginnt. Nach der ersten Frage wird der Platzhalter nicht mehr angezeigt.

---

## Eingabebeschränkungen

- Bildschirmbreite: 40 Zeichen
- Eingabeaufforderung: 2 Zeichen
- Eingabebereich: 38 Zeichen

---

## Eingabeverhalten

Wenn die Eingabe 38 Zeichen erreicht, stoppt die Eingabe. Weitere Zeichen werden nicht akzeptiert.

---

## Scrollback

Der Ausgabebereich unterstützt die Scrollback-Navigation über die Funktionstasten.

| Taste | Aktion                    |
| ----- | ------------------------- |
| F1    | 12 Zeilen zurückscrollen  |
| F7    | 12 Zeilen vorscrollen     |

Jeder Tastendruck scrollt den Ausgabebereich um 12 Zeilen, die Hälfte der 25-zeiligen Bildschirmhöhe. Dies gibt ein gestuftes Gefühl, das dem Scrollback-Verhalten einer CLI entspricht. Wiederholtes Drücken von F1 scrollt zurück bis zur ersten Ausgabe. Wiederholtes Drücken von F7 scrollt vorwärts bis zur letzten Ausgabe.

Das Gedrückthalten von F1 oder F7 scrollt kontinuierlich in 12-Zeilen-Schritten, bis die Taste losgelassen wird oder der Anfang bzw. das Ende der Ausgabe erreicht ist.

Wenn der Benutzer eine neue Frage stellt, während er zurückgescrollt ist, springt der Ausgabebereich zur letzten Ausgabe, bevor die neue Antwort angefügt wird. Die Scrollback-Position hat keinen Einfluss auf die Eingabe oder Ausführung.

---

## Ausführungsablauf

Das Eingabefeld akzeptiert Fragen und Befehle.

### Übermittlung

Bei der Übermittlung wird die Eingabe in den Ausgabebereich verschoben und mit einem Präfix versehen:

    > Benutzerbefehl
    > Benutzerfrage?

Ein `?` wird angehängt, wenn die Eingabe eine Frage ist.

### Befehlserkennung

Bei der Übermittlung prüft Tribot+ zunächst, ob die Eingabe ein Befehl ist. Ein Befehl wird durch ein `/`-Präfix erkannt. Wird ein Befehl erkannt, wird er sofort ausgeführt. Es erfolgt keine Datenbankabfrage.

### Fragenverarbeitung

Wird kein Befehl erkannt, behandelt Tribot+ die Eingabe als Frage und durchsucht die Datenbank nach einer Übereinstimmung.

- Wird eine Übereinstimmung gefunden, wird das Ergebnis als Antwort zurückgegeben.
- Wird keine Übereinstimmung gefunden, wird die Eingabe an die Bogus-Antwort-Engine übergeben.

### Bogus-Antwort-Engine

Die Bogus-Antwort-Engine wird aktiviert, wenn keine Datenbankübereinstimmung gefunden wird. Sie verwendet eine Eliza-ähnliche Engine, um eine syntaktisch korrekte und plausibel klingende Antwort zu generieren, die jedoch nicht aus der Datenbank stammt. Ihr Zweck ist es, Sackgassen zu vermeiden und die Interaktion am Laufen zu halten.

### Warteschlange

- Das System verarbeitet jeweils eine Aufgabe.
- Während der Verarbeitung eingegebene Befehle werden in eine Warteschlange gestellt und der Reihe nach ausgeführt.

---

## Systemrückmeldung

Während der Verarbeitung erscheint links neben einer Statusmeldung ein animierter Indikator. Die Meldung wird zufällig aus der folgenden Liste gewählt.

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

## Ausgabebereich

- Zeigt Fragen, Befehle und Antworten an.
- Einträge erscheinen von oben nach unten.
- Neue Einträge werden unten angefügt.
- Die Ansicht scrollt automatisch.

---

## Antwortformatierung

Antworten sind reiner Text. Keine Überschriften oder Listen werden gerendert. Lange Antworten umbrechen in der nächsten Zeile innerhalb der 40-Zeichen-Bildschirmbreite.

---

## Antwortfarbverhalten

Antworten durchlaufen Zustände, wenn neue Inhalte eintreffen.

| Zustand      | Farbe      | Bedingung                                |
| ------------ | ---------- | ---------------------------------------- |
| Aktuell      | Weiß       | Die zuletzt angezeigte Antwort           |
| Überholt     | Dunkelgrau | Eine neuere Antwort ist eingetroffen     |
| Abschließend | Weiß       | Keine weiteren Antworten folgen          |

### Zustandsübergänge

1. Eine Antwort erscheint unten im Ausgabebereich in Weiß.
2. Wenn eine neue Antwort angefügt wird, scrollt die vorherige Antwort nach oben und verblasst dabei in folgender Reihenfolge:
    - Hellgrau
    - Mittelgrau
    - Dunkelgrau
3. Dies wiederholt sich für jede weitere Antwort.
4. Die abschließende Antwort bleibt weiß.

### Schlüsselwort-Hervorhebung

- Gilt nur für die abschließende Antwort.
- Schlüsselwörter werden durch exakte Übereinstimmung aus der Frage des Benutzers extrahiert.
- Gängige Füllwörter (z. B. "the", "is", "a") werden vor dem Abgleich ausgeschlossen.
- Jede Übereinstimmung in der abschließenden Antwort wird gelb eingefärbt.
- Überholte Antworten haben keine Hervorhebung.

---

## Musik

Tribot+ spielt SID-Musik während der normalen Nutzung. Musik ist standardmäßig eingeschaltet und wird bei jedem Programmstart zurückgesetzt.

### Befehle

Die Musik wird über zwei Befehle gesteuert:

    /music        Musik ein- / ausschalten
    /tune 1-4     Titel auswählen (1 order 2)

### Verhalten

- Musik startet, wenn das Programm bereit für Eingaben ist.
- `/music` schaltet die Wiedergabe sofort ein oder aus.
- `/tune X` wechselt sofort zum gewählten Titel.
- Musik ausschalten stoppt die Wiedergabe sofort.
- Musik einschalten setzt den zuletzt gewählten Titel fort.
- Einstellungen werden bei jedem Programmstart zurückgesetzt: Musik ein, Titel 1.

### Titel

| Number | Title    | Autor                      |
| ------ | -------- | -------------------------- |
| 1      | Tune one | ne7/Triad/Rebels/Retroguru |
| 2      | Tune two | ne7/Triad/Rebels/Retroguru |

Titelbezeichnungen sind Platzhalter und werden aktualisiert, sobald die SID-Dateien ausgewählt sind.

---

## Zeichensatz

Tribot+ unterstützt zwei eigene Zeichensätze. Zeichensatz 1 ist standardmäßig aktiv und wird bei jedem Programmstart zurückgesetzt.

### Befehle

Der Zeichensatz wird über einen Befehl gesteuert:

    /char 1-2     Zeichensatz auswählen (1 oder 2)

### Verhalten

- `/char X` wechselt sofort zum gewählten Zeichensatz.
- Einstellungen werden bei jedem Programmstart zurückgesetzt: Zeichensatz 1.

### Zeichensätze

| Nummer | Name           | Autor     |
| ------ | -------------- | --------- |
| 1      | Highres_1x1_#8 | Tao/Triad |
| 2      | Highres_1x1_#6 | Tao/Triad |

Zeichensatzbezeichnungen sind Platzhalter und werden aktualisiert, sobald die Zeichensätze finalisiert sind.

---

## Befehle

Befehle werden im gleichen Eingabefeld wie Fragen eingegeben. Alle Befehle erfordern ein `/`-Präfix.

### Zurücksetzen

Löscht den Bildschirm. Kein Logo oder Text wird wiederhergestellt.

    /clear | /reset

### Beenden

Beendet Tribot+ und kehrt zu BASIC zurück (Warm-Reset).

    /exit | /quit/char 

### Hilfe

Zeigt eine Liste aller verfügbaren Befehle an. Jeder Eintrag zeigt den vollständigen Befehl, seinen Alias und eine kurze Beschreibung.

    /help | /man

### Info

Zeigt das Tribot+-Logo, einen kurzen Einführungstext und technische Details zur aktuellen Version. Verweist auf `/help` und `/man` für verfügbare Befehle.

    /info

### Musik

Schaltet die Musik ein und aus.

    /music

### Titel

Wählt einen von vier verfügbaren Titeln. X durch eine Zahl zwischen 1 und 4 ersetzen.

    /tune X

### Zeichensatz

Wählt einen von zwei verfügbaren Zeichensätzen. X durch 1 oder 2 ersetzen.

    /char X

---

## Offene Punkte

- Definition einer Datenbankübereinstimmung festlegen - Adder, Taper und Bepp
- Hardware-Prüfungen und technische Details für Stufe 2 definieren - Taper
- SID-Dateien auswählen und Titelbezeichnungen bestätigen - Taper