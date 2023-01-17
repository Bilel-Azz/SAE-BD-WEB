
from .app import login_manager
from .core.database import Base,session,db
from sqlalchemy import *
from sqlalchemy.dialects.mysql import INTEGER
from flask_login import UserMixin

class Utilisateur(Base,UserMixin):
    __tablename__ = 'UTILISATEUR'
    idU = Column(Integer, primary_key=True)
    emailU = Column(String(40))
    passwordU = Column(String(40))
    idC = Column(Integer)
    adminn = Column(Boolean)

    def get_user(email, password):   
        return session.query(Utilisateur).filter(Utilisateur.emailU == email, Utilisateur.passwordU == password).first()

    def get_id(self):
        return self.idU

    def is_admin(self):
        return self.adminn

        
        

class Client(Base):
    __tablename__ = 'CLIENT'
    idC = Column(Integer, primary_key=True, autoincrement=True)
    nomC = Column(String(40))
    prenomC = Column(String(40))
    poidsC = Column(Integer)
    cotisation = Column(Boolean)

    def get_all_clients():
        return session.query(Client).filter(Client.idC != 1).all()

    def get_client_by_id(id):
        return session.query(Client).filter(Client.idC == id).first()

    def supprimer_client(id):
        session.query(Client).filter(Client.idC == id).delete()
        session.commit()

    def get_nom_client(id):
        return session.query(Client.nomC).filter(Client.idC == id).first()


class Moniteur(Base):
    __tablename__ = 'MONITEUR'
    idM = Column(Integer, primary_key=True)
    nomM = Column(String(40))
    prenomM = Column(String(40))
    descriptionMo = Column(String(100))

    def get_all_moniteurs():
        return session.query(Moniteur).all()
    
    def get_all_moniteurs_limit():
        return session.query(Moniteur).limit(4).all()

    def get_moniteur_by_id(id):
        moniteur = session.query(Moniteur.nomM).filter(Moniteur.idM == id).first()
        if moniteur:
            return moniteur.nomM

    def get_nom_moniteur(id):
        return session.query(Moniteur.nomM).filter(Moniteur.idM == id).first()

    def supprimer_moniteur(id):
        session.query(Moniteur).filter(Moniteur.idM == id).delete()
        session.commit()



class Poney(Base):
    __tablename__ = 'PONEY'
    idPo = Column(Integer, primary_key=True)
    poidPo = Column(Integer)
    poidSup = Column(Integer)
    nomPo= Column(String(30))
    agePo = Column(Integer)
    descriptionPo = Column(String(100))


    def get_all_ponies():
        return session.query(Poney).all()

    def get_all_ponies_limite():
        return session.query(Poney).limit(4).all()
    
    def get_poney_by_id(id):
        return session.query(Poney).filter(Poney.idPo == id).first()


    def get_poney_suportable(poids):
        return session.query(Poney).filter(Poney.poidSup >= poids).all()

    def get_nom_poney(id):
        return session.query(Poney.nomPo).filter(Poney.idPo == id).first()

    def supprimer_poney(id):
        session.query(Poney).filter(Poney.idPo == id).delete()
        session.commit()



class Cours(Base):
    __tablename__ = 'COURS'
    idCour = Column(Integer, primary_key=True)
    nomcour = Column(String(30))
    nbMax = Column(Integer)
    idM = Column(Integer)
    dates = Column(Date)
    heure = Column(Time)
    duree = Column(Time)

    def get_all_cours():
        return session.query(Cours).all()

    def get_cours_by_id(id):
        return session.query(Cours).filter(Cours.idCour == id).first()

    def get_date_cours(id):
        return session.query(Cours.dates).filter(Cours.idCour == id).first()
    
    def get_heure_cours(id):
        return session.query(Cours.heure).filter(Cours.idCour == id).first()

    def get_nom_cour(id):
        return session.query(Cours.nomcour).filter(Cours.idCour == id).first()

    def supprimer_cour(id):
        session.query(Cours).filter(Cours.idCour == id).delete()
        session.commit()



class Reserver(Base):
    __tablename__ = 'RESERVER'
    idC = Column(Integer, primary_key=True)
    idPo = Column(Integer, primary_key=True)
    idCour = Column(Integer, primary_key=True)


    def get_all_reserver():
        return session.query(Reserver).all()

    def get_reserver_by_client(id):
        return session.query(Reserver).filter(Reserver.idC == id).all()
    
    def get_reserver_by_poney(id):
        return session.query(Reserver).filter(Reserver.idPo == id).all()

    def get_reserver_by_cours(id):
        return session.query(Reserver).filter(Reserver.idCour == id).all()

    def get_nom_cours(id):
        return session.query(Cours.nomcour).filter(Reserver.idCour == id).first()

    def get_number_of_participants(idCour):
        return session.query(Reserver).filter(Reserver.idCour == idCour).count()

    def delete_reserver(idC,idPo,idCour):
        session.query(Reserver).filter(Reserver.idC == idC, Reserver.idPo == idPo, Reserver.idCour == idCour).delete()
        session.commit()

    


@login_manager.user_loader
def load_user(id):
    return session.query(Utilisateur).get(int(id))

