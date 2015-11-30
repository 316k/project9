PRAGMA foreign_keys = ON;

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
    vrai INTEGER NOT NULL,
    FOREIGN KEY(question_id) REFERENCES question(id)
);

-- Une catégorie peut avoir des sous-catégories de façon récursive
CREATE TABLE categories(
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT,
    category_id INTEGER DEFAULT NULL,
    FOREIGN KEY(category_id) REFERENCES categories(category_id)
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
    (5, '3FN', 2);

INSERT INTO cours VALUES
    (1, 'Bases de données', 'IFT2935'),
    (2, 'Génie Logiciel', 'IFT2935'),
    (3, 'Génie Logiciel 2 : la vengence des classes abstraites', 'IFT2935'),
    (4, 'Génie Logiciel 3 : le retour des interfaces d''AbstractFactoryFactory', 'IFT2935');

INSERT INTO partie_cours VALUES
    (1, 'Première partie : Introduction', 1),
    (2, 'Deuxième partie : Modèle Entité Relation', 1),
    (3, 'Troisième partie : Modèle Relationnel', 1),
    (4, 'Quatrième partie : L''algèbre et le calcul Relationnel', 1),
    (5, 'Partie 1 : les différences entre le code et le programmeur', 2),
    (6, 'Partie 2 : intro à l''overengineering', 2),
    (7, 'Partie 3 : l''overengineering généralisé', 2),
    (8, 'Partie 4 : l''overengineering généré par ordinateur', 2),
    (9, 'Partie 1 : Les vertues de l''abstraction', 4),
    (10, 'Partie 2 : L''abstraction et la vertue', 4),
    (11, 'Partie 3 : le rôle des factoryFactory dans l''abstraction', 4),
    (12, 'Partie 4 : L''abstraction des factoryFactory par une interface', 4),
    (13, '1 : La guerre des singletons', 3),
    (14, '2 : 300 MVC', 3);

INSERT INTO questions VALUES
    (1, 'Qu''est-ce qu''une base de données ?', 1),
    (2, 'Pourquoi a-t-on besoin de bases de données ?', 1),
    (3, 'Qu''est-ce qu''un attribut clé ?', 2),
    (4, 'Qu''est-ce qu''un attribut composite ?', 2),
    (5, 'Nommez un types de contrainte d''intégrité relationnelle ?', 3),
    (6, 'Quel est le symbol pour l''opération de SÉLECTION ?', 3),
    (7, 'Quel est l''utilité de la thêta jointure ?', 4),
    (8, 'Existe-t-il un opérateur nommé sesqui-jointure ?', 4),
    (9, 'Le vice-président d''hydro-québec a-t-il suivi ce cours ?', 1),
    (10, 'Entre ces deux énoncé, lequel est un programmeur ?', 5),
    (11, 'Laquelle de ces caractéristiques appartient au code ?', 5),
    (12, 'Combien de Factory sont nécessaires par 1000 lignes de code ?', 6),
    (13, 'Quelle est la première règle de l''overengineering ?', 6),
    (14, 'Quel patron de conception permet le mieux de généraliser du code ?', 7),
    (15, 'Quel patron de conception permet d''OOifier un système ?', 7),
    (16, 'Quel langage permet de générer du code ?', 8),
    (17, 'Pourquoi le code généré est-il meilleur ?', 8),
    (18, 'Laquelle parmis ces vertues est une vertue de l''abstraction ?', 9),
    (19, 'Nommez un commandement de l''abstraction ?', 9),
    (20, 'Nommez un des péchés capitaux de l''abstraction ?', 10),
    (21, 'Quel est l''avantage principal de l''abstraction ?', 10),
    (22, 'À quel moment devriez-vous utiliser un factoryFactory ?', 11),
    (23, 'Quelle est l''utilité des factoryFactory ?', 11),
    (24, 'Quel est l''avantage de l''utilisation d''une interface ?', 12),
    (25, 'Quand devriez-vous utiliser une interface ?', 12),
    (26, 'Combien doit-it y avoir d''instances de singletons ?', 13),
    (27, 'Nommez le livre dans lequel le singleton a été décrit ?', 13),
    (28, 'Nommez la troisième partie du MVC ?', 14),
    (29, 'À quoi sert la vue ?', 14);

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
    (NULL, ':D', 6, 0),
    (NULL, '\sigma', 6, 1),
    (NULL, 'Elle sert a joindre deux tables sur une condition', 7, 1),
    (NULL, 'On peut s''en servir pour générer du code', 7, 0),
    (NULL, 'Vrai', 8, 0),
    (NULL, 'Faux', 8, 1),
    (NULL, 'Oui', 9, 1),
    (NULL, 'Non', 9, 0),
    (NULL, 'Bill Gates', 10, 1),
    (NULL, 'print("hello wolrd"', 10, 0),
    (NULL, 'Il est exécutable', 11, 1),
    (NULL, 'Il est mangeable', 11, 0),
    (NULL, '1', 12, 0),
    (NULL, '7', 12, 0),
    (NULL, 'plus', 12, 1),
    (NULL, 'Plus de patterns', 13, 1),
    (NULL, 'Seulement les patterns nécessaires', 13, 0),
    (NULL, 'Abstract Visitor', 14, 1),
    (NULL, 'Concrete Builder', 14, 0),
    (NULL, 'Facade', 15, 1),
    (NULL, 'Observer', 15, 0),
    (NULL, 'UML', 16, 1),
    (NULL, 'Tous', 16, 0),
    (NULL, 'Il est démontrablement rigoureux', 17, 1),
    (NULL, 'Les machines sont strictement supérieures aux humains', 17, 0),
    (NULL, 'La réutilisabilité', 18, 1),
    (NULL, 'La performance', 18, 0),
    (NULL, 'Inverser les dépendences, tu dois', 19, 1),
    (NULL, 'Avec modération, les interfaces tu utiliseras', 19, 0),
    (NULL, 'Le couplage élevé', 20, 1),
    (NULL, 'Une cohésion élevée', 20, 0),
    (NULL, 'L''abstraction permet de rendre certaines structures plus génériques', 21, 1),
    (NULL, 'L''abstraction permet de rendre le code moins volumineux', 21, 0);

INSERT INTO question_categories VALUES
    ();
