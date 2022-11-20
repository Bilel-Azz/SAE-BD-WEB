INSERT INTO CLIENT (idC,nomC,prenomC,poidsC,cotisation)
VALUES (100,"Lazure","Arnaud",52,True),
       (101,"Faucher","Nicolas",35,True),
       (102,"Boivin","Helene",60,True),
       (103,"Morin","Aubert",46,False),
       (104,"Brisette","Madelenne",65,True),
       (105,"Musk","Elon",52,True),
       (106,"Tesla","Nicolas",35,True),
       (107,"Cena","Jhon",60,True),
       (108,"Roronoa","Zoro",46,True),
       (109,"Uzumaki","Naruto",35,True);
         

INSERT INTO PONEY (idPo,poidPo,poidSup,nomPo,agePo)
VALUES (1,170,50,"Wolf",21),
       (2,210,65,"Buddy",28),
       (3,190,81,"Peak",32),
       (4,180,88,"Poney1",28),
       (5,200,76,"Poney2",29),
       (6,220,50,"Poney3",26),
       (7,230,50,"Poney4",32),
       (8,240,90,"Poney5",38),
       (9,250,80,"Poney6",15),
       (10,260,87,"Poney7",25),
       (11,270,90,"Poney8",28),
       (12,120,67,"Poney9",12),
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

INSERT INTO COURS (idCour,nomcour,nbMax,idM,dates,heure,duree)
values (1001,"Cours1",1,200,"2022-01-01","08:00:00","02:00:00"),
       (1002,"Cours2",10,201,"2022-01-01","10:00:00","01:00:00"),
       (1003,"Cours3",5,202,"2022-01-01","15:00:00","02:00:00"),
       (1004,"Cours4",10,203,"2022-03-01","09:00:00","01:00:00"),
       (1005,"Cours5",4,204,"2022-03-01","11:00:00","01:00:00"),
       (1006,"Cours6",10,205,"2022-03-01","12:00:00","01:00:00"),
       (1007,"Cours7",3,206,"2022-04-01","08:00:00","02:00:00"),
       (1008,"Cours8",10,207,"2022-04-01","14:00:00","01:00:00"),
       (1009,"Cours9",1,208,"2022-04-01","15:00:00","01:00:00"),
       (1010,"Cours10",10,209,"2022-04-01","17:00:00","01:00:00"),
       (1011,"Cours11",10,204,"2022-04-01","16:00:00","02:00:00"),
       (1012,"Cours12",1,208,"2022-05-01","13:00:00","01:00:00"),
       (1013,"Cours13",10,209,"2022-05-01","14:00:00","02:00:00"),
       (1014,"Cours14",10,204,"2022-05-01","15:00:00","01:00:00"),
       (1015,"Cours15",10,201,"2022-05-01","17:00:00","01:00:00");

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (100,2,1001),
       (100,10,1008),
       (100,11,1009),
       (101,8,1002),
       (102,3,1003),
       (101,4,1004),
       (100,5,1005),
       (108,6,1006),
       (106,7,1007),
       (107,11,1008),
       (109,10,1010),
       (109,6,1011),
       (108,9,1012),
       (109,10,1013),
       (109,3,1014),
       (109,5,1015);

-- Exemple d'insert qui ne marche pas grace au contrainte de cle primaire

-- INSERT INTO RESERVER (idC,idPo,idCour)
-- VALUES (100,1,1001),
--        (109,1,1011);
