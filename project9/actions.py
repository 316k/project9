from project9 import app, query_db
from flask import request, redirect, url_for, render_template, g, jsonify
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
    
    # Requête récursive pour trouver les catégories, les sous-catégories, les sous-sous-catégories...
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

@app.route("/search", methods=['POST'])
def search():
    
    pattern = request.form['pattern']
    op = ' AND ' if request.form['all'] == 'true' else ' OR '
    if not pattern:
        return jsonify(success=True)
    
    words = list(map(str.lower, map(lambda x: x if '%' in x else '%' + x + '%', pattern.split(' '))))
    
    questions = query_db('SELECT id, content AS text FROM questions WHERE ' + op.join(['LOWER(content) LIKE ?' for i in range(len(words))]) + ' LIMIT 10', words)
    categories = query_db('SELECT id, name AS text FROM categories WHERE ' + op.join(['LOWER(name) LIKE ?' for i in range(len(words))]) + ' LIMIT 10', words)
    cours = query_db('SELECT id, name AS text FROM cours WHERE ' + op.join(['LOWER(name) LIKE ?' for i in range(len(words))]) + ' LIMIT 10', words)
    parties_cours = query_db('SELECT id, name AS text FROM partie_cours WHERE ' + op.join(['LOWER(name) LIKE ?' for i in range(len(words))]) + ' LIMIT 10', words)
    
    return jsonify(success=True, questions=questions, categories=categories, cours=cours, partie_cours=parties_cours)

@app.route("/question/<by>")
@app.route("/question/<by>/<id>")
def question(by, id=None):

    questions = []
    if by == "cours":
        questions = query_db("""
            SELECT * FROM questions
            WHERE partie_cours_id IN (
                SELECT cours_id FROM partie_cours
                WHERE id=?
            )""", id)
        print('AAAAAAA', questions)
    elif by == "partie_cours":
        questions = query_db("SELECT * FROM questions WHERE partie_cours_id=?", (id,))
    elif by == "categorie":
        pass
    elif by == "questions":
        questions = query_db("SELECT * FROM questions WHERE id=?", (id,))
    elif by == "global":
        questions = query_db("SELECT * FROM questions")


    question = random.choice(questions)

    reponses = query_db("SELECT * FROM reponses WHERE question_id=? ORDER BY RANDOM()", (question["id"],))

    return render_template('question.html', question=question, reponses=reponses)

