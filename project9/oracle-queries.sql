------- Page d'accueil -------

-- Sélection de tous les cours
SELECT * FROM cours;

-- Sélection des parties de cours
SELECT * FROM partie_cours;

-- Sélection récursive des catégories
SELECT cat.name
FROM categories cat
LEFT JOIN categories parent ON parent.id=cat.category_id
START WITH cat.category_id IS NULL
CONNECT BY PRIOR cat.id=parent.id;
-- Note : dans les dernières version d'Oracle, il est possible de retrouver
-- le niveau de récursion de la requête via une requête du type :
-- WITH children_categories(id, name, level) AS ( SELECT ...
-- Mais la version d'Oracle SQL du DIRO ne permet pas une telle chose.
-- Une telle requête est utilisée dans notre application

------- API de recherche -------
-- Requête originale telle qu'elle est exécutée en python :
-- SELECT id, content AS text FROM questions WHERE ' + op.join(['LOWER(content) LIKE ?' for i in range(len(words))]) + ' LIMIT 10;
-- Où `op` est soit 'OR', soit 'AND', pour permettre de rechercher en considérant *tous les mots-clés* ou *au moins un des mots-clés*
-- Le `LIMIT 10` sert à éviter d'avoir trop de résultats à envoyer lors d'une requête à l'API (par exemple, en recherchant
-- "a", ce qui sélectionne la majorité des entrées de la base de données), mais n'est pas disponible facilement dans la version d'Oracle
-- SQL du DIRO (les dernières versions permettent de faire `FETCH FIRST 10 ROWS ONLY`

-- Les requêtes suivantes sont des exemples compilés en SQL pour `op` = AND et pour `words` = ['algèbre', 'relationnel'] :
SELECT id, content AS text FROM questions WHERE LOWER(content) LIKE '%algèbre%' AND LOWER(content) LIKE '%relationnel%';
SELECT id, name AS text FROM categories WHERE LOWER(name) LIKE '%algèbre%' AND LOWER(name) LIKE '%relationnel%';
SELECT sigle AS id, name AS text FROM cours WHERE LOWER(name) LIKE '%algèbre%' AND LOWER(name) LIKE '%relationnel%';
SELECT id, name AS text FROM partie_cours WHERE LOWER(name) LIKE '%algèbre%' AND LOWER(name) LIKE '%relationnel%';

------- Tirage de questions aléatoire -------
-- Sélection de questions par sigle de cours
-- Exemple de requête compilée pour le cours 'IFT2935'
SELECT * FROM questions
    WHERE partie_cours_id IN (
    SELECT id FROM partie_cours
    WHERE cours_id='IFT2935'
);

-- Sélection des questions relatives à un partie d'un cours
-- Exemple de requête compilée pour partie_cours_id=1
SELECT * FROM questions WHERE partie_cours_id=1;

-- Sélection des ID de catégories enfants d'une catégorie donnée
-- Exemple compilé pour les enfants de la catégorie 1
SELECT cat.id
FROM categories cat
LEFT JOIN categories parent ON parent.id=cat.category_id
START WITH cat.category_id = 1
CONNECT BY PRIOR cat.id=parent.id;

-- Sélection des questions relatives à des catégories données
-- Exemple compilé pour les catégories 17 et 19
SELECT * FROM questions question
JOIN question_categories
ON question_categories.question_id=question.id
AND question_categories.category_id IN (17, 19);

-- Sélection d'une question précise
-- Exemple compilé pour la question 1
SELECT * FROM questions WHERE id=1;

-- Sélection d'une catégorie et de ses catégories parentes
-- Exemple compilé pour trouver la catégorie 5 et ses parents
SELECT cat.id
FROM categories cat
LEFT JOIN categories parent ON parent.id=cat.category_id
START WITH cat.id = 5
CONNECT BY cat.id = prior cat.category_id;

-- Sélection des réponses d'une question dans un ordre aléatoire
-- Exemple compilé pour trouver les réponses de la question 1
SELECT * FROM reponses WHERE question_id=1 ORDER BY dbms_random.value;

------- Statistiques -------
-- Nombre de réponses de questions par cours
SELECT sigle AS Sigle, cours.name AS Nom, COUNT(reponses.id) AS Nombre_de_reponses
FROM cours
JOIN partie_cours ON partie_cours.cours_id=cours.sigle
JOIN questions ON partie_cours.id=questions.partie_cours_id
JOIN reponses ON reponses.question_id=questions.id
GROUP BY cours.sigle, cours.name
ORDER BY cours.sigle;

-- Moyenne de questions dans la base de données / cours
SELECT AVG(cnt) AS Nombre_moyen FROM (
    SELECT COUNT(questions.id) as cnt
    FROM cours
    JOIN partie_cours ON partie_cours.cours_id=cours.sigle
    JOIN questions ON partie_cours.id=questions.partie_cours_id
    GROUP BY cours.sigle
);

-- Nombre de questions par professeur
SELECT prenom AS Prenom, nom AS Nom, COUNT(questions.id) AS Nombre_de_questions FROM professeurs professeur
JOIN professeur_cours ON professeur.id=professeur_cours.professeur_id
JOIN cours ON professeur_cours.cours_id=cours.sigle
JOIN partie_cours ON partie_cours.cours_id=cours.sigle
JOIN questions ON questions.partie_cours_id=partie_cours.id
GROUP BY professeur.id, prenom, nom;

------- Mise à jour des statistiques de bonnes/mauvaises réponses -------
-- Augmente de 1 le nombre de bonne réponses à une question
-- Exemple compilé pour la question 1
UPDATE questions SET success=success+1 WHERE id = 1;
-- Augmente de 1 le nombre de mauvaises réponses à une question
-- Exemple compilé pour la question 1
UPDATE questions SET failures = failures + 1 WHERE id = 1;

------- Statistiques réservés aux professeurs -------
-- Recherche d'un professeur via son nom, prénom et mot de passe (pour l'authentification)
-- Si la requête ne donne aucun résultat, on peut assumer que l'authentification a échoué
-- Exemple compilé pour 'Claude Frasson', avec le mot de passe 'ift2935'
SELECT * FROM professeurs WHERE nom='Frasson' AND mot_de_passe='ift2935' AND prenom='Claude';

