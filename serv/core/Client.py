from core.database import Base,session
from sqlalchemy import *
from sqlalchemy.dialects.mysql import INTEGER


# """DROP TABLES RESERVER;
# DROP TABLES CLIENT;
# DROP TABLES PONEY;
# DROP TABLES COURS;
# DROP TABLES MONITEUR;


# CREATE TABLE CLIENT(
#     idC INT PRIMARY KEY,
#     nomC VARCHAR(30),
#     prenomC VARCHAR(30),
#     poidsC INT,
#     cotisation BOOLEAN
# );

# CREATE TABLE PONEY (
#     idPo INT PRIMARY KEY,
#     poidPo INT,
#     poidSup INT,
#     nomPo VARCHAR(30),
#     agePo INT check (agePo >= 0 and agePo <= 40)

# );
# CREATE TABLE MONITEUR (
#     idM INT PRIMARY KEY,
#     nomM VARCHAR(30),
#     prenomM VARCHAR(30)
# );

# CREATE TABLE COURS (
#     idCour INT PRIMARY KEY,
#     nomcour VARCHAR(30),
#     idM INT ,
#     nbMax int check (nbMax >= 0 and nbMax <= 10), 
#     dates DATE,
#     heure TIME check (heure >= '08:00:00' and heure <= '18:00:00'),
#     duree TIME check (duree <= '02:00:00')
# );

# CREATE TABLE RESERVER (
#     idC INT,
#     idPo INT,
#     idCour INT,
#     PRIMARY KEY (idC, idPo, idCour)

# );







# creer une class pour chacune des tables de la base de données sans ajouter de colomnes

class Client(Base):
    __tablename__ = 'CLIENT'
    idC = Column(Integer, primary_key=True)
    nomC = Column(String(40))
    prenomC = Column(String(40))
    poidsC = Column(Integer)
    cotisation = Column(Boolean)

class Moniteur(Base):
    __tablename__ = 'MONITEUR'
    idM = Column(Integer, primary_key=True)
    nomM = Column(String(40))
    prenomM = Column(String(40))

# CREATE TABLE PONEY (
#     idPo INT PRIMARY KEY,
#     poidPo INT,
#     poidSup INT,
#     nomPo VARCHAR(30),
#     agePo INT check (agePo >= 0 and agePo <= 40)

class Poney(Base):
    __tablename__ = 'PONEY'
    idPo = Column(Integer, primary_key=True)
    poidPo = Column(Integer)
    poidSup = Column(Integer)
    nomPo= Column(String(30))
    agePo = Column(Integer)

class Cours(Base):
    __tablename__ = 'COURS'
    idCour = Column(Integer, primary_key=True)
    nomcour = Column(String(30))
    idM = Column(Integer)
    nbMax = Column(Integer)
    dates = Column(Date)
    heure = Column(Time)
    duree = Column(Time)

class Reserver(Base):
    __tablename__ = 'RESERVER'
    idC = Column(Integer, primary_key=True)
    idPo = Column(Integer, primary_key=True)
    idCour = Column(Integer, primary_key=True)









