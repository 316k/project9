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
INSERT INTO categories VALUES(15, 'Syntaxe', NULL);
INSERT INTO categories VALUES(16, 'Expression Conditionelles', 15);
INSERT INTO categories VALUES(17, 'Programmation Orientée Objet', NULL);
INSERT INTO categories VALUES(18, 'Méthodes', 17);
INSERT INTO categories VALUES(19, 'Objets', 17);


INSERT INTO professeurs VALUES(1, 'Claude', 'Frasson', 'ift2935');
INSERT INTO professeurs VALUES(2, 'Jackie', 'LaTruite', 'mot-de-passe');
INSERT INTO professeurs VALUES(3, 'Erick', 'Gamma', 'connect-four');
INSERT INTO professeurs VALUES(4, 'Esma', 'Aïmeur', 'ift2935');
INSERT INTO professeurs VALUES(5, 'Bertrand', 'Dion', 'ift1235');
INSERT INTO professeurs VALUES(6, 'Jasmine', 'Francoeur', 'ift1235');

INSERT INTO cours VALUES('IFT2935', 'Bases de données');
INSERT INTO cours VALUES('IFT1235', 'Programmation');

INSERT INTO professeur_cours VALUES(1, 'IFT2935');
INSERT INTO professeur_cours VALUES(4, 'IFT2935');
INSERT INTO professeur_cours VALUES(5, 'IFT1235');
INSERT INTO professeur_cours VALUES(6, 'IFT1235');

INSERT INTO partie_cours VALUES(1, 'Première partie : Introduction', 'IFT2935');
INSERT INTO partie_cours VALUES(2, 'Deuxième partie : Modèle Entité Relation', 'IFT2935');
INSERT INTO partie_cours VALUES(3, 'Troisième partie : Modèle Relationnel', 'IFT2935');
INSERT INTO partie_cours VALUES(4, 'Quatrième partie : L''algèbre et le calcul Relationnel', 'IFT2935');
INSERT INTO partie_cours VALUES(10, 'Partie 1 : Introduction', 'IFT1235');
INSERT INTO partie_cours VALUES(11, 'Partie 2 : Structures de contrôle', 'IFT1235');
INSERT INTO partie_cours VALUES(12, 'Partie 3 : Les procédures', 'IFT1235');
INSERT INTO partie_cours VALUES(13, 'Partie 4 : Programmation orientée objet', 'IFT1235');


