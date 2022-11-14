INSERT INTO COURS (idCour,nomcour,nbMax,idM,dates,heure,duree)
values (1001,"Cours1",1,200,"2019-01-01","08:00:00","02:00:00");

INSERT INTO MONITEUR (idM,nomM,prenomM)
VALUES (200,"Clavet","Fabrice");

INSERT INTO CLIENT (idC,nomC,prenomC,poidsC,cotisation)
VALUES (100,"Lazure","Arnaud",52,True);

INSERT INTO PONEY (idPo,poidPo,poidSup,nomPo,agePo)
VALUES (1,170,50,"Wolf",21);

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (103,4,1004); -- cotisation = false

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (101,1,1001)
