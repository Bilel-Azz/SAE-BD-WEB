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
    cours = Cours.get_cours_disponibles_by_client(current_user.idC)
    return render_template('creerreservation.html', cours=cours)

@app.route("/creationreservationponey/<idCour>")
def creationreservationponey(idCour):
    client=Client.get_client_by_id(current_user.idC)
    poneys= Poney.get_poney_suportable(client.poidsC)
    if len (poneys)==0:
        flash("Désolé, Vous ne pouvez pas reserver de poney, votre poids est trop lourd")
        return redirect(url_for('creationreservation'))
    return render_template('creerreservationponey.html', poneys=poneys, idCour=idCour)


@app.route("/gererClient")
def gererClient():
    client = Client.get_all_clients()
    return render_template('gererClient.html', client=client)

@app.route("/gererMoniteur")
def gererMoniteur():
    moniteur = Moniteur.get_all_moniteurs()
    return render_template('gererMoniteur.html',moniteur=moniteur)

@app.route("/gererCours")
def gererCours():
    cours = Cours.get_all_cours()
    return render_template('gererCours.html',cours=cours)

@app.route("/gererPoney")
def gererPoney():
    poney = Poney.get_all_ponies()
    return render_template('gererPoney.html',poney=poney)

@app.route("/gererReservation")
def gererReservation():
    reservation = Reserver.get_all_reserver()
    return render_template('gererReservation.html',reservation=reservation)


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
    else:
        flash('Invalid username/password combination')
        return redirect(url_for('connexion'))



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
    try:
        client = Client(nomC=nom, prenomC=prenom, poidsC=poids, cotisation = True)
        session.add(client)
        session.commit()
    except IntegrityError:
        session.rollback()
        return render_template('erreur.html')
    try:
        user = Utilisateur(emailU=email, passwordU=password, idC=client.idC)
        session.add(user)
        session.commit()
    except IntegrityError as e:
        print(e.args)
        session.rollback()
        return render_template('erreur.html')
    client = Client.get_client_by_id(user.idC)
    return redirect(url_for('connexion'))
    
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
        flash(f"Le client {Client.get_nom_client(idC)} a bien été supprimé", "success")
    except IntegrityError as e:
        flash(f"Une erreur c'est produite, impossible de supprimer le client {Client.get_nom_client(idC)} est lié à une réservation, veuillez supprimer la réservation avant de supprimer le client", "danger")
    return redirect(url_for('gererClient'))

@app.route("/supprimerMoniteur/<int:idM>", methods=['DELETE', 'POST', 'GET'])
def supprimermoniteur(idM):
    try:
        flash(f"Le moniteur {Moniteur.get_nom_moniteur(idM)} a bien été supprimé", "success")
        Moniteur.supprimer_moniteur(idM)      
    except IntegrityError as e:
        flash(f"Une erreur c'est produite, impossible de supprimer le moniteur{Moniteur.get_nom_moniteur(idM)} est lié à un cour, veuillez attendre que le moniteur n'est plus de cours avant de le supprimer", "danger")
    return redirect(url_for('gererMoniteur'))

@app.route("/supprimercours/<int:idCour>", methods=['DELETE', 'POST', 'GET'])
def supprimercours(idCour):
    try:
        flash(f"Le cours {Cours.get_nom_cour(idCour)} a bien été supprimé", "success")
        Cours.supprimer_cour(idCour)
    except IntegrityError as e:
        flash(f"Une erreur c'est produite, impossible de supprimer le cour {Cours.get_nom_cour(idCour)}", "danger")
    return redirect(url_for('gererCours'))

@app.route("/supprimerponey/<int:idPo>", methods=['DELETE', 'POST', 'GET'])
def supprimerponey(idPo):
    try:
        flash(f"Le poney {Poney.get_nom_poney(idPo)} a bien été supprimé", "success")
        Poney.supprimer_poney(idPo)
    except IntegrityError as e:
        flash(f"Une erreur c'est produite, impossible de supprimer le poney {Poney.get_nom_poney(idPo)}", "danger")
    return redirect(url_for('gererPoney'))

