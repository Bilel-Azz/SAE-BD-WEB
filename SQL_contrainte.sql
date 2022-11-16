-- Contrainte mise en place :
    -- 1. un poney ne peut pas participer à un cours s'il à déjà participé à un cours de 2h juste avant le cours en question et qu'il n'a pas encore effectuer son repos de 1h
    -- 2. si un client n'a pas payé sa cotisation, il ne peut pas participer à un cours
    -- 3. un cours ne peut pas avoir plus de partcipant que le nombre de places prévu pour celui-ci
    -- 4. un client qui existe déjà ne peut pas être ajouté
    -- 5. un moniteur ne peut pas être ajouté s'il existe déjà
    -- 6. un poney ne peut pas être ajouté s'il existe déjà
    -- 7. un cours ne peut pas etre ajoute si le moniteur à déjà un cours dans la journée
    -- 8. une reservation ne peut pas etre faite si le client choisi un poney qui ne peut pas supporter son poids
    

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
create or replace function verifCoursMoniteur(idMo int,dateC date) returns VARCHAR(200)
begin
    declare res VARCHAR(42) default 'participation possible';
    select idM into res from COURS where idM = idMo and dates = dateC;
    if res = idMo then
        set res = "participation impossible";
    end if;
    return res;
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
create or replace function test(idPo int) returns VARCHAR(200)
begin
    declare poidCli int;
    select poidsC into poidCli from CLIENT where idC = idCli;
    return poidCli;
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
create or replace function verifSiPoneyABesoinDeRepos(idC int,datees date,heure time , duree time) returns VARCHAR(200)
begin
    declare calculTemps time;
    declare res time;
    declare reponse VARCHAR(200) default 'participation possible';
    select TIMEDIFF(heure,duree) into calculTemps from COURS where dates = datees and idCour = idC;
    select TIMEDIFF(heure,calculTemps) into res from COURS where dates = datees and idCour = idC;
    return res;
end |
delimiter ;

select verifSiPoneyABesoinDeRepos(1001,"2022-01-01",'08:00:00','02:00:00');

delimiter |
create TRIGGER verificationReservation before INSERT on RESERVER for each row
begin
    declare res VARCHAR(100) default '';
    declare reservation int;
    declare nbMaximum int;
    declare cotisationC boolean;
    declare poidSupportablePoney int;
    declare poidClient int;
    set reservation = getNbPlacesReservees(new.idCour);
    set nbMaximum = getNbPlacesCoursMax(new.idCour);
    set poidSupportablePoney = getPoidSupportablePoney(new.idPo);
    set poidClient = getPoidClient(new.idC);
    select count(*) into reservation from RESERVER where idCour = new.idCour;
    select cotisation into cotisationC from CLIENT where idC = new.idC;
    if (reservation >= nbMaximum) then
        set res = concat("impossible de faire la réservation pour le cours ",new.idCour," le cours est complet");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if; 
    -- if (dureeCour = 120 and dureePrecedent = 120 and heureCour = heurePrecedent + 1 and idPo = new.idPo) then
    --     set res = concat("impossible de faire la réservation ",new.idPo," le poney a besoin de repos");
    --     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    -- end if;
    if (cotisationC = false) then
        set res = concat("impossible de faire la réservation ",new.idCour," le client n'a pas payé sa cotisation");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (poidClient >= poidSupportablePoney) then
        set res = concat("impossible de faire la réservation ",new.idCour," le poney ne peut pas supporter le poid du client");
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
    declare res VARCHAR(100) default '';
    declare idCo int;
    declare idMoniteur int;
    -- declare dateCour date;
    -- declare heureCour time;
    declare presenteCour VARCHAR(60);
    set presenteCour = verifCoursMoniteur(new.idM,new.dates);
    select idM into idMoniteur from COURS where idM = new.idM;
    -- select dates into dateCour from COURS where dates = new.dates;
    -- select heure into heureCour from COURS where heure = new.heure;
    select idCour into idCo from COURS where idCour = new.idCour;
    if (idCo = new.idCour) then
        set res = concat("impossible d'insérer le cours ",new.idCour," le cours existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (presenteCour = "participation impossible") then
        set res = concat("impossible d'insérer le cours ",new.idCour," le moniteur participe déjà à un cours sur cette journée");
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

