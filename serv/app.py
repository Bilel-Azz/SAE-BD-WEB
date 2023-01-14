import os
from flask import Flask, render_template, request, url_for, redirect
from flask_sqlalchemy import SQLAlchemy
from os import urandom
from flask_login import LoginManager, login_user, current_user, logout_user, login_required



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
app.secret_key = urandom(SESSION_KEY_LENGTH)

login_manager = LoginManager(app)
login_manager.login_view = 'login'