INSERT INTO questions(id, content, partie_cours_id) VALUES(1, 'Qu''est-ce qu''une base de données ?', 1);
INSERT INTO questions(id, content, partie_cours_id) VALUES(2, 'Pourquoi a-t-on besoin de bases de données ?', 1);
INSERT INTO questions(id, content, partie_cours_id) VALUES(3, 'Qu''est-ce qu''un attribut clé ?', 2);
INSERT INTO questions(id, content, partie_cours_id) VALUES(4, 'Qu''est-ce qu''un attribut composite ?', 2);
INSERT INTO questions(id, content, partie_cours_id) VALUES(5, 'Nommez un types de contrainte d''intégrité relationnelle', 3);
INSERT INTO questions(id, content, partie_cours_id) VALUES(6, 'Quel est le symbol pour l''opération de SÉLECTION ?', 3);
INSERT INTO questions(id, content, partie_cours_id) VALUES(7, 'Quel est l''utilité de la thêta jointure ?', 4);
INSERT INTO questions(id, content, partie_cours_id) VALUES(8, 'Existe-t-il un opérateur nommé sesqui-jointure ?', 4);
INSERT INTO questions(id, content, partie_cours_id) VALUES(9, 'Un vice-président d''Hydro Québec a-t-il déjà suivi un cours de bases de données à l''UdeM avec Claude Frasson ?', 1);
INSERT INTO questions(id, content, partie_cours_id) VALUES(30, 'Laquelle de ces définitions représente une variable ?', 10);
INSERT INTO questions(id, content, partie_cours_id) VALUES(31, 'Qu''es-ce qu''un interpréteur ?', 10);
INSERT INTO questions(id, content, partie_cours_id) VALUES(32, 'Que devrait-t-on mettre au début d''un switch ?', 11);
INSERT INTO questions(id, content, partie_cours_id) VALUES(33, 'Quelle est la différence entre un while et un do while ?', 11);
INSERT INTO questions(id, content, partie_cours_id) VALUES(34, 'En python, quel mot clé permet de retourner une valeur d''une fonction ?', 12);
INSERT INTO questions(id, content, partie_cours_id) VALUES(35, 'En java, quel est le type déclaré d''une fonction ne retournant rien ?', 12);
INSERT INTO questions(id, content, partie_cours_id) VALUES(36, 'Qu''es-ce qu''un objet ?', 13);
INSERT INTO questions(id, content, partie_cours_id) VALUES(37, 'Quel est le premier paramètre de toute méthode d''un objet en python ?', 13);

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
INSERT INTO reponses VALUES(21, 'Pi', 6, 0);
INSERT INTO reponses VALUES(22, 'Sigma', 6, 1);
INSERT INTO reponses VALUES(23, 'Elle sert à joindre deux tables sur une condition', 7, 1);
INSERT INTO reponses VALUES(24, 'On peut en parsemer sur la dinde à Noël', 7, 0);
INSERT INTO reponses VALUES(25, 'Vrai', 8, 0);
INSERT INTO reponses VALUES(26, 'Faux', 8, 1);
INSERT INTO reponses VALUES(27, 'Oui', 9, 1);
INSERT INTO reponses VALUES(28, 'Non', 9, 0);
INSERT INTO reponses VALUES(29, 'Une variable est un paramètre permettant de changer le flot d''exécution d''un programme', 30, 0);
INSERT INTO reponses VALUES(30, 'Une variable est un emplacement mémoire réservé dans lequel on peut storer des données', 30, 1);
INSERT INTO reponses VALUES(31, 'Un interpréteur est un programme permettant d''éxécuter du code non compilé', 31, 1);
INSERT INTO reponses VALUES(32, 'Un interpréteur permet de transférer un programme sur un serveur distant', 31, 0);
INSERT INTO reponses VALUES(33, 'La variable que l''on veut tester', 32, 1);
INSERT INTO reponses VALUES(34, 'Le code qu''on veut exécuter', 32, 0);
INSERT INTO reponses VALUES(35, 'Dans un do while, le code s''exécute au moins une fois', 33, 1);
INSERT INTO reponses VALUES(36, 'Il n''y a aucune différence', 33, 0);
INSERT INTO reponses VALUES(37, 'Un do while est plus optimisé',33, 0);
INSERT INTO reponses VALUES(38, 'give', 34, 0);
INSERT INTO reponses VALUES(39, 'return', 34, 1);
INSERT INTO reponses VALUES(40, 'end', 34, 0);
INSERT INTO reponses VALUES(41, 'null', 35, 0);
INSERT INTO reponses VALUES(42, 'void', 35, 1);
INSERT INTO reponses VALUES(43, 'nil', 35, 0);
INSERT INTO reponses VALUES(44, 'Une donnée complexe regroupant plusieurs types de données ainsi que des fonctions', 36, 1);
INSERT INTO reponses VALUES(45, 'Une représentation en mémoire d''un élément de base de donnée', 36, 0);
INSERT INTO reponses VALUES(46, 'self', 37, 0);
INSERT INTO reponses VALUES(47, 'l''objet lui-même', 37, 1);

INSERT INTO question_categories VALUES(32, 15);
INSERT INTO question_categories VALUES(33, 16);
INSERT INTO question_categories VALUES(34, 15);
INSERT INTO question_categories VALUES(35, 15);
INSERT INTO question_categories VALUES(36, 19);
INSERT INTO question_categories VALUES(37, 18);

INSERT INTO question_categories 
    SELECT id, 10 FROM questions;
