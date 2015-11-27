from project9 import app, get_db
from flask import request, redirect, url_for, render_template, g
import random

@app.route("/")
def index():
    return render_template('index.html', elements=123)

@app.route("/search/", methods=['GET', 'POST'])
def search():
    questions = get_db().cursor().execute("SELECT id FROM questions WHERE 1")
    questions=questions.fetchall()
    print(questions[0]["id"])
    return render_template('search.html', questions=questions, pattern=request.form['pattern'])

