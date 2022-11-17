INSERT INTO COURS (idCour,nomcour,nbMax,idM,dates,heure,duree)
values (1015,"Cours17",10,200,"2022-04-01","17:00:00","01:00:00");--(1001,"Cours1",1,200,"2022-01-01","08:00:00","02:00:00")

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (106,1,1015);

INSERT INTO MONITEUR (idM,nomM,prenomM)
VALUES (200,"Clavet","Fabrice");

INSERT INTO CLIENT (idC,nomC,prenomC,poidsC,cotisation)
VALUES (100,"Lazure","Arnaud",52,True);

INSERT INTO PONEY (idPo,poidPo,poidSup,nomPo,agePo)
VALUES (1,170,50,"Wolf",21);

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (101,1,1001); -- cours complet

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (103,4,1004); -- cotisation = false

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (103,4,1001); -- cours complet

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (100,1,1002); -- client trop lourd

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (103,1,1007); -- poney fatiguer besoin 1h repos


INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (109,1,1008);

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (107,1,1009);


