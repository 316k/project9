# Projet 9

Présenté par Mathieu Morin, Patrice Dumontier-Houle, Guillaume Riou et Nicolas Hurtubise

## Introduction

Le projet que nous avons mené a terme consiste en un système de questions à choix multiples, pouvant être adapté à élèves de tous les niveaux. Notre projet vise à rassembler des connaissances pertinentes à la réeussite d'un cours afin que les étudiants puissent tester leurs connaissances de manière efficace et interactive.

Notre système est conçu pour accumuler de l'information à propos des réponses des étudiants aux questions de manière à ce qu'un professeur puisse cibler la matière moins comprise. En utilisant cet outil, les professeurs pourront structurer leurs cours en fonctions des difficultés des élèves de manière à passer moins de temps à réviser les concepts les mieux assimilés, et plus de temps à focuser sur les sujets que les élèves saisissent le moins.

## Modèle Entité Relation

![Diagramme ER](Diag-ER.jpg)

Le Modèle Entité Relation de notre projet comporte l'entité *professeur*, qui est identifiée uniquement par son id. Ses propriétés sont son prénom, son nom et son mot de passe. Un professeur peut donner 0 ou plusieurs cours et a accès à une section spéciale du site en se logguant avec ses identifiants.

Une entité *cours* est représentée par son sigle (par exemple `IFT2935`) et a comme attribut un nom de cours.

Chaque cours est subdivisé en parties de cours (entité *partie_cours*), qui sont identifiées par leur id et qui ont comme informations le nom de la partie (name).

Chaque entité *question* est associée à une partie de cours. Une question a un id comme identifiant et a contient son énnoncé (content), le nombre de fois qu'une personne a répondu correctement à la question (success) et le nombre de fois qu'une personne a répondu incorrectement à la question (failures). Ces nombres sont particulièrement utiles pour les professeurs désirant faire des statistiques sur les sujets les mieux compris et les plus difficilement compris par les élèves.

Les entités *réponse* consistent en des choix de réponse offerts à une question donnée et sont identifiées par un id.
Chaque réponse contient l'énoncé de réponse (texte), ainsi qu'une valeur de vérité indiquant s'il s'agit d'une réponse valide ou non (0 pour faux, 1 pour vrai).

De plus, chaque question est classifiée par sa catégorie, qui est identifiée par son id, et qui a comme information son nom (name).

Les catégories sont liées à elles-mêmes via une relation N vers 1, permettant ainsi une hiérarchie de catégories et de sous-catégories. Par exemple, on pourra avoir la catégorie "Normalisation des bases de données", qui contiendra le sujet plus spécifique "Formes normales", lui-même composé des sous-sous-catégories "1FN", "2FN", "3FN", etc.

## Modèle Relationnel

![Diagramme R](Diag-R.jpg)

Le modèle relationel de notre projet est calqué sur notre Modèle Entité Relation, mais est beaucoup plus proche du modèle utilisé par notre application.

D'un point de vue du SQL, nos définissions de relations sont les suivantes :

```
-- Professeurs
CREATE TABLE professeurs(
    id number(10) NOT NULL,
    prenom char(30),
    nom char(30),
    mot_de_passe char(30),
    PRIMARY KEY(id)
);

-- Cours
CREATE TABLE cours(
    sigle char(7) NOT NULL,
    name varchar(127) NOT NULL,
    PRIMARY KEY(sigle)
);

-- Cours donnés par un professeur
CREATE TABLE professeur_cours(
    professeur_id number(10) NOT NULL,
    cours_id char(7) NOT NULL,
    FOREIGN KEY(professeur_id) REFERENCES professeurs(id),
    FOREIGN KEY(cours_id) REFERENCES cours(sigle),
    PRIMARY KEY (professeur_id, cours_id)
);

-- Partie de cours = Chapitre/section dans un cours
CREATE TABLE partie_cours(
    id number(10) NOT NULL,
    name varchar(127),
    cours_id char(7) NOT NULL,
    FOREIGN KEY(cours_id) REFERENCES cours(sigle),
    PRIMARY KEY(id)
);

-- Questions à choix multiples
CREATE TABLE questions(
    id number(10) NOT NULL,
    content varchar(127) NOT NULL,
    partie_cours_id number(10) NOT NULL,
    success number(10) DEFAULT 0 NOT NULL,
    failures number(10) DEFAULT 0 NOT NULL,
    FOREIGN KEY(partie_cours_id) REFERENCES partie_cours(id),
    PRIMARY KEY(id)
);

-- Réponses des questions
CREATE TABLE reponses(
    id number(10) NOT NULL,
    texte varchar(127),
    question_id number(10) NOT NULL,
    vrai number(1) NOT NULL,
    FOREIGN KEY(question_id) REFERENCES questions(id),
    PRIMARY KEY(id)
);

-- Une catégorie peut avoir des sous-catégories de façon récursive
CREATE TABLE categories(
    id number(10) NOT NULL,
    name varchar(127),
    category_id number(10) DEFAULT NULL,
    FOREIGN KEY(category_id) REFERENCES categories(id),
    PRIMARY KEY(id)
);

-- Associations entre catégories et questions
CREATE TABLE question_categories(
    question_id number(10) NOT NULL,
    category_id number(10) NOT NULL,
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(category_id) REFERENCES categories(id),
    PRIMARY KEY (question_id, category_id)
);
```

## L'Application

L'application est divisée en sections suivant les fonctionnalités suivantes :

1. Réponse à des questions aléatoires (qui peuvent être tirées au sort parmi les catégories, les cours, les parties de cours, etc.)
2. Recherche de questions et de concepts dans la base de données
3. Visualisation de statistiques propres à plate-forme
4. Visualisation de statistiques propres à chaque cours (page protégée en accès, restreinte aux professeurs concernés)

### 1. Réponse à des questions aléatoires

### 2. Recherche de questions et de concepts dans la base de données

### 3. Visualisation de statistiques propres à la plate-forme

### 4. Visualisation de statistiques propres à chaque cours

## Données utilisées

Les données réalistes utilisées pour des fins de test sont insérées de la façon suivante :

```

```

## Requêtes de l'application




## Conclusion

Durant ce projet, nous avons découvert la facilité avec laquelle python peut permettre de développer des applications webs mais nous avons surtout pu constater le défi que représente la gestion d'une base de donnée dans une application non triviale. En effet, dans de tels entreprises, la base de donnée joue un rôle central tant dans la conservation des données que dans l'accès à celles-ci.

Nous avons choisis d'utiliser SQLite pour ce projet puisque la légéreté et la facilité d'installation de ce système nous a rendu la tâche considérablement plus facile et rapide. Les différences syntaxiques entre le SQL accepté par les systèmes Oracles et celui accepté par SQLite ne nous ont pas posés de problèmes majeurs puisque l'apprentissage de l'algèbre relationelle nous a pourvu un cadre théorique solide et invariant sur lequel nous pouvons nous baser dans toutes situations.

Notre projet est ainsi complet et serait utilisable par les professeurs souhaitant aider leurs élèves via un système web interactif. Il y a cependant toujours place à l'amélioration, certaines fonctionnalités telles qu'une interface en ligne pour ajouter des questions à la base pourraient être intéressantes à considérer.
