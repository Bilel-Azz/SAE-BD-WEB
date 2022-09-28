CREATE TABLE CLIENT(
    idC INT PRIMARY KEY,
    nomC VARCHAR(30),
    prenomC VARCHAR(30),
    poidsC INT,
    cotisation BOOLEAN,
);

CREATE TABLE PONEY (
    idPo INT PRIMARY KEY,
    poidPo INT,
    poidSup INT,
    nomPo VARCHAR(30),
    agePo INT

);
CREATE TABLE MONITEUR (
    idM INT PRIMARY KEY,
    nomM VARCHAR(30),
    prenomM VARCHAR(30)
);

CREATE TABLE COURS (
    idCour INT PRIMARY KEY,
    nomcour VARCHAR(30),
    idM INT , 
    dates DATE,
    heure TIME check (heure > '08:00:00' and heure < '18:00:00'),
    duree TIME check (duree > '02:00:00'),
);

CREATE TABLE RESERVER (
    idC INT,
    idPo INT,
    idCour INT,
    PRIMARY KEY (idC, idPo, idCour)

);

ALTER TABLE COURS ADD FOREIGN KEY (idM) REFERENCES MONITEUR(idM);
ALTER TABLE RESERVER ADD FOREIGN KEY (idC) REFERENCES CLIENT(idC);
ALTER TABLE RESERVER ADD FOREIGN KEY (idPo) REFERENCES PONEY(idPo);
ALTER TABLE RESERVER ADD FOREIGN KEY (idCour) REFERENCES COURS(idCour)


INSERT INTO CLIENT (idC,nomC,prenomC,poidC,cotisation)
VALUES (100,"Lazure","Arnaud",52,True),
       (101,"Faucher","Nicolas",35,True),
       (102,"Boivin","Helene",60,True),
       (103,"Morin","Aubert",46,False),
       (104,"Brisette","Madelenne",65,False);
       (105,"Musk","Elon",52,True),
       (106,"Tesla","Nicolas",35,True),
       (107,"Cena","Jhon",60,True),
       (108,"Roronoa","Zoro",46,False),
       (109,"Uzumaki","Naruto",65,False);
         

INSERT INTO PONEY (idPo,poidP,poidSup,nomPo,agePo)
VALUES (1,170,50,"Wolf",21),
       (2,210,65,"Buddy",28),
       (3,190,50,"Peak",32),
       (4,180,50,"Poney1",28),
       (5,200,50,"Poney2",29),
       (6,220,50,"Poney3",26),
       (7,230,50,"Poney4",32),
       (8,240,50,"Poney5",38),
       (9,250,50,"Poney6",15),
       (10,260,50,"Poney7",25),
       (11,270,50,"Poney8",28),
       (12,120,50,"Poney9",12),
       (13,290,50,"Poney10",39),
       (14,300,50,"Poney11",25),
       (15,310,50,"Poney12",24),
       (16,320,50,"Poney13",23),
       (17,196,50,"Poney14",22),
       (18,340,50,"Poney15",18),
       (19,100,50,"Poney16",5),
       (20,360,50,"Poney17",29),
       (21,385,50,"Poney18",29),
       (22,360,50,"Poney19",27),
       (23,320,50,"Poney20",30),
       (24,149,50,"Poney21",17),
       (25,186,50,"Poney22",18),
       (26,185,50,"Poney23",20),
       (27,216,50,"Poney24",21),
       (28,230,50,"Poney25",22),
       (29,124,50,"Poney26",13),
       (30,165,50,"Poney27",27);

INSERT INTO MONITEUR (idM,nomM,prenomM)
VALUES (200,"Clavet","Fabrice"),
       (201,"Woods","Frank"),
       (202,"Morgan","Arthur"),
       (203,"Clinton","Franklin"),
       (204,"DeSanta","Michael"),
       (205,"Phillips","Trevor"),
       (206,"Price","Jhon"),
       (207,"Simon","Ghoast"),
       (208,"Makarov","Vladimir"),
       (209,"Mason","Alex");

INSERT INTO COURS (idCour,nomcour,idM,dates,heure,duree)
values (1001,"Cours1",300,"2022-10-01","08:00:00","02:00:00"),
       (1002,"Cours2",301,"2022-10-01","10:00:00","01:30:00"),
       (1003,"Cours3",302,"2022-10-01","12:00:00","01:45:00"),
       (1004,"Cours4",303,"2022-10-01","14:00:00","02:00:00"),
       (1005,"Cours5",304,"2022-10-01","16:00:00","01:00:00"),
       (1006,"Cours6",305,"2022-10-01","18:00:00","01:20:00"),
       (7,"Cours7",306,"2022-10-01","08:00:00","02:00:00"),
       (8,"Cours8",307,"2022-10-01","10:00:00","02:00:00"),
       (9,"Cours9",308,"2022-10-01","12:00:00","02:00:00"),
       (10,"Cours10",309,"2022-10-01","14:00:00","02:00:00"),
       (11,"Cours11",310,"2022-10-01","16:00:00","02:00:00"),

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES ()

















