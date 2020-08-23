# CodeKata_99_Bottles

Code Katas zu 99 bottles of beer

## Kapitel-Review

### Kapitel 1

In Kapitel 1 werden vier verschiedene Lösungen entwickelt um den Song "99 Bottles of beer" in Code auszudrücken
Nachdem die vier Varianten erzeugt wurden, wird untersucht wie sich die unterschiedlichen Alternativen in Bezug auf
folgende Schlüsselfragen verhalten:

- Wie viele Varianten gibt es innerhalb der Verse ?
- Welche Verse sind sich am ähnlichsten ?
- Welche Verse sind am unterschiedlichsten ?
- Anhand welcher Regel wird ermittelt, welcher Vers benutzt werden soll?

Weiterhin wird anhand einiger Metriken der Code analysiert.

- Anzahl Codezeilen (LoC)
- ABC
- Cyclomatic complexity

Schlussendlich wird auch danach geschaut, welcher Code am verständlichsten ist und welcher
die geringsten Entwicklungskosten hat.

Das Kapitel schliesst mit dem Ergebnis, dass die letzte Variante genannt "Shameless Green" die Beste ist, wohlwissend,
dass es wahrscheinlich ist, dass sie nicht gut geeignet ist Änderungen an den Anforderungen zu erfüllen.

### Kapitel 2

In diesem Kapitel geht es darum anhand des Beispiel-Codes "Shameless Green" das Konzet der Testgetriebenen Entwicklung (TDD)
zu erklären.
Hier wird vor allem vermittelt, wie man erste Tests entwickelt und dann immer weitere Tests erzeugt um am Ende den gesamten Code
mittels der Test zu vervollständigen. Dabei wird auch darauf geachtet, gute und sinnvolle Tests zu schreiben.

### Kapitel 3

Kapitel 3 führt dann die erwartete Änderung der Anforderungen ein. Es geht darum nicht nur über Flaschen zu singen, sondern wenn
es um genau 6 FLaschen geht, den Begriff "Sixpack" zu verwenden.
Hier wird jetzt untersucht, ob der bestehende Code dem "Open/Close Principle" entspricht, was heisst, ob der Code geschlossen gegenüber Ändeurngen ist aber gleichzeitig offen für Erweiterungen.

Augenscheinlich ist das der bestehende Code nicht, und so wird untersucht, wie dieser mit Hilfe von "Refactoring" in diesen
Status gebracht werden kann. Es wird begonnen auffällige Dopplungen im Code zu eliminieren. Dabei werden Refactoring Techniken
erläutern, wie z.B.: systematisches graduelles Ändern ohne die Tests rot werden zu lassen, Flocking Rules um ähnliche Stellen gleich zu machen und damit die Doppelung zu entfernen. HIlfreich dabei ist ein "Open/Close Flowchart".
Weiterhin wird erklärt wie man verborgene Konzepte im Code findet und benamt bzw. extrahiert.

### Kapitel 4

Dieser Teil des Buchs widmet sich vordergründig dem Üben der Refactoring Methoden und das verbesserte Erkennen verborgener
Konzepte sowie der Abstraktion von Codestellen. Interessant in diesem Kapitel ist, wie man Unterschiede in Gemeinsamkeiten
verwandeln kann. Es werden Namen anhand von Verantwortlichkeiten erkannt. Es wird auch kurz auf das "Liskov Substitution Principle" eingegangen. Zum Ende des Kapitels wird der Leser ermutigt, grössere Schritte im Refactoring zu unternehmen, da jetzt eine gewisse Erfahrung zugrunde gelegt wird.

Am Ende des Kapitels ist der Code von "Shameless Green" deutlich verändert, meiner Meinung nach weniger verständlich, aber von
Wiederholungen befreit. Die Autoren geben auch Hinweise darauf, dass Refactoring auch in die falsche Richtung führen kann oder
zeitweise den Code komplizierter machen kann.

### Kapitel 5

Kapitel 5 widmet sich weiteren Refactoring Schritten in Richtung der Implementierung der neuen Anforderungen. Bis jetzt ist die bestehende Implementierung immer noch nicht bereit für einfache Erweiterungen. Die bestehende Klasse wird mittels der "Class extract" Methode zerlegt um Verantwortlichkeiten aufzuteilen. Es wird auf Code Smells eingegangen die dadurch entstehen, das Teile der Implementierung nur auf übergebenen Argumenten basieren und somit auch extrahiert werden können.
Im weiteren Verlauf stellt sich heraus, dass die neue Klasse auf Basis von übergebenen "primitiven" Variablen arbeitet. Dies wird dahingehend geändert, dass auf Messaging umgestellt wird, was heisst, dass der Sender nicht mehr wissen muss, wie die Daten in der Empfängerklasse aufgebaut sind.
Ausserdem widmet sich der Abschnitt dem Thema Caching und versucht die Erzeugung von zu vielen Objekten in den Griff zu bekommen, mit der Konsequenz einer temporären Verletzung des "Liskov Substitution Principle".

### Kapitel 6

### Kapitel 7

### Kapitel 8

### Kapitel 9
