from .app import app
from .models import *
from .models import Base,session
from flask import render_template, request, redirect, url_for
from flask_wtf import FlaskForm
from wtforms import StringField, HiddenField , PasswordField
from wtforms.validators import DataRequired
from .core.database import Base, session
from flask_login import login_user, current_user , logout_user , login_required
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
    cours = Cours.get_all_cours()
    return render_template('creerreservation.html', cours=cours)

@app.route("/creationreservationponey/<idCour>")
def creationreservationponey(idCour):
    client=Client.get_client_by_id(current_user.idC)
    poneys= Poney.get_poney_suportable(client.poidsC)
    return render_template('creerreservationponey.html', poneys=poneys, idCour=idCour)



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
    client = Client.get_client_by_id(current_user.idC)
    return render_template('compte.html', client=client)

@app.route("/comfirmation/<idCour>/<idPo>")
def comfirmation(idCour, idPo):
    try:
        session.add(Reserver(idC=current_user.idC, idCour=idCour, idPo=idPo))
        session.commit()
        return render_template('confirmation.html')
    except IntegrityError:
        session.rollback()
        return render_template('erreur.html')
