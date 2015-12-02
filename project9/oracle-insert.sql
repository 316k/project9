---------------------
-- Valeurs de test --
INSERT INTO categories VALUES(1, 'Normalisation des bases de données', NULL);
INSERT INTO categories VALUES(2, 'Formes normales', 1);
INSERT INTO categories VALUES(3, '1FN', 2);
INSERT INTO categories VALUES(4, '2FN', 2);
INSERT INTO categories VALUES(5, '3FN', 2);
INSERT INTO categories VALUES(6, 'Interactions machine-humain', NULL);
INSERT INTO categories VALUES(7, 'Caractéristiques du code', 6);
INSERT INTO categories VALUES(8, 'Caractéristiques des humains', 6);
INSERT INTO categories VALUES(9, 'Questionnement', NULL);
INSERT INTO categories VALUES(10, 'QCM', 9);

INSERT INTO professeurs VALUES(1, 'Claude', 'Frasson', 'ift2935');
INSERT INTO professeurs VALUES(2, 'Jackie', 'LaTruite', 'mot-de-passe');
INSERT INTO professeurs VALUES(3, 'Erick', 'Gamma', 'connect-four');
INSERT INTO professeurs VALUES(4, 'Esma', 'Aimeur', 'ift2935');

INSERT INTO cours VALUES('IFT2935', 'Bases de données');

INSERT INTO professeur_cours VALUES(1, 'IFT2935');
INSERT INTO professeur_cours VALUES(4, 'IFT2935');

INSERT INTO partie_cours VALUES(1, 'Première partie : Introduction', 'IFT2935');
INSERT INTO partie_cours VALUES(2, 'Deuxième partie : Modèle Entité Relation', 'IFT2935');
INSERT INTO partie_cours VALUES(3, 'Troisième partie : Modèle Relationnel', 'IFT2935');
INSERT INTO partie_cours VALUES(4, 'Quatrième partie : L''algèbre et le calcul Relationnel', 'IFT2935');

INSERT INTO questions VALUES(id, content, partie_cours_id)(1, 'Qu''est-ce qu''une base de données ?', 1);
INSERT INTO questions VALUES(id, content, partie_cours_id)(2, 'Pourquoi a-t-on besoin de bases de données ?', 1);
INSERT INTO questions VALUES(id, content, partie_cours_id)(3, 'Qu''est-ce qu''un attribut clé ?', 2);
INSERT INTO questions VALUES(id, content, partie_cours_id)(4, 'Qu''est-ce qu''un attribut composite ?', 2);
INSERT INTO questions VALUES(id, content, partie_cours_id)(5, 'Nommez un types de contrainte d''intégrité relationnelle', 3);
INSERT INTO questions VALUES(id, content, partie_cours_id)(6, 'Quel est le symbol pour l''opération de SÉLECTION ?', 3);
INSERT INTO questions VALUES(id, content, partie_cours_id)(7, 'Quel est l''utilité de la thêta jointure ?', 4);
INSERT INTO questions VALUES(id, content, partie_cours_id)(8, 'Existe-t-il un opérateur nommé sesqui-jointure ?', 4);
INSERT INTO questions VALUES(id, content, partie_cours_id)(9, 'Un vice-président d''Hydro Québec a-t-il déjà suivi un cours de bases de données à l''UdeM avec Claude Frasson ?', 1);

INSERT INTO reponses VALUES(1, 'Une sorte de champginon', 1, 0);
INSERT INTO reponses VALUES(2, 'Une structure servant à organiser des données', 1, 1);
INSERT INTO reponses VALUES(3, 'Pour organiser efficacement des données', 2, 1);
INSERT INTO reponses VALUES(4, 'Pour faire de délicieux biscuits', 2, 0);
INSERT INTO reponses VALUES(5, 'Un attribut pouvant ouvrir une porte', 3, 0);
INSERT INTO reponses VALUES(6, 'Un attribut identifiant un tuple', 3, 1);
INSERT INTO reponses VALUES(7, 'Un attribut comportant plusieurs sous-données', 4, 1);
INSERT INTO reponses VALUES(8, 'Un attribut en matériaux renforcés', 4, 0);
INSERT INTO reponses VALUES(9, 'Unique', 5, 1);
INSERT INTO reponses VALUES(10, 'Additif', 5, 0);
INSERT INTO reponses VALUES(11, ':D', 6, 0);
INSERT INTO reponses VALUES(12, 'Sigma', 6, 1);
INSERT INTO reponses VALUES(13, 'Elle sert à joindre deux tables sur une condition', 7, 1);
INSERT INTO reponses VALUES(14, 'On peut en parsemer sur la dinde à Noël', 7, 0);
INSERT INTO reponses VALUES(15, 'Vrai', 8, 0);
INSERT INTO reponses VALUES(16, 'Faux', 8, 1);
INSERT INTO reponses VALUES(17, 'Oui', 9, 1);
INSERT INTO reponses VALUES(18, 'Non', 9, 0);

INSERT INTO question_categories
    SELECT id, 10 FROM questions;

-- WITH RECURSIVE parent(category_id, nom, level) AS (SELECT category_id, name, 0 FROM categories WHERE id=? UNION ALL SELECT categories.category_id, categories.name, parent.level + 1 FROM categories JOIN parent ON parent.category_id=categories.id) SELECT * FROM parent
