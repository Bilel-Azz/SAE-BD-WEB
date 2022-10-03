-- Contrainte : un cours ne peut pas avoir plus du nombre maximum de places disponibles pour le cours en question


delimiter |
create or replace TRIGGER check_nb_places before INSERT on RESERVER for each row
begin
    declare res VARCHAR(100) default '';
    declare nbPersonnes int;
    declare nbMax int;
    select nbMax into nbMax from COURS where idCour = new.idCour;
    select count(*) into nbPersonnes from RESERVER where idCour = new.idCour;
    if (nbPersonnes >= nbMax) then
        set res = concat("impossible de faire la réservation ",new.idC," le cours est complet");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = res;
    end if;
end |
delimiter ;

-- Contrainte : un poney ne peut pas participer à un cours s'il à déjà participé à un cours de 2h et qu'il n'a pas encore effectuer son repos de 1h
delimiter |
create or replace TRIGGER check_repos before INSERT on RESERVER for each row
begin
    declare


