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

-- Cours donn�s par un professeur
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

-- Questions � choix multiples
CREATE TABLE questions(
    id INTEGER NOT NULL PRIMARY KEY,
    content TEXT,
    partie_cours_id INTEGER NOT NULL,
    success INTEGER NOT NULL DEFAULT 0,
    failures INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY(partie_cours_id) REFERENCES partie_cours(id)
);

-- R�ponses des questions
CREATE TABLE reponses(
    id INTEGER NOT NULL PRIMARY KEY,
    texte TEXT,
    question_id INTEGER NOT NULL,
    vrai INTEGER NOT NULL,
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

-- Une cat�gorie peut avoir des sous-cat�gories de fa�on r�cursive
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

-- Notes sur le sch�ma :
--  * les exercices reli�s sont calcul�s � partir des cat�gories associ�es aux questions
--  * Il n'est pas n�cessaire d'associer des sous-cat�gories � un cours, puisqu'on peut retrouver le cours en trouvant r�cursivement le parent (FIXME ?)
-- Notes sur le schéma :
--  * les exercices reliés sont calculés à partir des catégories associées aux questions

---------------------
-- Valeurs de test --
INSERT INTO categories VALUES
    (1, 'Normalisation des bases de donn�es', NULL),
    (2, 'Formes normales', 1),
    (3, 'Les mod�les de donn�es', NULL),
    (4, 'Mod�le entit�-relation', 3),
    (5, 'Mod�le relationnel', 3),
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
    (4, 'Esma', 'A�meur', 'ift2935');

INSERT INTO cours VALUES
    ('IFT2935', 'Bases de donn�es');
    ('IFT1235', 'Programmation');

INSERT INTO professeur_cours VALUES
    (1, 'IFT2935'),
    (4, 'IFT2935'),
    (5, 'IFT1235'),
    (6, 'IFT1235');

INSERT INTO partie_cours VALUES
    (1, 'Premi�re partie : Introduction', 'IFT2935'),
    (2, 'Deuxi�me partie : Mod�le Entit� Relation', 'IFT2935'),
    (3, 'Troisi�me partie : Mod�le Relationnel', 'IFT2935'),
    (4, 'Quatri�me partie : L''alg�bre et le calcul Relationnel', 'IFT2935');
    (10, 'Partie 1 : Introduction', 'IFT1235'),
    (11, 'Partie 2 : Structures de contrôle', 'IFT1235'),
    (12, 'Partie 3 : Les procédures', 'IFT1235'),
    (13, 'Partie 4 : Programmation orientée objet', 'IFT1235');

INSERT INTO questions(id, content, partie_cours_id) VALUES
    (1, 'Qu''est-ce qu''une base de donn�es ?', 1),
    (2, 'Pourquoi a-t-on besoin de bases de donn�es ?', 1),
    (3, 'Qu''est-ce qu''un attribut cl� ?', 2),
    (4, 'Qu''est-ce qu''un attribut composite ?', 2),
    (5, 'Nommez un type de contrainte d''int�grit� relationnelle', 3),
    (6, 'Quel est le symbol pour l''op�ration de S�LECTION ?', 3),
    (7, 'Quel est l''utilit� de la th�ta jointure ?', 4),
    (8, 'Existe-t-il un op�rateur nomm� sesqui-jointure ?', 4),
    (9, 'La 2-forme normale consiste � n''avoir aucun attribut non cl� d�pendant d''une partie de la cl�', 1);

    (10, 'Qu''est-ce qui est une relation dans un mod�le E-R?', 2),
    (11, 'Qu''est-ce qu''une jointure?', 4),
    (12, 'Qu''elle est la diff�rence entre un mod�le E-R et un mod�le relationnel?', 3),
    (13, 'Qu''elle est la diff�rence entre une jointure et une th�ta jointure?', 4),
    (14, 'Pourquoi n''y a-t-il pas d''attributs multivalu�s dans un mod�le relationnel?', 3),
    (15, 'Qu''elle est l''utilit� de l''implantation de la th�ta jointure dans une base de donn�e?', 4),
    (16, 'Qu''est-ce qu''un attribut cl� �trang�re?', 2),
    (17, 'Combien d''attributs cl�s peut contenir une table relationnelle?', 2),
    (18, 'Comment se nomme l''op�ration servant � faire la jointure de deux tables selon un crit�re quelconque sous forme de bool�en?', 4),
    (19, 'Pourquoi devons-nous comprendre l''alg�bre relationnel avant d''apprendre le langage SQL?', 4),
    (20, 'Qu''elle est la diff�rence entre une entit� et une relation?', 2),
    
    (30, 'Laquelle de ces définitions représente une variable ?', 10),
    (31, 'Qu''est-ce qu''un interpréteur ?', 10),
    (32, 'Que devrait-t-on mettre au début d''un switch ?', 11),
    (33, 'Quelle est la différence entre un while et un do while ?', 11),
    (34, 'En python, quel mot clé permet de retourner une valeur d''une fonction ?', 12),
    (35, 'En java, quel est le type déclaré d''une fonction ne retournant rien ?', 12),
    (36, 'Qu''est-ce qu''un objet ?', 13),
    (37, 'Quel est le premier paramètre de toute méthode d''un objet en python ?', 13);

INSERT INTO reponses VALUES
    (NULL, 'Un ordinateur distant contenant un programme', 1, 0),
    (NULL, 'Une structure servant � organiser des donn�es', 1, 1),
    (NULL, 'Pour organiser efficacement des donn�es', 2, 1),
    (NULL, 'Pour mettre des programmes sur internet', 2, 0),
    (NULL, 'Un attribut permettant d''acc�der � la structure interne de la base', 3, 0),
    (NULL, 'Un attribut identifiant un tuple', 3, 1),
    (NULL, 'Un attribut comportant plusieurs sous-donn�es', 4, 1),
    (NULL, 'Un attribut r�f�renc� � plusieurs endroits', 4, 0),
    (NULL, 'Unique', 5, 1),
    (NULL, 'Additif', 5, 0),
    (NULL, 'Pi', 6, 0),
    (NULL, 'Sigma', 6, 1),
    (NULL, 'Elle sert � joindre deux tables sur une condition', 7, 1),
    (NULL, 'Elle sert � �liminer des colonnes dans un tuple', 7, 0),
    (NULL, 'Vrai', 8, 0),
    (NULL, 'Faux', 8, 1),
    (NULL, 'Vrai', 9, 1),
    (NULL, 'Faux', 9, 0),
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
    (NULL, 'Une donnée complexe regroupant plusieurs types de données ainsi que des fonctions', 36, 1),
    (NULL, 'Une représentation en mémoire d''un élément de base de donnée', 36, 0),
    (NULL, 'self', 37, 0),
    (NULL, 'l''objet lui-même', 37, 1),
    (NULL, 'Tout', 10, 0),
    (NULL, 'Les losanges seulement', 10, 1),
    (NULL, 'Une union suivie d''une s�lection', 11, 1),
    (NULL, 'Une union suivie d''une projection', 11, 0),
    (NULL, 'La perspective de l''entit�', 12, 1),
    (NULL, 'Les relations entre entit�s', 12, 0),
    (NULL, 'Les possibilit�s de condition de s�lection qui suit l''union', 13, 0),
    (NULL, 'La condition de s�lection qui suit l''union', 13, 1),
    (NULL, 'Il y en a, la question n''a pas de sens.', 14, 0),
    (NULL, 'Puisque chaque valeur identifie une relation diff�rente.', 14, 1),
    (NULL, 'L''opportunit� de faire des jointures avec des conditions vari�es.', 15, 1),
    (NULL, 'Impressionner le client.', 15, 0),
    (NULL, 'Un attribut qui r�f�re � une autre table relationnelle.', 16, 1),
    (NULL, 'Un attribut cl� qui r�f�re � une autre table relationnelle.', 16, 0),
    (NULL, '1 attribut cl� seulement.', 17, 0),
    (NULL, 'Autant que n�cessaire.', 17, 1),
    (NULL, 'La sesqui-jointure', 18, 0),
    (NULL, 'La th�ta jointure', 18, 1),
    (NULL, 'Puisque l''alg�bre relationnel aide � faire des requ�tes complexes.', 19, 0),
    (NULL, 'Puisque l''alg�bre relationnel aide � rendre simple les notions complexes des requ�tes SQL.', 19, 1),
    (NULL, 'L''entit� peut �tre per�ue comme �tant une relation, mais pas n�cessairement l''inverse.', 20, 1),
    (NULL, 'Une entit� est concr�te alors qu''une relation est abstraite et les deux sont distinctes.', 20, 0);

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
