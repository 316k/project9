# Projet 9

Présenté par Patrice Dumontier-Houle, Guillaume Riou, Nicolas Hurtubis et Mathieu Morin

## Introduction

Le projet que nous avons menÃ© a terme consiste en un systÃ¨me de questions Ã  choix multiples. Notre projet vise Ã  rassembler des connaissances pertinentes Ã  la rÃ©eussite d'un cours afin que les Ã©tudiants puissent tester leurs connaissances de maniÃ¨re efficaces et attrayantes. Notre systÃ¨me est conÃ§u pour accumuler de l'information Ã  propos des rÃ©ponses des Ã©tudiants aux questions de maniÃ¨re Ã  ce qu'un professeur puisse cibler la matiÃ¨re moins comprise. En utilisant cet outil, les professeurs pourront structurer leurs cours en fonctions des difficultÃ©s des Ã©lÃ¨ves de maniÃ¨re Ã  optimiser le temps de cours.

## Diagramme E-R

![]()

Le diagramme entité-relation a l'entité *professeur*, qui est identifié uniquement par son id. Ses propriétés sont son prénom, son nom et son mot-de-passe. Un professeur peut donner 0 ou plusieurs cours et a accès à une section spéciale du site.

Une entité *cours* est représentée par son sigle (par exemple `IFT2935`) et a comme attribut un nom de cours.

Chaque cours est subdivisé en parties de cours (entité *partie_cours*), identifiées par leur id et qui ont comme informations le nom de la partie (name).

Une question est faite avec comme sujet la partie du cours concernée. Une question a un id comme identifiant et a comme information son contenu (content), le nombre de réponses répondues correctement à la question (success) et le nombre de réponses répondues incorrectement à la question (failures). Ces nombres permettront au professeur qui se sert de la base de données à faire des statistiques. De plus, la question a une référence à la partie de cours qui la concerne (partie_cours_id). Les réponses à la 
question ont comme identifiant un id et ont comme information leur description (texte), un nombre 
qui représente la validité de la réponse (0 pour faux, 1 pour vrai) et une référence à la question 
associée (question_id). De plus, chaque question est classifiée par sa catégorie, qui est 
identifiée par son id et qui a comme information son nom (name) et une référence à la catégorie 
qui contient cette catégorie (category_id).


















### Conclusion.
Durant ce projet, nous avons découvert la facilité avec laquelle python peut permettre de développer des applications webs mais nous avons surtout pu constater le défi que représente la gestion d'une base de donnée dans une application non triviale. En effet, dans de tels entreprises, la base de donnée joue un rôle centrale tant dans la conservation des données que dans l'accès à celles-ci. 

Nous avons choisis d'utiliser SQLite pour ce projet puisque la légéreté et la facilité d'installation de ce système nous a rendu la tâche considérablement plus facile et rapide. Les différences syntaxiques entre le SQL accepté par les systèmes Oracles et celui accepté par SQLite ne nous ont pas posés de problèmes majeurs puisque l'apprentissage de l'algèbre relationelle nous a pourvu un cadre théorique solide et invariant sur lequel nous pouvons nous baser dans toutes situations. Notre projet est ainsi complet et pratiquement utilisable mais certaines fonctionnalités telles que l'ajout de questions à la base pourraient être intéressantes à considérer.
