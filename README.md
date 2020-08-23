# CodeKata_99_Bottles

Code Katas zu 99 bottles of beer

## Kapitel-Review

### Kapitel 1

In Kapitel 1 werden 4 verschiedene Lösungen entwickelt um den Song "99 Bottles of beer" in Code auszudrücken
Nachdem die 4 Varianten erzeugt wurden, wird untersucht wie sich die unterschiedlichen Alternativen in Bezug auf
4 Schlüsselfragen verhalten:

- Wie viele Varianten gibt es innerhalb der Verse ?
- Welche Verse sind sich am ähnlichsten ?
- Welche Verse sind am unterschiedlichsten ?
- Anhand welcher Regel wird ermittelt, welcher Verse benutzt werden soll?

Weiterhin wir danhand einiger Metriken der Code analysiert.

- Anzahl Codezeilen (LoC)
- ABC
- Cyclomatic complexity

Schlussendlich wird auch danach geschaut, welcher COde am verständlichsten ist und welcher
die geringsten Entwicklungskosten hat.

Das Kapitel schliesst mit dem Ergebnis, dass die letzte Variante genannt "Shameless Green" die beste ist, wohlwissend,
dass es wahrscheinlich ist, dass sie nicht gut geeignet ist, Änderungen an den Anforderungen zu erfüllen.

### Kapitel 2

In diesem Kapitel geht es darum anhand des Beispiel-Codes "Shameless Green" das Konzet der Testgetriebenen Entwicklung (TDD)
zun erklären.
Hier wird vor allem vermttelt, wie man erste Tests entwickelt und dann immer weitere Tests erzeugt um am Ende den gesamten Code
mittels der Test vervollständigt. Dabei wird auch darauf geachtet, gute und sinnvolle Tests zu schreiben.

### Kapitel 3

Kapitel 3 führt dann die erwartete Änderung der Anforderungen ein. Es geht darum nicht nur über Flaschen zu singen, sondern wenn
es um 6 FLaschen geht, dann den Begriff "Sixpack" zu verwenden.
Hier wird jetzt untersucht, ob der bestehende Code dem "Open/Close Principle" entspricht, was heisst, ob der Code geschlossen gegenüber Ändeurngen ist aber gleichzeitig offen für Erweiterungen.

Augenscheinlich ist das der bestehende Code nicht, und so wird untersucht, wie dieser mit Hilfe von "Refactoring" in diesen
Status gebracht werden kann. Es wird begonnen auffällige Dopplungen im Code zu eliminieren. Dabei werden Refactoring Techniken
erläutern, wie z.B.: systematisches graduelles Ändern ohne die Tests rot werden zu lassen, Flocking Rules um ähnliche Stellen gleich zu machen und damit die Doppelung zu entfernen.
Weiterhin wird erklärt wie man verborgene Konzeote im Code findet und benamt bzw. extrahiert.

### Kapitel 4

Dieser Teil des Buchs widmet sich vordergründig um das Üben der Refactoring Methoden und das verbesserte Erkennen verborgener
Konzepte sowie der Abstraktion von Codestellen. Interessant in diesem Kapitel, wie man Unterschiede in Gemeinsamkeiten
verwandeln kann. Es werden Namen anhand von Verantwortlichkeiten erkannt. Es wird auch kurz auf das "Liskov Substitution Principle" eingegangen. Zum Ende des Kapitels wird der Leser ermutigt, grössere Schritte im Refactoring zu unternehmen, da jetzt eine gewisse Erfahrung zugrunde gelegt wird.

Am Ende des Kapitels ist der Code von "Shameless Green" deutlich verändert, meiner Meinung nach weniger verständlich, aber von
Wiederholungen befreit. Die Autoren geben auch Hinweise darauf, dass Refaxctoring auch in die falsche Richtung führen kann oder
zeitweise den Code komplizierter machen kann.
