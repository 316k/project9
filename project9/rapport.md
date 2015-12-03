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
Nous avons implantÃ©s plusieurs fonctionnalitÃ©s que nous trouvions pertinentes pour un projet de la sorte tel que la classification de questions par parties de cours ou par catÃ©gories ainsi que des statistiques plus avancÃ©es. Bien entendu, le systÃ¨me de base de donnÃ©e est essentiel au fonctionnement d'un tel projet. Pour l'implantation logiciel du projet nous nous sommes tournÃ©s vers une application web utilisant le framework flask en python ainsi que le systÃ¨me de base de donnÃ©e SQLite que nous avons choisis pour sa lÃ©gÃ¨retÃ© et sa simplicitÃ©.


