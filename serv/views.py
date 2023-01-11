from .app import app
from flask import render_template, request, redirect, url_for


@app.route ("/")
def index():
    return render_template('index.html')

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



