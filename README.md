# 99 Bottles of OOP - Deep dive, review and code samples

Code Samples zu 99 Bottles of OOP

## Kapitel-Review

### Kapitel 1

In Kapitel 1 werden vier verschiedene Lösungen entwickelt um den Song "99 bottles of beer" in Code auszudrücken.
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

Schlussendlich wird auch danach geschaut, welcher Code am verständlichsten ist und welcher die geringsten Entwicklungskosten hat.

Das Kapitel schliesst mit dem Ergebnis, dass die letzte Variante genannt "Shameless Green" die Beste ist, wohlwissend,
dass es wahrscheinlich ist, dass sie nicht gut geeignet ist Änderungen an den Anforderungen zu erfüllen.

Weitere Dokumente:  
[CMAP: Kapitel 1](CMaps/Chapter1.pdf)

### Kapitel 2

In diesem Kapitel geht es darum anhand des Beispiel-Codes "Shameless Green" das Konzept der Testgetriebenen Entwicklung (TDD)
zu erklären.
Hier wird vor allem vermittelt, wie man erste Tests entwickelt und dann immer weitere Tests erzeugt um am Ende den gesamten Code
mittels der Test zu vervollständigen. Dabei wird auch darauf geachtet, gute und sinnvolle Tests zu schreiben.

Weitere Dokumente:  
[CMAP: Kapitel 2](CMaps/Chapter2.pdf)

### Kapitel 3

Kapitel 3 führt dann die erwartete Änderung der Anforderungen ein. Es geht darum, nicht nur über Flaschen zu singen, sondern wenn
es um genau 6 FLaschen geht, den Begriff "Sixpack" zu verwenden.
Hier wird jetzt untersucht, ob der bestehende Code dem "Open/Close Principle" entspricht, was heisst, ob der Code geschlossen gegenüber Ändeurngen ist aber gleichzeitig offen für Erweiterungen.

Augenscheinlich ist das der bestehende Code nicht, und so wird untersucht, wie dieser mit Hilfe von "Refactoring" in diesen
Status gebracht werden kann. Es wird begonnen auffällige Dopplungen im Code zu eliminieren. Dabei werden Refactoring Techniken
erläutern, wie z.B.: systematisches graduelles Ändern ohne die Tests rot werden zu lassen, Flocking Rules um ähnliche Stellen gleich zu machen und damit die Doppelung zu entfernen. Hilfreich dabei ist ein ["Open/Close Flowchart"](charts/OpenCloseFlowchart.png).
Weiterhin wird erklärt wie man verborgene Konzepte im Code findet und benamt bzw. extrahiert.

Weitere Dokumente:  
[CMAP: Kapitel 3](CMaps/Chapter3.pdf)

### Kapitel 4

Dieser Teil des Buchs widmet sich vordergründig dem Üben der Refactoring Methoden und das verbesserte Erkennen verborgener
Konzepte sowie der Abstraktion von Codestellen. Interessant in diesem Kapitel ist, wie man Unterschiede in Gemeinsamkeiten
verwandeln kann. Es werden Namen anhand von Verantwortlichkeiten erkannt. Es wird auch kurz auf das "Liskov Substitution Principle" eingegangen. Zum Ende des Kapitels wird der Leser ermutigt, grössere Schritte im Refactoring zu unternehmen, da jetzt eine gewisse Erfahrung zugrunde gelegt wird.

Am Ende des Kapitels ist der Code von "Shameless Green" deutlich verändert, meiner Meinung nach weniger verständlich, aber von
Wiederholungen befreit. Die Autoren geben auch Hinweise darauf, dass Refactoring auch in die falsche Richtung führen kann oder
zeitweise den Code komplizierter machen kann.

Weitere Dokumente:  
[CMAP: Kapitel 4](CMaps/Chapter4.pdf)

### Kapitel 5

Kapitel 5 widmet sich weiteren Refactoring Schritten in Richtung der Implementierung der neuen Anforderungen. Bis jetzt ist die bestehende Implementierung immer noch nicht bereit für einfache Erweiterungen. Die bestehende Klasse wird mittels der "Class extract" Methode zerlegt um Verantwortlichkeiten aufzuteilen. Es wird auf Code Smells eingegangen die dadurch entstehen, das Teile der Implementierung nur auf übergebenen Argumenten basieren und somit auch extrahiert werden können.
Im weiteren Verlauf stellt sich heraus, dass die neue Klasse auf Basis von übergebenen "primitiven" Variablen arbeitet. Dies wird dahingehend geändert, dass auf Messaging umgestellt wird, was heisst, dass der Sender nicht mehr wissen muss, wie die Daten in der Empfängerklasse aufgebaut sind.
Ausserdem widmet sich der Abschnitt dem Thema Caching und versucht die Erzeugung von zu vielen Objekten in den Griff zu bekommen, mit der Konsequenz einer temporären Verletzung des "Liskov Substitution Principle".

