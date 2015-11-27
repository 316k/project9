-- Cours
CREATE TABLE cours(
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT,
    sigle TEXT
);

-- Partie de cours = Chapitre/section dans un cours
CREATE TABLE partie_cours(
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT,
    cours_id INTEGER NOT NULL,
    FOREIGN KEY(cours_id) REFERENCES cours(id)
);


-- Questions à choix multiples
CREATE TABLE questions(
    id INTEGER NOT NULL PRIMARY KEY,
    content TEXT,
    partie_cours_id INTEGER NOT NULL,
    FOREIGN KEY(partie_cours_id) REFERENCES partie_cours(id)
);

-- Réponses des questions
CREATE TABLE reponses(
    id INTEGER NOT NULL PRIMARY KEY,
    texte TEXT,
    question_id INTEGER NOT NULL,
    FOREIGN KEY(question_id) REFERENCES question(id)
);

-- Une catégorie peut avoir des sous-catégories de façon récursive
CREATE TABLE categories(
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT,
    category_id INTEGER DEFAULT NULL,
    FOREIGN KEY(category_id) REFERENCES categories(category_id)
);

-- Associations entre les catégories (pas de sous-catégories) et les cours
CREATE TABLE categorie_cours(
    category_id INTEGER NOT NULL,
    cours_id INTEGER NOT NULL,
    PRIMARY KEY(category_id, cours_id)
);

-- Associations question-catégories
CREATE TABLE question_categories(
    question_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY(question_id, category_id)
);

-- Notes sur le schéma :
--  * les exercices reliés sont calculés à partir des catégories associées aux questions
--  * Il n'est pas nécessaire d'associer des sous-catégories à un cours, puisqu'on peut retrouver le cours en trouvant récursivement le parent (FIXME ?)

---------------------
-- Valeurs de test --
INSERT INTO categories VALUES
    (1, 'Normalisation des bases de données', NULL),
    (2, 'Formes normales', NULL),
    (3, '1FN', 2),
    (4, '2FN', 2),
    (5, '3FN', 2),

INSERT INTO cours VALUES
    (1, 'Bases de données', "IFT2935"),
    (2, 'Génie Logiciel', "IFT2935"),
    (3, 'Génie Logiciel 2 : la vengence des classes abstraites', "IFT2935");
    (4, 'Génie Logiciel 3 : le retour des interfaces d''AbstractFactoryFactory', "IFT2935");

INSERT INTO partie_cours VALUES
    (1, 'Première partie : Introduction', 1),
    (2, 'Deuxième partie : Modèle Entité Relation', 1),
    (3, 'Troisième partie : Modèle Relationnel', 1),
    (4, 'Quatrième partie : L''algèbre et le calcul Relationnel', 1),
    (5, 'Partie 1 : les différences entre le code et le programmeur', 2),
    (6, 'Partie 2 : intro à l''overengineering', 2),
    (7, 'Partie 3 : l''overengineering généralisé', 2),
    (8, 'Partie 4 : l''overengineering généré par ordinateur', 2);

INSERT INTO questions VALUES
    (1, 'Qu''est-ce qu''une base de données ?', 1),
    (2, 'Pourquoi a-t-on besoin de bases de données ?', 1),
    (3, 'Qu''est-ce qu''un attribut clé ?', 2),
    (4, 'Qu''est-ce qu''un attribut composite ?', 2),
    (5, 'Quels sont les types de contraintes d''intégrité relationnelle ?', 3),
    (6, 'Quel est le symbol pour l''opération de SÉLECTION ?', 3);
