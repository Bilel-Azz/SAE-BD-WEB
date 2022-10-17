drop trigger if exists check_nb_places;
drop trigger if exists check_repos;


-- Contrainte mise en place :
   -- 1. un poney ne peut pas participer à un cours s'il à déjà participé à un cours de 2h juste avant le cours en question et qu'il n'a pas encore effectuer son repos de 1h
   -- 2. si un client n'a pas payé sa cotisation, il ne peut pas participer à un cours
   -- 3. un cours ne peut pas avoir plus du nombre de places prévu


delimiter |
create TRIGGER check_nb_places before INSERT on RESERVER for each row
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
    select nbMax into nbMax from COURS where idCour = new.idCour;
    select count(*) into nbPersonnes from RESERVER where idCour = new.idCour;
    select duree into dureeCour from COURS where idCour = new.idCour;
    select heure into heureCour from COURS where idCour = new.idCour;
    select idPo into idPo from RESERVER where idCour = new.idCour;
    select duree into dureePrecedent from COURS where idCour = (select max(idCour) from COURS where idCour < new.idCour);
    select heure into heurePrecedent from COURS where idCour = (select max(idCour) from COURS where idCour < new.idCour);
    select cotisation into cotisation from CLIENT where idC = new.idC;
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
end |
delimiter ;

