-- Contrainte mise en place :
    -- 1. un poney ne peut pas participer à un cours s'il à déjà participé à un cours de 2h juste avant le cours en question et qu'il n'a pas encore effectuer son repos de 1h
    -- 2. si un client n'a pas payé sa cotisation, il ne peut pas participer à un cours
    -- 3. un cours ne peut pas avoir plus du nombre de places prévu
    -- 4. un client qui existe déjà ne peut pas être ajouté
    -- 5. un moniteur ne peut pas être ajouté s'il existe déjà
    -- 6. un poney ne peut pas être ajouté s'il existe déjà
    -- 7. un cours ne peut pas être ajouté s'il existe déjà
    


delimiter |
create TRIGGER verification before INSERT on RESERVER for each row
begin
    declare res VARCHAR(100) default '';
    declare nbPersonnes int;
    declare nbMax int;
    declare dureeCour int;
    declare dureePrecedent int;
    declare heureCour time;
    declare heurePrecedent time;
    declare idPo int;
    declare cotisation boolean;
    declare idClient int;
    declare idCour int;
    declare idMoniteur int;
    declare idPoney int;
    select nbMax into nbMax from COURS where idCour = new.idCour;
    select count(*) into nbPersonnes from RESERVER where idCour = new.idCour;
    select duree into dureeCour from COURS where idCour = new.idCour;
    select heure into heureCour from COURS where idCour = new.idCour;
    select idPo into idPo from RESERVER where idCour = new.idCour;
    select duree into dureePrecedent from COURS where idCour = (select max(idCour) from COURS where idCour < new.idCour);
    select heure into heurePrecedent from COURS where idCour = (select max(idCour) from COURS where idCour < new.idCour);
    select cotisation into cotisation from CLIENT where idC = new.idC;
    select idC into idClient from RESERVER where idC = new.idC;
    select idCour into idCour from RESERVER where idCour = new.idCour;
    select idM into idMoniteur from COURS where idCour = new.idCour;
    select idPo into idPoney from RESERVER where idPo = new.idPo;
    if (nbPersonnes >= nbMax) then
        set res = concat("impossible de faire la réservation ",new.idC," le cours est complet");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if; 
    if (dureeCour = 120 and dureePrecedent = 120 and heureCour = heurePrecedent + 1 and idPo = new.idPo) then
        set res = concat("impossible de faire la réservation ",new.idC," le poney a besoin de repos");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (cotisation = false) then
        set res = concat("impossible de faire la réservation ",new.idC," le client n'a pas payé sa cotisation");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (idClient = new.idC) then
        set res = concat("impossible d'insérer le client ",new.idC," le client existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (idCour = new.idCour) then
        set res = concat("impossible d'insérer le cours ",new.idCour," le cours existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (idMoniteur = new.idM) then
        set res = concat("impossible d'insérer le moniteur ",new.idM," le moniteur existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
    if (idPoney = new.idPo) then
        set res = concat("impossible d'insérer le poney ",new.idPo," le poney existe déjà dans la base de données");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;

end |
delimiter ;

