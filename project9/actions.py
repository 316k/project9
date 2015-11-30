from project9 import app, query_db
from flask import request, redirect, url_for, render_template, g
import random

# Sous-requête pratique
parent_categories = """
WITH RECURSIVE parent_categories(category_id, name, level) AS (
  SELECT category_id, name, 0
  FROM categories WHERE id=?
    UNION ALL
  SELECT categories.category_id, categories.name, parent_categories.level + 1
  FROM categories
  JOIN parent_categories ON parent_categories.category_id=categories.id
)
"""
# Compléter la query ci-dessus par un truc du genre de :
# SELECT category_id FROM parent_categories

@app.route("/")
def index():
    return render_template('index.html', elements=123)

@app.route("/search/", methods=['GET', 'POST'])
def search():
    pattern = request.form['pattern']
    
    # Recherche parmi les cours, parties de cours, et catégories
    #for mot in " ".split(pattern):
    #    query += ' IS LIKE %?%'
    
    
    return render_template('search.html', questions=questions, pattern=pattern)

@app.route("/question/<by>/<id>")
def question(by):

    questions = []
    if by == "cours":
        questions = query_db("""
            SELECT * FROM questions
            WHERE partie_cours_id IN (
                SELECT id FROM partie_cours
            )""")
    elif by == "partie-cours":
        pass
    elif by == "categorie":
        pass
    
    question = random.choice(questions)
    
    return render_template('question.html', questions=questions)