Weitere Dokumente:  
[CMAP: Kapitel 5](CMaps/Chapter5.pdf)

### Kapitel 6

Dieser Abschnitt widmet sich dem Refactoring mit Ziel, die neue Anforderung zu implementieren. Auf dem Weg dorthin wurden neue Code Smells entdeckt und behoben. Weiterhin wurde die in Kapitel 5 erzeugt Verletzung des "Liskov Substitution Principles" elimniert. Es wurde eine Factory eingeführt, welche die benötigten Objekte zurückgibt und in diesem Zuge wurden auch Reste der primitiven Variablen entfernt und alles auf Objekte umgestellt. Nicht zuletzt kam Polymorphie in Gestalt von Vererbung zum Einsatz.

Weitere Dokumente:  
[CMAP: Kapitel 6](CMaps/Chapter6.pdf)

### Kapitel 7

Kapitel 7 widmet sich einer tieferen Betrachtung der Möglichkeiten einer Factory. Bezugnehmend auf die Einführung der Factory Methode in Kapitel 6 wird untersucht, welche verschiedenen Möglichkeiten es gibt Factories zu verwenden. Untersucht wird welche Möglichkeiten es gibt , die Contidional Logik in der aktuellen Factory Implementierung zu eliminieren. Eine Einführung was Factories sind und welchen Zweck sie verfolgen ist sehr aufschlussreich.
Viele Varianten der Verwendung von Factories resultieren in Code der die Intention welche Klasse warum verwendet wird etwas verschleiert.
Interessant ist das Konzept sich selbst registrierender Klassen. Dort aber ist die Erklärung etwas weniger verständlich und der Beispielcode meiner Meinung nach etwas zu abstrakt, da für mich nicht klar hervorgeht wann denn die Registrierung der einzelnen Subclasses erfolgt.
Das Fazit des Kapitels ist, dass es keine Patentrezept gibt, wie Factories am besten zu verwenden sind und es, wie immer, auf den Anwendungsfall ankommt.

Weitere Dokumente:  
[CMAP: Kapitel 7](CMaps/Chapter7.pdf)

### Kapitel 8

Hier geht es im ersten Teil um generelle Betrachtungen über die Ästhetik von Code und die Frage, ob Refactoring nur um Code ästhetischer zu machen gerechtfertig ist.
Danach gibt es eine neue Anforderung vom Kunden, die ein weiteres Refactoring ohnehin notwendig macht. Beim Umsetzen wird untersucht wie Abhängigkeiten, die im Code vorhanden sind aufgelöst oder umgekehrt werden können. Zur Anwendung kommt hier das "Dependency Inversion Principle". Es wird erklärt wie man die aktuelle Implementierung dahingehend ändert, dass das Programm auch mit anderen Liedtexten verwendet werden kann. Ein Kapitel widmet sich exklusiv dem "Law of Demeter".

Weitere Dokumente:  
[CMAP: Kapitel 8](CMaps/Chapter8.pdf)  
[CMAP: Law of Demeter](CMaps/LawOfDemeter.pdf)

### Kapitel 9

Das letzte Kapitel widmet sich erneut den Tests. Da im Verlaufe des Refactoring keine weiteren Tests hinzukamen, sind die bestehenden Tests jetzt nicht mehr im eigentlichen Sinne Unit Tests, sondern eher Integrationstests. Zu Anfang des Kapitels wird auf den Unterschied zwischen diesen beiden Arten eingegangen.
Danach werden Methoden und Beispiele präsentiert, den Code mit neuen Unit Tests zu untermauern. Im Laufe dieses Vorgehens werden auch noch weitere Refactoring Schritte unternommen, um einerseits den Code weiter zu abstrahieren und andererseits die Tests auch so zu strukturieren, dass sie als Dokumentation für den eigentlichen Code dienen können.

Weitere Dokumente:  
[CMAP: Kapitel 9](CMaps/Chapter9.pdf)
