import os
from flask import Flask, render_template, request, url_for, redirect
from flask_sqlalchemy import SQLAlchemy
from core.database import db, session
from core.Client import *


from sqlalchemy.sql import func
basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)

DATABASE_PROVIDER = "mysql"
DATABASE_HOST = "servinfmariadb"
DATABASE_USER = "aazzouz"
DATABASE_PASS = "aazzouz"
DATABASE_NAME = "DBaazzouz"
SESSION_KEY_LENGTH = 24
app.config['SQLALCHEMY_DATABASE_URI'] ="%s://%s:%s@%s/%s" % (DATABASE_PROVIDER, DATABASE_USER, DATABASE_PASS, DATABASE_HOST, DATABASE_NAME)




@app.route ("/")
def index():
    return render_template('index.html')



