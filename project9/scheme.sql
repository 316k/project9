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

---------------------
-- Valeurs de test --
INSERT INTO categories VALUES
    (1, 'Normalisation des bases de donn�es', NULL),
    (2, 'Formes normales', 1),
    (3, '1FN', 2),
    (4, '2FN', 2),
    (5, '3FN', 2),
    (6, 'Interactions machine-humain', NULL),
    (7, 'Caract�ristiques du code', 6),
    (8, 'Caract�ristiques des humains', 6),
    (9, 'Questionnement', NULL),
    (10, 'QCM', 9);

INSERT INTO professeurs VALUES
    (1, 'Claude', 'Frasson', 'ift2935'),
    (2, 'Jackie', 'LaTruite', 'mot-de-passe'),
    (3, 'Erick', 'Gamma', 'connect-four'),
    (4, 'Esma', 'A�meur', 'ift2935');

INSERT INTO cours VALUES
    ('IFT2935', 'Bases de donn�es');

INSERT INTO professeur_cours VALUES
    (1, 'IFT2935'),
    (4, 'IFT2935');

INSERT INTO partie_cours VALUES
    (1, 'Premi�re partie : Introduction', 'IFT2935'),
    (2, 'Deuxi�me partie : Mod�le Entit� Relation', 'IFT2935'),
    (3, 'Troisi�me partie : Mod�le Relationnel', 'IFT2935'),
    (4, 'Quatri�me partie : L''alg�bre et le calcul Relationnel', 'IFT2935');

INSERT INTO questions(id, content, partie_cours_id) VALUES
    (1, 'Qu''est-ce qu''une base de donn�es ?', 1),
    (2, 'Pourquoi a-t-on besoin de bases de donn�es ?', 1),
    (3, 'Qu''est-ce qu''un attribut cl� ?', 2),
    (4, 'Qu''est-ce qu''un attribut composite ?', 2),
    (5, 'Nommez un type de contrainte d''int�grit� relationnelle', 3),
    (6, 'Quel est le symbol pour l''op�ration de S�LECTION ?', 3),
    (7, 'Quel est l''utilit� de la th�ta jointure ?', 4),
    (8, 'Existe-t-il un op�rateur nomm� sesqui-jointure ?', 4),
    (9, 'Un vice-pr�sident d''Hydro Qu�bec a-t-il d�j� suivi un cours de bases de donn�es � l''UdeM avec Claude Frasson ?', 1);

    (10, 'Qu''est-ce qui est une relation dans un mod�le E-R?', 2),
    (11, 'Qu''est-ce qu''une jointure?', 4),
    (12, 'Qu''elle est la diff�rence entre un mod�le E-R et un mod�le relationnel?', 3),
    (13, 'Qu''elle est la diff�rence entre une jointure et une th�ta jointure?', 4),
    (14, 'Pourquoi n''y a-t-il pas d''attributs multivalu�s dans un mod�le relationnel?', 3),
    (15, 'Qu''elle est l''utilit� de l''implantation de la th�ta jointure dans une base de donn�e?', 4),
    (16, 'Qu''est-ce qu''un attribut cl� �trang�re?', 2),
    (17, 'Combien d''attributs cl�s peut contenir une table relationnelle?', 2),
    (18, 'Comment se nomme l''op�ration servant � faire la jointure de deux tables selon un crit�re sous forme de bool�en?', 4),
    (19, 'Pourquoi devons-nous comprendre l''alg�bre relationnel avant d''apprendre le langage SQL?', 4),
    (20, 'Qu''elle est la diff�rence entre une entit� et une relation?', 2)
    
INSERT INTO reponses VALUES
    (NULL, 'Une sorte de champginon', 1, 0),
    (NULL, 'Une structure servant � organiser des donn�es', 1, 1),
    (NULL, 'Pour organiser efficacement des donn�es', 2, 1),
    (NULL, 'Pour faire de d�licieux biscuits', 2, 0),
    (NULL, 'Un attribut pouvant ouvrir une porte', 3, 0),
    (NULL, 'Un attribut identifiant un tuple', 3, 1),
    (NULL, 'Un attribut comportant plusieurs sous-donn�es', 4, 1),
    (NULL, 'Un attribut en mat�riaux renforc�s', 4, 0),
    (NULL, 'Unique', 5, 1),
    (NULL, 'Additif', 5, 0),
    (NULL, ':D', 6, 0),
    (NULL, 'Sigma', 6, 1),
    (NULL, 'Elle sert � joindre deux tables sur une condition', 7, 1),
    (NULL, 'On peut en parsemer sur la dinde � No�l', 7, 0),
    (NULL, 'Vrai', 8, 0),
    (NULL, 'Faux', 8, 1),
    (NULL, 'Oui', 9, 1),
    (NULL, 'Non', 9, 0);

INSERT INTO question_categories
    SELECT id, 10 FROM questions;

-- WITH RECURSIVE parent(category_id, nom, level) AS (SELECT category_id, name, 0 FROM categories WHERE id=? UNION ALL SELECT categories.category_id, categories.name, parent.level + 1 FROM categories JOIN parent ON parent.category_id=categories.id) SELECT * FROM parent

PRAGMA foreign_keys = ON;
