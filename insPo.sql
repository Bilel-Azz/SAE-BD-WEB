

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
VALUES (1,170,50,"Wolf",21,"Ce magnifique cheval de race Arabe est un athlète accompli dans le domaine du saut d'obstacles. Il possède une agilité remarquable et une intelligence exceptionnelle qui lui permettent de réaliser des parcours complexes avec une précision incroyable. Il a remporté de nombreux prix dans des compétitions de haut niveau et serait un atout formidable pour tout cavalier expérimenté cherchant à se lancer dans la compétition."),
       (2,210,65,"Buddy",28,"Ce doux et fiable cheval de race Quarter Horse est le compagnon idéal pour les longues randonnées à travers les collines et les forêts. Il possède une endurance exceptionnelle et une personnalité calme et affectueuse qui le rendent parfait pour les cavaliers de tous niveaux. Il aime les balades tranquilles et les sorties en groupe, il est donc également idéal pour les sorties en famille."),
       (3,190,81,"Peak",32,"Ce mignon poney Welsh est un véritable athlète dans le domaine de la compétition de dressage. Il possède une incroyable souplesse et une grande capacité d'apprentissage qui lui permettent de réaliser des mouvements complexes avec une grande précision. Il est idéal pour les cavaliers expérimentés cherchant à se lancer dans la compétition de dressage de haut niveau."),
       (4,180,88,"Sable",28,"Ce charmant poney Shetland est le compagnon idéal pour les balades tranquilles et les petites sorties en forêt. Il est très calme et affectueux, il aime les caresses et les câlins. Il est idéal pour les enfants et les cavaliers débutants. Il est également parfait pour les activités équestres de loisirs comme les petites courses et les sorties en famille."),
       (5,200,76,"Vent",29,"Ce cheval est génial"),
       (6,220,50,"Cendre",26,"Ce cheval est génial"),
       (7,230,50,"Brise",32,"Ce cheval est génial"),
       (8,240,90,"Zephyr",38,"Ce cheval est génial"),
       (9,250,80,"Tempest",15,"Ce cheval est génial"),
       (10,260,87,"Mustang",25,"Ce cheval est génial"),
       (11,270,90,"Sabre",28,"Ce cheval est génial"),
       (12,120,67,"Rogue",12,"Ce cheval est génial"),
       (13,290,50,"Nova",39,"Ce cheval est génial"),
       (14,300,50,"Thunder",25,"Ce cheval est génial"),
       (15,310,50,"Paladin",24,"Ce cheval est génial"),
       (16,320,50,"Nomade",23,"Ce cheval est génial"),
       (17,196,50,"Phoenix",22,"Ce cheval est génial"),
       (18,340,50,"Cimarron",18,"Ce cheval est génial");
      

INSERT INTO MONITEUR (idM,nomM,prenomM,descriptionMo)
VALUES (200,"Clavet","Fabrice","Ce moniteur expérimenté qui offre des leçons de dressage et de saut d'obstacles pour tous les niveaux de cavaliers. Il possède une grande expertise dans la formation des chevaux et est passionné par l'équitation."),
       (201,"Woods","Frank","Ce moniteur est un compétiteur professionnel avec des années d'expérience dans l'entraînement des chevaux et des cavaliers. Il offre des leçons personnalisées pour atteindre vos objectifs de compétition."),
       (202,"Morgan","Arthur","Ce moniteur est un instructeur qualifié qui s'adapte à tous les niveaux et styles d'équitation. Il enseigne des techniques de dressage, de saut d'obstacles, et de randonnée équestre pour les cavaliers débutants et avancés."),
       (203,"Clinton","Franklin","Ce moniteur est expérimenté et offre des leçons de dressage et de saut d'obstacles pour tous les niveaux de cavaliers. Il possède une grande expertise dans la formation des chevaux et est passionné par l'équitation."),
       (204,"DeSanta","Michael","Excellent moniteur"),
       (205,"Phillips","Trevor","Excellent moniteur"),
       (206,"Price","Jhon","Excellent moniteur"),
       (207,"Simon","Ghoast","Excellent moniteur"),
       (208,"Makarov","Vladimir","Excellent moniteur"),
       (209,"Mason","Alex","Excellent moniteur");

INSERT INTO COURS (idCour,nomcour,nbMax,idM,dates,heure,duree)
values (1001,"Promenade",1,200,"2022-01-01","08:00:00","02:00:00"),
       (1002,"Saut d'obstacle",10,201,"2022-01-01","10:00:00","01:00:00"),
       (1003,"Dressage",5,202,"2022-01-01","15:00:00","02:00:00"),
       (1004,"Promenade",10,203,"2022-03-01","09:00:00","01:00:00"),
       (1005,"Saut d'obstacle",4,204,"2022-03-01","11:00:00","01:00:00"),
       (1006,"Dressage",10,205,"2022-03-01","12:00:00","01:00:00"),
       (1007,"Promenade",3,206,"2022-04-01","08:00:00","02:00:00"),
       (1008,"Saut d'obstacle",10,207,"2022-04-01","14:00:00","01:00:00"),
       (1009,"Dressage",1,208,"2022-04-01","15:00:00","01:00:00"),
       (1010,"Promenade",10,209,"2022-04-01","17:00:00","01:00:00"),
       (1011,"Saut d'obstacle",10,204,"2022-04-01","16:00:00","02:00:00"),
       (1012,"Dressage",1,208,"2022-05-01","13:00:00","01:00:00"),
       (1013,"Promenade",10,209,"2022-05-01","14:00:00","02:00:00"),
       (1014,"Saut d'obstacle",10,204,"2022-05-01","15:00:00","01:00:00"),
       (1015,"Dressage",10,201,"2022-05-01","17:00:00","01:00:00");

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
