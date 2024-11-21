--- Chronologie der genutzten SQL-Befehle für die Erstellung einer Spieler-Datenbank von hattrick.org 
-- Tabellennamen sind in Anführungszeichen(")

-- Erstellung der Tabelle "Spieler_Hilfe", die als eine Hilfs-Tabelle dient für weitere Schritte

CREATE TABLE if not exists Spieler_Hilfe (
Nationalität VARCHAR(255),
Name VARCHAR(255),
Spezialität VARCHAR(255),
Verletzungen REAL,
Gelbe_Karten REAL,
Alter SMALLINT,
Tage SMALLINT,
TSI INTEGER,
Gehalt INTEGER,
Wochen_im_Verein SMALLINT,
Erfahrung SMALLINT,
Führungsqualitäten SMALLINT,
Form SMALLINT,
Kondition SMALLINT,
Torwart SMALLINT,
Verteidigung SMALLINT,
Spielaufbau SMALLINT,
Flügelspiel SMALLINT,
Passspiel SMALLINT,
Torschuss SMALLINT,
Standards SMALLINT
);


-- Einfügen der Daten in die "Spieler_Hilfe" Tabelle von der vorbereiteten Csv-Datei

COPY Spieler_Hilfe FROM 'C:\Users\sebhe\Desktop\Python-Jupyter-Notebook\Datenbankerstellung\all_players.csv' DELIMITER ','CSV HEADER;





-- Erstellung der Tabelle "Nationalität" zu der später referenziert werden soll

Create Table if not exists Nationalität(
	id serial,
	Nationalität_Name varchar(255) unique not null,
	primary key(id)
);


-- Einfügen der vorhandenen Nationalitäten (ohne Replikation) aus der Tabelle "Spieler_Hilfe" 

INSERT INTO Nationalität (Nationalität_Name)
SELECT DISTINCT Nationalität FROM Spieler_Hilfe;





-- Erstellung der Tabelle "Spezialität" zu der später referenziert werden soll

Create Table if not exists Spezialität(
	id serial,
	Spezialität_Name varchar(255) unique,
	primary key(id)
);

-- Einfügen der vorhandenen Spezialitäten (ohne Replikation) aus der Tabelle "Spieler_Hilfe" 

INSERT INTO Spezialität (Spezialität_Name)
SELECT DISTINCT Spezialität FROM Spieler_Hilfe;



-- Erstellung der relationalen Tabelle "Spieler" inklusive ein paar Anpassungen

CREATE TABLE if not exists Spieler (
id serial, 
Name VARCHAR(255) unique not null,
Nationalität VARCHAR(255) not null,
Nationalität_id smallint references Nationalität(id) on delete cascade,
Spezialität VARCHAR(255),
Spezialität_id smallint references Spezialität(id) on delete cascade,
Verletzungen REAL,
Gelbe_Karten REAL,
Alter SMALLINT not null,
Tage SMALLINT not null,
TSI INTEGER not null,
Gehalt INTEGER not null,
Wochen_im_Verein SMALLINT not null,
Erfahrung SMALLINT not null,
Führungsqualitäten SMALLINT not null,
Form SMALLINT not null,
Kondition SMALLINT not null,
Torwart SMALLINT not null,
Verteidigung SMALLINT not null,
Spielaufbau SMALLINT not null,
Flügelspiel SMALLINT not null,
Passspiel SMALLINT not null,
Torschuss SMALLINT not null,
Standards SMALLINT not null,
primary key(id)
);


-- Kopieren der Daten aus der Tabelle "Spieler_Hilfe" in die Tabelle "Spieler"

INSERT INTO Spieler (Name, Nationalität, Spezialität, Verletzungen, Gelbe_Karten, Alter, 
Tage, TSI, Gehalt, Wochen_im_Verein, Erfahrung, Führungsqualitäten, Form, Kondition, 
Torwart, Verteidigung, Spielaufbau, Flügelspiel, Passspiel, Torschuss, Standards) 
SELECT Name, Nationalität, Spezialität, Verletzungen, Gelbe_Karten, Alter, Tage, 
TSI, Gehalt, Wochen_im_Verein, Erfahrung, Führungsqualitäten, Form, Kondition, 
Torwart, Verteidigung, Spielaufbau, Flügelspiel, Passspiel, Torschuss, Standards 
FROM Spieler_Hilfe;

-- Die Hilfs-Tabelle "Spieler_Hilfe" wird nicht mehr benötigt und wird gelöscht

Drop Table Spieler_Hilfe;





--- Das Referenzieren
--  Einfügen der entsprechenden Fremdschlüssel zu der Tabelle "Nationalität" in die Spalte Nationalität_id der Tabelle "Spieler"

Update Spieler set Nationalität_id = (select Nationalität.id from Nationalität where Nationalität.Nationalität_Name = Spieler.Nationalität);

--  Einfügen der entsprechenden Fremdschlüssel zu der Tabelle "Spezialität" in die Spalte Spezialität_id der Tabelle "Spieler"

Update Spieler set Spezialität_id = (select Spezialität.id from Spezialität where Spezialität.Spezialität_Name = Spieler.Spezialität); 


-- Durch die Referenzen können die Spalten mit den Namen Nationalität und Spezialität gelöscht werden aus der Tabelle "Spieler"

Alter Table Spieler drop column Nationalität;
Alter Table Spieler drop column Spezialität;






-- Ansicht aller Spieler der Datenbank über alle Tabellen mithilfe verschiedener Join-Operatoren  

Select * from Spieler 
	join Nationalität on Spieler.Nationalität_id = Nationalität.id 
	left join Spezialität on Spieler.Spezialität_id = Spezialität.id;