@app.route("/supprimerreservation/<int:idC>/<int:idPo>/<int:idCour>", methods=['DELETE', 'POST', 'GET'])
def supprimerreservation(idC,idPo,idCour):
    try:
        flash(f"La reservation {idC}, {idPo}, {idCour} a bien été supprimé", "success")
        Reserver.delete_reserver(idC,idPo,idCour)
    except IntegrityError as e:
        flash(f"Une erreur c'est produite, impossible de supprimer la reservation {idC},{idPo},{idCour}", "danger")
    return redirect(url_for('gererReservation'))


@app.route("/ajouterclient", methods=['GET', 'POST'])
def ajouterclient():
    if request.method == 'POST':
        nom = request.form['nom']
        prenom = request.form['prenom']
        poids = request.form['poids']
        cotisation = request.form.get('cotisation')
        if cotisation == 'on':
            cotisation = True
        else:
            cotisation = False
        try :
            client = Client(nomC=nom, prenomC=prenom, poidsC=poids, cotisation = cotisation)
            session.add(client)
            session.commit()
            flash(f"Le client {client.nomC} {client.prenomC} a bien été ajouté", "success")
        except IntegrityError as e:
            session.rollback()
            flash(f"Une erreur c'est produite,le client {nom} {prenom} existe déjà avec cet ID , veuillez en mettre un autre", "danger")
        return redirect(url_for('gererClient'))

@app.route("/ajouterMoniteur", methods=['GET', 'POST'])
def ajouterMoniteur():
    if request.method == 'POST':
        idM = request.form['idM']
        nom = request.form['nom']
        prenom = request.form['prenom']
        try :
            moniteur = Moniteur(idM=idM,nomM=nom, prenomM=prenom)
            session.add(moniteur)
            session.commit()
            flash(f"Le moniteur a bien été ajouté", "success")
        except IntegrityError as e:
            session.rollback()
            flash(f"Une erreur c'est produite,un moniteur existe déjà avec cet ID , veuillez en mettre un autre", "danger")
        return redirect(url_for('gererMoniteur'))

@app.route("/ajoutercours", methods=['GET', 'POST'])
def ajoutercours():
    if request.method == 'POST':
        IdCours = request.form['IdCour']
        nomcour = request.form['nomcour']
        idM = request.form['idM']
        nbMax = request.form['nbMax']
        date = request.form['date']
        heure = request.form['heure']
        duree = request.form['duree']
        try:
            cours = Cours(idCour=IdCours, nomcour=nomcour,nbMax=nbMax,idM=idM, dates=date, heure=heure, duree=duree)
            session.add(cours)
            session.commit()
            flash(f"Le cours a bien été ajouté", "success")
        except IntegrityError as e:
            session.rollback()
            flash(f"Une erreur c'est produite,un cours existe déjà avec cet ID , veuillez en mettre un autre", "danger")
        return redirect(url_for('gererCours'))


@app.route("/comfirmation/<idCour>/<idPo>")
def comfirmation(idCour, idPo):
    try:
        session.add(Reserver(idC=current_user.idC, idCour=idCour, idPo=idPo))
        session.commit()
        return render_template('confirmation.html')
    except IntegrityError:
        session.rollback()
        return render_template('erreur.html')

@app.route("/ajouterponey", methods=['GET', 'POST'])
def ajouterponey():
    if request.method == 'POST':
        idPo = request.form['idPo']
        poidPo = request.form['poidPo']
        poidSup = request.form['poidSup']
        nomPo = request.form['nomPo']
        agePo = request.form['agePo']
        try:
            poney = Poney(idPo=idPo, poidPo=poidPo, poidSup=poidSup, nomPo=nomPo, agePo=agePo)
            session.add(poney)
            session.commit()
            flash(f"Le poney a bien été ajouté", "success")
        except IntegrityError as e:
            session.rollback()
            flash(f"Une erreur c'est produite,un poney existe déjà avec cet ID , veuillez en mettre un autre", "danger")
        return redirect(url_for('gererPoney'))

