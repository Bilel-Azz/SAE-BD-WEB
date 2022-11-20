INSERT INTO MONITEUR (idM,nomM,prenomM)
VALUES (200,"Clavet","Fabrice"); -- deja cree 

INSERT INTO CLIENT (idC,nomC,prenomC,poidsC,cotisation)
VALUES (100,"Lazure","Arnaud",52,True); -- deja cree 

INSERT INTO PONEY (idPo,poidPo,poidSup,nomPo,agePo)
VALUES (1,170,50,"Wolf",21); -- deja cree 

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (101,1,1001); -- cours complet

 INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (103,4,1004); -- cotisation = false

INSERT INTO RESERVER (idC,idPo,idCour)
 VALUES (103,4,1001); -- cours complet

INSERT INTO RESERVER (idC,idPo,idCour)
 VALUES (100,1,1002); -- client trop lourd

INSERT INTO RESERVER (idC,idPo,idCour)
 VALUES (109,1,1010); -- poney déjà sur un cours

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (109,2,1002); -- poney deja utilise sur ce cours

INSERT INTO RESERVER (idC,idPo,idCour)
VALUES (109,10,1015); -- poney repos de 1h



