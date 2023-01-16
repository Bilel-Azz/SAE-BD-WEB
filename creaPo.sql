DROP TABLE RESERVER;
DROP TABLE PONEY;
DROP TABLE COURS;
DROP TABLE MONITEUR;
DROP TABLE UTILISATEUR;
DROP TABLE CLIENT;



CREATE TABLE CLIENT(
    idC INT PRIMARY KEY AUTO_INCREMENT,
    nomC VARCHAR(30),
    prenomC VARCHAR(30),
    poidsC INT,
    cotisation BOOLEAN
);


CREATE TABLE UTILISATEUR (
    idU INT PRIMARY KEY AUTO_INCREMENT,
    emailU VARCHAR(30),
    passwordU VARCHAR(30),
    idC INT,
    adminn BOOLEAN
);

CREATE TABLE PONEY (
    idPo INT PRIMARY KEY AUTO_INCREMENT,
    poidPo INT,
    poidSup INT,
    nomPo VARCHAR(30),
    agePo INT check (agePo >= 0 and agePo <= 40)

);
CREATE TABLE MONITEUR (
    idM INT PRIMARY KEY AUTO_INCREMENT,
    nomM VARCHAR(30),
    prenomM VARCHAR(30)
);

CREATE TABLE COURS (
    idCour INT PRIMARY KEY AUTO_INCREMENT,
    nomcour VARCHAR(30),
    idM INT ,
    nbMax int check (nbMax >= 0 and nbMax <= 10), 
    dates DATE,
    heure TIME check (heure >= '08:00:00' and heure <= '18:00:00'),
    duree TIME check (duree <= '02:00:00')
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
ALTER TABLE RESERVER ADD FOREIGN KEY (idCour) REFERENCES COURS(idCour);
ALTER TABLE UTILISATEUR ADD FOREIGN KEY (idC) REFERENCES CLIENT(idC);

-- Contrainte mise en place :
    -- 1. un poney ne peut pas participer à un cours s'il à déjà participé à un cours de 2h juste avant le cours en question et qu'il n'a pas encore effectuer son repos de 1h
    -- 2. si un client n'a pas payé sa cotisation, il ne peut pas participer à un cours
    -- 3. un cours ne peut pas avoir plus de partcipant que le nombre de places prévu pour celui-ci
    -- 4. un client qui existe déjà ne peut pas être ajouté
    -- 5. un moniteur ne peut pas être ajouté s'il existe déjà
    -- 6. un poney ne peut pas être ajouté s'il existe déjà
    -- 7. une reservation ne peut pas etre faite si le client choisi un poney qui ne peut pas supporter son poids
    -- 8. une reservation ne peut pas etre faite si un poney participe à un cour entre 2 cour
    -- 9. une reservation ne peut pas etre faite si un poney participe deja au cours en question
    

DROP TRIGGER if exists verificationReservation;
DROP TRIGGER if exists verificationMoniteur;
DROP TRIGGER if exists verificationClient;
DROP TRIGGER if exists verificationCours;
DROP TRIGGER if exists verificationPoney;

