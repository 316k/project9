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
    courses = query_db("SELECT * FROM cours")
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
            WHERE partie_cours_id = (
                SELECT id FROM partie_cours
                WHERE cours_id=?
            )""", (id,))
    elif by == "partie_cours":
        questions = query_db("SELECT * FROM questions WHERE partie_cours_id=?", (id,))
    elif by == "categorie":
        questions = query_db("""
            SELECT *, question.id AS id FROM questions AS question
            JOIN question_categories ON question.id=question_categories.question_id
            JOIN categories AS categorie ON question_categories.category_id=categorie.id
            WHERE categorie.id = ?""", (id,))
    elif by == "questions":
        questions = query_db("SELECT * FROM questions WHERE id=?", (id,))
    elif by == "global":
        questions = query_db("SELECT * FROM questions")

    categories = query_db("""
        WITH RECURSIVE parent_categories(category_id, name, level) AS (
          SELECT category_id, name, 0
          FROM categories WHERE id=?
            UNION ALL
          SELECT categories.category_id, categories.name, parent_categories.level + 1
          FROM categories
          JOIN parent_categories ON parent_categories.category_id=categories.id
        ) SELECT category_id FROM parent_categories UNION SELECT ?""", (id,id))

    categories = [str(i['category_id']) for i in categories if i['category_id'] is not None]

    question = random.choice(questions)

    reponses = query_db("SELECT * FROM reponses WHERE question_id=? ORDER BY RANDOM()", (question["id"],))

    return render_template('question.html', question=question, reponses=reponses)

@app.route("/stats")
def stats():
    stats = [
        ("Réponses par cours", query_db("""
            SELECT sigle AS `Sigle`, cours.name AS `Nom`, COUNT(reponses.id) AS `Nombre de réponses`
            FROM cours
            JOIN partie_cours ON partie_cours.cours_id=cours.sigle
            JOIN questions ON partie_cours.id=questions.partie_cours_id
            JOIN reponses ON reponses.question_id=questions.id
            GROUP BY cours.sigle
            ORDER BY cours.sigle""")),
        ("Moyenne de réponses par cours", query_db("""
            SELECT AVG(cnt) AS `Nombre moyen` FROM (
                SELECT COUNT(reponses.id) as cnt
                    FROM cours
                    JOIN partie_cours ON partie_cours.cours_id=cours.sigle
                    JOIN questions ON partie_cours.id=questions.partie_cours_id
                    JOIN reponses ON reponses.question_id=questions.id GROUP BY cours.sigle
            )""")),
        ("Nombre de questions par professeur", query_db("""
            SELECT prenom AS `Prénom`, nom AS `Nom`, COUNT(questions.id) AS `Nombre de questions` FROM professeurs AS professeur
            JOIN professeur_cours ON professeur.id=professeur_cours.professeur_id
            JOIN cours ON professeur_cours.cours_id=cours.sigle
            JOIN partie_cours ON partie_cours.cours_id=cours.sigle
            JOIN questions ON questions.partie_cours_id=partie_cours.id
            GROUP BY professeur.id""")),
        #("", query_db()),
    ]

    return render_template('stats.html', stats=stats)

@app.route('/good/<question>')
def good(question):
    query_db("UPDATE questions SET success=success+1 WHERE id = ?", (question,))
    return jsonify(success=True)

@app.route('/bad/<question>')
def bad(question):
    query_db("UPDATE questions SET failures = failures + 1 WHERE id = ?", (question,))
    return jsonify(success=True)
