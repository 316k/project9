import sqlite3
from flask import Flask, g

app = Flask(__name__)
app.debug = True
app.secret_key = 'rkunhffrzrag'

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        g.db = sqlite3.connect(':memory:')
        with open('project9/scheme.sql', 'r') as sql:
            g.db.executescript("".join(sql.readlines()))
    return g.db

def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = [dict((cur.description[idx][0], value)
               for idx, value in enumerate(row)) for row in cur.fetchall()]
    return (rv[0] if rv else None) if one else rv

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

from project9 import actions
