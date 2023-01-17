

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
       (1,"admin","admin",0,True),
       (109,"Uzumaki","Naruto",35,True);

INSERT INTO UTILISATEUR (idU,emailU,passwordU,idC,adminn) VALUES (1,"admin@test.com","admin",1,true) ;
INSERT INTO UTILISATEUR (idU,emailU,passwordU,idC,adminn) VALUES (2,"test@test.com","test",105,False);
INSERT INTO UTILISATEUR (idU,emailU,passwordU,idC,adminn) VALUES (3,"test1@test.com","test1",100,False);


INSERT INTO PONEY (idPo,poidPo,poidSup,nomPo,agePo,descriptionPo)
VALUES (1,170,50,"Wolf",21,"Ce magnifique cheval de race Arabe est un athlète accompli dans le domaine du saut d'obstacles. Il possède une agilité remarquable et une intelligence exceptionnelle qui lui permettent de réaliser des parcours complexes avec une précision incroyable. Il a remporté de nombreux prix dans des compétitions de haut niveau et serait un atout formidable pour tout cavalier expérimenté cherchant à se lancer dans la compétition.")
       (2,210,65,"Buddy",28,"Ce doux et fiable cheval de race Quarter Horse est le compagnon idéal pour les longues randonnées à travers les collines et les forêts. Il possède une endurance exceptionnelle et une personnalité calme et affectueuse qui le rendent parfait pour les cavaliers de tous niveaux. Il aime les balades tranquilles et les sorties en groupe, il est donc également idéal pour les sorties en famille."),
       (3,190,81,"Peak",32,"Ce mignon poney Welsh est un véritable athlète dans le domaine de la compétition de dressage. Il possède une incroyable souplesse et une grande capacité d'apprentissage qui lui permettent de réaliser des mouvements complexes avec une grande précision. Il est idéal pour les cavaliers expérimentés cherchant à se lancer dans la compétition de dressage de haut niveau."),
       (4,180,88,"Poney1",28,"Ce charmant poney Shetland est le compagnon idéal pour les balades tranquilles et les petites sorties en forêt. Il est très calme et affectueux, il aime les caresses et les câlins. Il est idéal pour les enfants et les cavaliers débutants. Il est également parfait pour les activités équestres de loisirs comme les petites courses et les sorties en famille."),
       (5,200,76,"Poney2",29,"Ce cheval est génial"),
       (6,220,50,"Poney3",26,"Ce cheval est génial"),
       (7,230,50,"Poney4",32,"Ce cheval est génial"),
       (8,240,90,"Poney5",38,"Ce cheval est génial"),
       (9,250,80,"Poney6",15,"Ce cheval est génial"),
       (10,260,87,"Poney7",25,"Ce cheval est génial"),
       (11,270,90,"Poney8",28,"Ce cheval est génial"),
       (12,120,67,"Poney9",12,"Ce cheval est génial"),
       (13,290,50,"Poney10",39,"Ce cheval est génial"),
       (14,300,50,"Poney11",25,"Ce cheval est génial"),
       (15,310,50,"Poney12",24,"Ce cheval est génial"),
       (16,320,50,"Poney13",23,"Ce cheval est génial"),
       (17,196,50,"Poney14",22,"Ce cheval est génial"),
       (18,340,50,"Poney15",18,"Ce cheval est génial"),
      

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
