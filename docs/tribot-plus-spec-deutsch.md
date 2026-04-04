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

| Bereich      | Position         | Verhalten              |
| ------------ | ---------------- | ---------------------- |
| Ausgabebereich | Oberhalb des Trenners | Scrollt vertikal |
| Eingabefeld  | Unterhalb des Trenners | Fest, immer sichtbar |

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

| Element       | Farbe        |
| ------------- | ------------ |
| Trenner       | Dunkelgrau   |
| Eingabeaufforderung `>` | Mittelgrau |
| Platzhalter   | Dunkelgrau   |
| Benutzereingabe | Gelb       |

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

## Ausführungsablauf

Das Eingabefeld akzeptiert Fragen und Befehle.

### Übermittlung

Bei der Übermittlung wird die Eingabe in den Ausgabebereich verschoben und mit einem Präfix versehen:

    > Benutzerbefehl
    > Benutzerfrage?

Ein `?` wird angehängt, wenn die Eingabe eine Frage ist.

### Befehlserkennung

Bei der Übermittlung prüft Tribot+ zunächst, ob die Eingabe ein Befehl ist. Ein Befehl wird durch ein `/`-Präfix erkannt. Wird ein Befehl erkannt, wird er sofort ausgeführt. Es erfolg