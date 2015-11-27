from project9 import app
from flask import request, redirect, url_for, render_template, g
import random

@app.route("/")
def index():
    return render_template('index.html', elements=123)

@app.route("/question/by-<obj>/<arg>")
def question(category):
    questions = []
    
    q = random.choice(questions)
    
    return render_template('question.html', question=q)
