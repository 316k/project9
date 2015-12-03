-- Professeurs
CREATE TABLE professeurs(
    id INTEGER NOT NULL PRIMARY KEY,
    prenom TEXT,
    nom TEXT,
    mot_de_passe TEXT
);

-- Cours
CREATE TABLE cours(
    sigle TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Cours donnés par un professeur
CREATE TABLE professeur_cours(
    professeur_id INTEGER NOT NULL,
    cours_id TEXT NOT NULL,
    FOREIGN KEY(professeur_id) REFERENCES professeurs(id),
    FOREIGN KEY(cours_id) REFERENCES cours(sigle),
    PRIMARY KEY (professeur_id, cours_id)
);

-- Partie de cours = Chapitre/section dans un cours
CREATE TABLE partie_cours(
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT,
    cours_id TEXT NOT NULL,
    FOREIGN KEY(cours_id) REFERENCES cours(sigle)
);

-- Questions à choix multiples
CREATE TABLE questions(
    id INTEGER NOT NULL PRIMARY KEY,
    content TEXT,
    partie_cours_id INTEGER NOT NULL,
    success INTEGER NOT NULL DEFAULT 0,
    failures INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY(partie_cours_id) REFERENCES partie_cours(id)
);

-- Réponses des questions
CREATE TABLE reponses(
    id INTEGER NOT NULL PRIMARY KEY,
    texte TEXT,
    question_id INTEGER NOT NULL,
    vrai INTEGER NOT NULL,
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

-- Une catégorie peut avoir des sous-catégories de façon récursive
CREATE TABLE categories(
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT,
    category_id INTEGER DEFAULT NULL,
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE question_categories(
    question_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(category_id) REFERENCES categories(id),
    PRIMARY KEY (question_id, category_id)
);

-- Notes sur le schéma :
--  * les exercices reliés sont calculés à partir des catégories associées aux questions
--  * Il n'est pas nécessaire d'associer des sous-catégories à un cours, puisqu'on peut retrouver le cours en trouvant récursivement le parent (FIXME ?)

---------------------
-- Valeurs de test --
INSERT INTO categories VALUES
    (1, 'Normalisation des bases de données', NULL),
    (2, 'Formes normales', 1),
    (3, '1FN', 2),
    (4, '2FN', 2),
    (5, '3FN', 2),
    (6, 'Interactions machine-humain', NULL),
    (7, 'Caractéristiques du code', 6),
    (8, 'Caractéristiques des humains', 6),
    (9, 'Questionnement', NULL),
    (10, 'QCM', 9),
    (15, 'Syntaxe', NULL),
    (16, 'Expression Conditionelles', 15),
    (17, 'Programmation Orientée Objet', NULL),
    (18, 'Méthodes', 17),
    (19, 'Objets', 17);

INSERT INTO professeurs VALUES
    (1, 'Claude', 'Frasson', 'ift2935'),
    (2, 'Jackie', 'LaTruite', 'mot-de-passe'),
    (3, 'Erick', 'Gamma', 'connect-four'),
    (4, 'Esma', 'Aïmeur', 'ift2935'),
    (5, 'Bertrand', 'Dion', 'ift1235'),
    (6, 'Jasmine', 'Francoeur', 'ift1235');

INSERT INTO cours VALUES
    ('IFT2935', 'Bases de données'),
    ('IFT1235', 'Programmation');

INSERT INTO professeur_cours VALUES
    (1, 'IFT2935'),
    (4, 'IFT2935'),
    (5, 'IFT1235'),
    (6, 'IFT1235');

INSERT INTO partie_cours VALUES
    (1, 'Première partie : Introduction', 'IFT2935'),
    (2, 'Deuxième partie : Modèle Entité Relation', 'IFT2935'),
    (3, 'Troisième partie : Modèle Relationnel', 'IFT2935'),
    (4, 'Quatrième partie : L''algèbre et le calcul Relationnel', 'IFT2935'),
    (10, 'Partie 1 : Introduction', 'IFT1235'),
    (11, 'Partie 2 : Structures de contrôle', 'IFT1235'),
    (12, 'Partie 3 : Les procédures', 'IFT1235'),
    (13, 'Partie 4 : Programmation orientée objet', 'IFT1235');

INSERT INTO questions(id, content, partie_cours_id) VALUES
    (1, 'Qu''est-ce qu''une base de données ?', 1),
    (2, 'Pourquoi a-t-on besoin de bases de données ?', 1),
    (3, 'Qu''est-ce qu''un attribut clé ?', 2),
    (4, 'Qu''est-ce qu''un attribut composite ?', 2),
    (5, 'Nommez un types de contrainte d''intégrité relationnelle', 3),
    (6, 'Quel est le symbol pour l''opération de SÉLECTION ?', 3),
    (7, 'Quel est l''utilité de la thêta jointure ?', 4),
    (8, 'Existe-t-il un opérateur nommé sesqui-jointure ?', 4),
    (9, 'Un vice-président d''Hydro Québec a-t-il déjà suivi un cours de bases de données à l''UdeM avec Claude Frasson ?', 1),
    (30, 'Laquelle de ces définitions représente une variable ?', 10),
    (31, 'Qu''es-ce qu''un interpréteur ?', 10),
    (32, 'Que devrait-t-on mettre au début d''un switch ?', 11),
    (33, 'Quelle est la différence entre un while et un do while ?', 11),
    (34, 'En python, quel mot clé permet de retourner une valeur d''une fonction ?', 12),
    (35, 'En java, quel est le type déclaré d''une fonction ne retournant rien ?', 12),
    (36, 'Qu''es-ce qu''un objet ?', 13),
    (37, 'Quel est le premier paramètre de toute méthode d''un objet en python ?', 13);

INSERT INTO reponses VALUES
    (NULL, 'Une sorte de champginon', 1, 0),
    (NULL, 'Une structure servant à organiser des données', 1, 1),
    (NULL, 'Pour organiser efficacement des données', 2, 1),
    (NULL, 'Pour faire de délicieux biscuits', 2, 0),
    (NULL, 'Un attribut pouvant ouvrir une porte', 3, 0),
    (NULL, 'Un attribut identifiant un tuple', 3, 1),
    (NULL, 'Un attribut comportant plusieurs sous-données', 4, 1),
    (NULL, 'Un attribut en matériaux renforcés', 4, 0),
    (NULL, 'Unique', 5, 1),
    (NULL, 'Additif', 5, 0),
    (NULL, 'Pi', 6, 0),
    (NULL, 'Sigma', 6, 1),
    (NULL, 'Elle sert à joindre deux tables sur une condition', 7, 1),
    (NULL, 'On peut en parsemer sur la dinde à Noël', 7, 0),
    (NULL, 'Vrai', 8, 0),
    (NULL, 'Faux', 8, 1),
    (NULL, 'Oui', 9, 1),
    (NULL, 'Non', 9, 0),

    (NULL, 'Une variable est un paramètre permettant de changer le flot d''exécution d''un programme', 30, 0),
    (NULL, 'Une variable est un emplacement mémoire réservé dans lequel on peut storer des données', 30, 1),
    (NULL, 'Un interpréteur est un programme permettant d''éxécuter du code non compilé', 31, 1),
    (NULL, 'Un interpréteur permet de transférer un programme sur un serveur distant', 31, 0),
    (NULL, 'La variable que l''on veut tester', 32, 1),
    (NULL, 'Le code qu''on veut exécuter', 32, 0),
    (NULL, 'Dans un do while, le code s''exécute au moins une fois', 33, 1),
    (NULL, 'Il n''y a aucune différence', 33, 0),
    (NULL, 'Un do while est plus optimisé',33, 0),
    (NULL, 'give', 34, 0),
    (NULL, 'return', 34, 1),
    (NULL, 'end', 34, 0),
    (NULL, 'null', 35, 0),
    (NULL, 'void', 35, 1),
    (NULL, 'nil', 35, 0),
    (NULL, 'Une donnée complex regroupant plusieurs types de données ainsi que des fonctions', 36, 1),
    (NULL, 'Une représentation en mémoire d''un élément de base de donnée', 36, 0),
    (NULL, 'self', 37, 0),
    (NULL, 'l''objet lui-même', 37, 1);

INSERT INTO question_categories VALUES
    (32, 15),
    (33, 16),
    (34, 15),
    (35, 15),
    (36, 19),
    (37, 18);
INSERT INTO question_categories 
    SELECT id, 10 FROM questions;

-- WITH RECURSIVE parent(category_id, nom, level) AS (SELECT category_id, name, 0 FROM categories WHERE id=? UNION ALL SELECT categories.category_id, categories.name, parent.level + 1 FROM categories JOIN parent ON parent.category_id=categories.id) SELECT * FROM parent

PRAGMA foreign_keys = ON;
