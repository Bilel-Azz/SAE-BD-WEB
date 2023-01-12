from .app import app
from flask import render_template, request, redirect, url_for
from .models import Client, Moniteur, Poney, Cours, Reserver


@app.route ("/")
def index():
    return "<h1> Hello World </h1>"

@app.route ("/about")
def about():
    return render_template('about.html')

@app.route ("/contact")
def contact():
    return render_template('contact.html')

@app.route ("/contact")
def contact_post():
    return redirect(url_for('contact'))
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


