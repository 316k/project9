import sqlite3
from flask import Flask, g
from flaskext.auth import Auth

app = Flask(__name__)
app.debug = True
app.secret_key = 'exhaussement'

auth = Auth(app)

from project9 import actions

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        g.db = sqlite3.connect(':memory:')
        with open('project9/scheme.sql', 'r') as sql:
            g.db.executescript("".join(sql.readlines()))
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()
