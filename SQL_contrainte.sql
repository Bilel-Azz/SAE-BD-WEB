-- Contrainte mise en place :
    -- 1. un poney ne peut pas participer à un cours s'il à déjà participé à un cours de 2h juste avant le cours en question et qu'il n'a pas encore effectuer son repos de 1h
    -- 2. si un client n'a pas payé sa cotisation, il ne peut pas participer à un cours
    -- 3. un cours ne peut pas avoir plus du nombre de places prévu
    -- 4. un client qui existe déjà ne peut pas être ajouté
    -- 5. un moniteur ne peut pas être ajouté s'il existe déjà
    -- 6. un poney ne peut pas être ajouté s'il existe déjà
    -- 7. un cours ne peut pas etre ajoute s'il existe déjà à la meme heure
    

DROP TRIGGER if exists verificationReservation;
DROP TRIGGER if exists verificationMoniteur;
DROP TRIGGER if exists verificationClient;
DROP TRIGGER if exists verificationCours;
DROP TRIGGER if exists verificationPoney;

delimiter |
create TRIGGER verificationReservation before INSERT on RESERVER for each row
begin
    declare res VARCHAR(100) default '';
    declare nbPersonnes int;
    declare nbMaximum int;
    declare dureeCour int;
    declare dureePrecedent int;
    declare heureCour time;
    declare heurePrecedent time;
    declare idPo int;
    declare cotisationC boolean;
    declare idMoniteur int;
    select nbMax into nbMaximum from RESERVER natural join COURS where idCour = new.idCour;
    select count(*) into nbPersonnes from RESERVER where idCour = new.idCour;
    select duree into dureeCour from COURS where idCour = new.idCour;
    select heure into heureCour from COURS where idCour = new.idCour;
    select duree into dureePrecedent from COURS where idCour = (select max(idCour) from COURS where idCour < new.idCour);
    select heure into heurePrecedent from COURS where idCour = (select max(idCour) from COURS where idCour < new.idCour);
    select cotisation into cotisationC from CLIENT where idC = new.idC;
    if (nbPersonnes >= nbMaximum) then
        set res = concat("impossible de faire la réservation ",new.idCour," le cours est complet");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if; 
    if (dureeCour = 120 and dureePrecedent = 120 and heureCour = heurePrecedent + 1 and idPo = new.idPo) then
        set res = concat("impossible de faire la réservation ",new.idPo," le poney a besoin de repos");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (cotisationC = false) then
        set res = concat("impossible de faire la réservation ",new.idCour," le client n'a pas payé sa cotisation");
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