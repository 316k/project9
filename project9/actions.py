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
    courses = query_db("SELECT * FROM cours ORDER BY id")
    parties = {}
    parties_cours = query_db("SELECT * FROM partie_cours")
    
    for partie in parties_cours:
        if partie["cours_id"] not in parties:
            parties[partie["cours_id"]] = []
        
        parties[partie["cours_id"]].append(partie)
    
    categories = query_db("""
        WITH RECURSIVE children_categories(id, name, level) AS (
          SELECT id, name, 0
          FROM categories WHERE category_id IS NULL
            UNION ALL
          SELECT categories.id, categories.name, children_categories.level + 1
          FROM categories
          JOIN children_categories ON children_categories.id=categories.category_id
          ORDER BY children_categories.level + 1 DESC
        ) SELECT * FROM children_categories""")
    
    return render_template('index.html', courses=courses, parties=parties, categories=categories, len_categories=len(categories))

@app.route("/search/", methods=['GET', 'POST'])
def search():
    pattern = request.form['pattern']

    # Recherche parmi les cours, parties de cours, et catégories
    #for mot in " ".split(pattern):
    #    query += ' IS LIKE %?%'

    return render_template('search.html', questions=questions, pattern=pattern)

@app.route("/question/<by>")
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
    elif by == "global":
        questions = query_db("""SELECT * FROM questions;""")


    question = random.choice(questions)
    reponses = query_db("""SELECT * FROM reponses JOIN questions ON reponses.question_id = questions.id 
        WHERE reponses.question_id = {} """.format(question["id"])
    )
    print(reponses)
    return render_template('question.html', question=question, reponses=reponses)

