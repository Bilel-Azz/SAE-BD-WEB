from .app import app
from .models import *
from .models import Base,session
from flask import render_template, request, redirect, url_for
from flask_wtf import FlaskForm
from wtforms import StringField, HiddenField , PasswordField
from wtforms.validators import DataRequired
from .core.database import Base, session
from flask_login import login_user, current_user , logout_user , login_required
from flask import flash
from sqlalchemy.exc import IntegrityError


from .models import Client, Moniteur, Poney, Cours, Reserver,Utilisateur


@app.route("/")
def index():
    return render_template("index.html")

@app.route ("/accueilClient")
def accueilClient():
    return render_template('accueilClient.html')

@app.route ("/about")
def about():
    return render_template('about.html')

@app.route ("/contact")
def contact():
    return render_template('contact.html')

@app.route ("/services")
def services():
    return render_template('services.html')

@app.route("/connexion")
def connexion():
    return render_template('connexion.html')

@app.route("/creationcompte")
def creationcompte():
    
    return render_template('creationcompte.html')

@app.route("/creationreservation")
def creationreservation():
    return render_template('creerreservation.html')

@app.route("/gererClient")
def gererClient():
    client = Client.get_all_clients()
    return render_template('gererClient.html', client=client)


class ConnexionForm(FlaskForm):
    email = StringField('email', validators=[DataRequired()])
    password = PasswordField('password', validators=[DataRequired()])

@app.route("/login", methods=['GET', 'POST'])
def login():
    form = ConnexionForm()
    email = form.email.data
    password = form.password.data
    user = Utilisateur.get_user(email, password)
    if user is not None:
        login_user(user)
        return redirect(url_for('index'))


class CreationCompteForm(FlaskForm):
    nom = StringField('name', validators=[DataRequired()])
    prenom = StringField('prenom', validators=[DataRequired()])
    email = StringField('email', validators=[DataRequired()])
    password = PasswordField('password', validators=[DataRequired()])
    poids = StringField('poids', validators=[DataRequired()])

@app.route("/createcompte", methods=['GET', 'POST'])
def createcompte():
    form = CreationCompteForm()
    nom = form.nom.data
    prenom = form.prenom.data
    email = form.email.data
    password = form.password.data
    poids = form.poids.data
    poids = int(poids)
    client = Client(nomC=nom, prenomC=prenom, poidsC=poids, cotisation = True)
    session.add(client)
    session.commit()
    user = Utilisateur(emailU=email, passwordU=password, idC=client.idC)
    session.add(user)
    session.commit()
    client = Client.get_client_by_id(user.idC)
    return "<h1>{} {}</h1>".format(client.nomC, client.prenomC)
    
@app.route("/logout")
def logout():
    logout_user()
    return redirect(url_for('index'))

@app.route("/moncompte")
def moncompte():
    listRes = []
    reservations = Reserver.get_reserver_by_client(current_user.idC)
    user = Utilisateur.get_user(current_user.emailU, current_user.passwordU)
    admin = user.is_admin()
    client = Client.get_client_by_id(current_user.idC)
    print(admin)
    for reservation in reservations:
        cours = Cours.get_cours_by_id(reservation.idCour)
        poney = Poney.get_poney_by_id(reservation.idPo)
        moniteur = Moniteur.get_moniteur_by_id(cours.idM)
        date = Cours.get_date_cours(reservation.idCour)
        heure = Cours.get_heure_cours(reservation.idCour)
        idC = reservation.idC
        idPo = reservation.idPo
        idCour = reservation.idCour
        nbParticipant = Reserver.get_number_of_participants(reservation.idCour)
        listRes.append((client, cours, poney, moniteur , date, heure, nbParticipant, idC, idPo, idCour))
    return render_template('compte.html',listRes=listRes, admin=admin, client=client)

@app.route("/annulerreservation/<int:idC>/<int:idPo>/<int:idCour>", methods=['DELETE', 'POST', 'GET'])
def annulerreservation(idC,idPo,idCour):
    Reserver.delete_reserver(idC,idPo,idCour)
    return redirect(url_for('moncompte'))


@app.route("/supprimerclient/<int:idC>", methods=['DELETE', 'POST', 'GET'])
def supprimerclient(idC):
    try:
        Client.supprimer_client(idC)
    except IntegrityError as e:
        flash(f"Impossible de supprimer le client {Client.get_nom_client(idC)} il est lié à une réservation, veuillez supprimer la réservation avant de supprimer le client", "danger")
    return redirect(url_for('gererClient'))

@app.route("/ajouterclient", methods=['GET', 'POST'])
def ajouterclient():
    if request.method == 'POST':
        idC = request.form['idC']
        nom = request.form['nom']
        prenom = request.form['prenom']
        poids = request.form['poids']
        cotisation = request.form.get('cotisation')
        if cotisation == 'on':
            cotisation = True
        else:
            cotisation = False
        try :
            client = Client(idC=idC,nomC=nom, prenomC=prenom, poidsC=poids, cotisation = cotisation)
            session.add(client)
            session.commit()
            flash(f"Le client {client.nomC} {client.prenomC} a bien été ajouté", "success")
        except IntegrityError as e:
            session.rollback()
            flash(f"Une erreur c'est produite,le client {nom} {prenom} existe déjà avec cet ID , veuillez en mettre un autre", "danger")
        return redirect(url_for('gererClient'))