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
    idC INT
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

delimiter |
create or replace function getNbPlacesReservees(idC int) returns int
begin
    declare nbPlaces int;
    select count(*) into nbPlaces from RESERVER where idCour = idC;
    return nbPlaces;
end |
delimiter ;

delimiter |
create or replace function getNbPlacesCoursMax(idC int) returns int
begin
    declare nbPlaceMax int;
    select nbMax into nbPlaceMax from COURS where idCour = idC;
    return nbPlaceMax;
end |
delimiter ;

delimiter |
create or replace function getPoidSupportablePoney(idPoney int) returns VARCHAR(200)
begin
    declare poidSuportable int;
    select poidSup into poidSuportable from PONEY where idPo = idPoney;
    return poidSuportable;
end |
delimiter ;


delimiter |
create or replace function getPoidClient(idCli int) returns VARCHAR(200)
begin
    declare poidCli int;
    select poidsC into poidCli from CLIENT where idC = idCli;
    return poidCli;
end |
delimiter ;

delimiter |
create or replace function getSiPoneyDejaUtilise(pon int,datees date,idC int) returns int
begin
    declare idDuPoney int;
    select idPo into idDuPoney from RESERVER natural join COURS where idPo = pon and dates = datees and idCour = idC;
    return idDuPoney;
end |
delimiter ;

select getSiPoneyDejaUtilise(1,"2022-04-01",1008);

delimiter |
create or replace function getSiPoneyDejaUtiliseSurUnCours(pon int,datees date,heures time) returns VARCHAR(40)
begin
    declare resu VARCHAR(40) default 'disponible';
    declare heureEnMoins time default '01:00:00';
    declare heureDuCoursEnMoins time ;
    declare dure time;
    declare idCoours int;
    declare idDuPoney int;
    set heureDuCoursEnMoins = heures - heureEnMoins;
    select idCour into idCoours from RESERVER natural join COURS where idPo = pon and dates = datees and heure = heureDuCoursEnMoins;
    select idPo into idDuPoney from RESERVER natural join COURS where idPo = pon and dates = datees and heure = heures;
    set dure = getDuree(idCoours);
    if (dure = '02:00:00') then
        set resu = 'pas disponible';
    end if;
    return resu;
end |
delimiter ;

delimiter |
create or replace function getHeure(idC int) returns VARCHAR(200)
begin
    declare heureCours time;
    select heure into heureCours from COURS where idCour = idC;
    return heureCours;
end |
delimiter ;

delimiter |
create or replace function getDuree(idC int) returns VARCHAR(200)
begin
    declare dureeCours time;
    select duree into dureeCours from COURS where idCour = idC;
    return dureeCours;
end |
delimiter ;
 
delimiter |
create or replace function getDateCour(idC int) returns date
begin
    declare dateCours date;
    select dates into dateCours from COURS where idCour = idC;
    return dateCours;
end |
delimiter ;

delimiter |
create or replace function renvoiHeurePoneyRepos(idPone int,datees date,heures time) returns time
begin
    declare calculTemps time;
    declare result time;
    declare ajouteTemps time default '03:00:00';
    select heure into calculTemps from RESERVER natural join COURS where dates = datees and heure <= heures and idPo = idPone and duree = '02:00:00';
    set result = calculTemps + ajouteTemps;
    return result;
end |
delimiter ;

select renvoiHeurePoneyRepos(10,"2022-05-01","17:00:00");

delimiter |
create TRIGGER verificationReservation before INSERT on RESERVER for each row
begin
    declare res VARCHAR(500) default '';
    declare reservation int;
    declare nbMaximum int;
    declare cotisationC boolean;
    declare poidSupportablePoney int;
    declare poidClient int;
    declare idCours int;

    declare heureDuCours time;
    declare dateDuCours date;
    declare poney int;
    declare poneyBesoinDeRepos time;
    declare poneyDejaUtiliseSurCours int;
    declare poneyEmpieteSurCours VARCHAR(40);

    set heureDuCours = getHeure(new.idCour);
    set dateDuCours = getDateCour(new.idCour);
    set poneyBesoinDeRepos = renvoiHeurePoneyRepos(new.idPo,dateDuCours,heureDuCours);
    set reservation = getNbPlacesReservees(new.idCour);
    set nbMaximum = getNbPlacesCoursMax(new.idCour);
    set poidSupportablePoney = getPoidSupportablePoney(new.idPo);
    set poidClient = getPoidClient(new.idC);
    set poneyDejaUtiliseSurCours = getSiPoneyDejaUtilise(new.idPo,dateDuCours,new.idCour);
    set poneyEmpieteSurCours = getSiPoneyDejaUtiliseSurUnCours(new.idPo,dateDuCours,heureDuCours);
    select count(*) into reservation from RESERVER where idCour = new.idCour;
    select cotisation into cotisationC from CLIENT where idC = new.idC;
    select idCour into idCours from RESERVER where idCour = new.idCour;
    if (reservation >= nbMaximum) then
        set res = concat("impossible de faire la réservation pour le cours ",new.idCour," le cours est complet");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if; 
    if (cotisationC = false) then
        set res = concat("impossible de faire la réservation ",new.idCour," le client n'a pas payé sa cotisation");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (poidClient >= poidSupportablePoney) then
        set res = concat("impossible de faire la réservation ",new.idCour," le poney ne peut pas supporter le poid du client");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    
    if (poneyDejaUtiliseSurCours = new.idPo) then
        set res = concat("impossible de faire la réservation ",new.idCour," le poney est déjà utlisé sur ce cours");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (poneyEmpieteSurCours = "pas disponible") then
        set res = concat("impossible de faire la réservation ",new.idCour," le poney est déjà utlisé sur un cours autre cours à la meme heure");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (heureDuCours <= poneyBesoinDeRepos) then
        set res = concat("impossible de faire la réservation ",new.idCour," le poney effectue son repos de 1h");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
end |
delimiter ;

delimiter |
create TRIGGER verificationMoniteur before INSERT on MONITEUR for each row
begin
    declare res VARCHAR(100) default '';
    declare idMoniteur int;
    select idM into idMoniteur from MONITEUR where idM = new.idM;
    if (idMoniteur = new.idM) then
        set res = concat("impossible d'insérer le moniteur ",new.idM," le moniteur existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
end |
delimiter ;

delimiter |
create TRIGGER verificationClient before INSERT on CLIENT for each row
begin
    declare res VARCHAR(100) default '';
    declare idClient int;
    select idC into idClient from CLIENT where idC = new.idC;
    if ( idClient = new.idC) then
        set res = concat("impossible d'insérer le client ",new.idC," le client existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
end |
delimiter ;

delimiter |
create TRIGGER verificationCours before INSERT on COURS for each row
begin
    declare res VARCHAR(500) default '';
    declare idCo int;
    select idCour into idCo from COURS where idCour = new.idCour;
    if (idCo = new.idCour) then
        set res = concat("impossible d'insérer le cours ",new.idCour," le cours existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if; 
end |
delimiter ;

delimiter |
create TRIGGER verificationPoney before INSERT on PONEY for each row
begin
    declare res VARCHAR(100) default '';
    declare idPoney int;
    select idPo into idPoney from PONEY where idPo = new.idPo;
    if (idPoney = new.idPo) then
        set res = concat("impossible d'insérer le poney ",new.idPo," le poney existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
end |
delimiter ;














