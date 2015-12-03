# Projet 9

Pr�sent� par Patrice Dumontier-Houle, Guillaume Riou, Nicolas Hurtubis et Mathieu Morin

## Introduction

Le projet que nous avons mené a terme consiste en un système de questions à choix multiples. Notre projet vise à rassembler des connaissances pertinentes à la réeussite d'un cours afin que les étudiants puissent tester leurs connaissances de manière efficaces et attrayantes. Notre système est conçu pour accumuler de l'information à propos des réponses des étudiants aux questions de manière à ce qu'un professeur puisse cibler la matière moins comprise. En utilisant cet outil, les professeurs pourront structurer leurs cours en fonctions des difficultés des élèves de manière à optimiser le temps de cours.

## Diagramme E-R

![]()

Le diagramme entit�-relation a l'entit� *professeur*, qui est identifi� uniquement par son id. Ses propri�t�s sont son pr�nom, son nom et son mot-de-passe. Un professeur peut donner 0 ou plusieurs cours et a acc�s � une section sp�ciale du site.

Une entit� *cours* est repr�sent�e par son sigle (par exemple `IFT2935`) et a comme attribut un nom de cours.

Chaque cours est subdivis� en parties de cours (entit� *partie_cours*), identifi�es par leur id et qui ont comme informations le nom de la partie (name).

Une question est faite avec comme sujet la partie du cours concern�e. Une question a un id comme identifiant et a comme information son contenu (content), le nombre de r�ponses r�pondues correctement � la question (success) et le nombre de r�ponses r�pondues incorrectement � la question (failures). Ces nombres permettront au professeur qui se sert de la base de donn�es � faire des statistiques. De plus, la question a une r�f�rence � la partie de cours qui la concerne (partie_cours_id). Les r�ponses � la 
question ont comme identifiant un id et ont comme information leur description (texte), un nombre 
qui repr�sente la validit� de la r�ponse (0 pour faux, 1 pour vrai) et une r�f�rence � la question 
associ�e (question_id). De plus, chaque question est classifi�e par sa cat�gorie, qui est 
identifi�e par son id et qui a comme information son nom (name) et une r�f�rence � la cat�gorie 
qui contient cette cat�gorie (category_id).


















### Conclusion.
Nous avons implantés plusieurs fonctionnalités que nous trouvions pertinentes pour un projet de la sorte tel que la classification de questions par parties de cours ou par catégories ainsi que des statistiques plus avancées. Bien entendu, le système de base de donnée est essentiel au fonctionnement d'un tel projet. Pour l'implantation logiciel du projet nous nous sommes tournés vers une application web utilisant le framework flask en python ainsi que le système de base de donnée SQLite que nous avons choisis pour sa légèreté et sa simplicité.