-- Nombre de questions par cours
-- Exemple compilé pour professeur.id=1
SELECT COUNT(questions.id) AS nbr_questions, cours.name AS name, cours.sigle AS id, cours.sigle AS sigle
FROM cours
JOIN professeur_cours ON professeur_cours.professeur_id=1
AND cours.sigle=professeur_cours.cours_id
JOIN partie_cours ON partie_cours.cours_id=cours.sigle
JOIN questions ON questions.partie_cours_id=partie_cours.id
GROUP BY cours.name, cours.sigle;

-- Taux de réussite moyen sur toutes les questions du professeur
-- Exemple compilé pour professeur_id=1
SELECT ((SUM(success)*100)/NULLIF(SUM(success) + SUM(failures), 0)) AS average_reussite
FROM questions
JOIN professeur_cours ON professeur_cours.professeur_id = 1
JOIN partie_cours ON questions.partie_cours_id = partie_cours.id
JOIN cours ON partie_cours.cours_id=cours.sigle
WHERE cours.sigle=professeur_cours.cours_id;


-- Taux de réussite par question
-- Exemple compilé pour professeur_id=1
SELECT sigle, content, (success*100)/NULLIF(success + failures, 0) AS rapport, (success + failures) AS nbr_answers
FROM questions
JOIN partie_cours ON questions.partie_cours_id = partie_cours.id
JOIN cours ON partie_cours.cours_id=cours.sigle
JOIN professeur_cours ON professeur_cours.professeur_id = 1
AND cours.sigle=professeur_cours.cours_id
ORDER BY rapport DESC, nbr_answers DESC;

-- Sélection des collègues d'un professeur
-- Exemple compilé pour professeur_id=1
SELECT * FROM professeurs professeur
JOIN professeur_cours ON professeur_cours.professeur_id=professeur.id
JOIN cours ON professeur_cours.cours_id=cours.sigle
WHERE cours.sigle IN (
    SELECT cours_id FROM professeurs
    JOIN professeur_cours pc ON pc.professeur_id=professeurs.id AND professeur_id=1
) AND professeur.id != 1;
