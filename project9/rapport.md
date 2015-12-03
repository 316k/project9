#Projet #9
## Pr�sent� par Patrice Dumontier-Houle, Guillaume Riou, Nicolas Hurtubis et Mathieu Morin


### Introduction

Le projet que nous avons mené a terme consiste en un système de questions à choix multiples. Notre projet vise à rassembler des connaissances pertinentes à la réeussite d'un cours afin que les étudiants puissent tester leurs connaissances de manière efficaces et attrayantes. Notre système est conçu pour accumuler de l'information à propos des réponses des étudiants aux questions de manière à ce qu'un professeur puisse cibler la matière moins comprise. En utilisant cet outil, les professeurs pourront structurer leurs cours en fonctions des difficultés des élèves de manière à optimiser le temps de cours.

### Diagramme E-R

Le diagramme entit�-relation a l'entit� principale 'professeur', qui est repr�sent� par son id, 
puis qui a comme informations son pr�nom, son nom et son mot-de-passe. Ce professeur donne 
(normalement) un cours, qui est repr�sent� par son sigle (par exemple IFT2935) et qui a comme 
information le nom du cours. Le cours est subdivis� en parties de cours (partie_cours), qui sont 
repr�sent�es par leur id, et qui ont comme information le nom de la partie (name) et une r�f�rence 
au cours qui le contient (cours_id). Maintenant le coeur du sujet, les questions. Une question est 
faite avec comme sujet la partie du cours concern�e. Une question a un id comme identifiant et a 
comme information son contenu (content), le nombre de r�ponses r�pondues correctement � la question 
(success) et le nombre de r�ponses r�pondues incorrectement � la question (failures). Ces nombres 
permettront au professeur qui se sert de la base de donn�es � faire des statistiques. De plus, la 
question a une r�f�rence � la partie de cours qui la concerne (partie_cours_id). Les r�ponses � la 
question ont comme identifiant un id et ont comme information leur description (texte), un nombre 
qui repr�sente la validit� de la r�ponse (0 pour faux, 1 pour vrai) et une r�f�rence � la question 
associ�e (question_id). De plus, chaque question est classifi�e par sa cat�gorie, qui est 
identifi�e par son id et qui a comme information son nom (name) et une r�f�rence � la cat�gorie 
qui contient cette cat�gorie (category_id).


















### Conclusion.
Durant ce projet, nous avons d�couvert la facilit� avec laquelle python peut permettre de d�velopper des applications webs mais nous avons surtout pu constater le d�fi que repr�sente la gestion d'une base de donn�e dans une application non triviale. En effet, dans de tels entreprises, la base de donn�e joue un r�le centrale tant dans la conservation des donn�es que dans l'acc�s � celles-ci. 

Nous avons choisis d'utiliser SQLite pour ce projet puisque la l�g�ret� et la facilit� d'installation de ce syst�me nous a rendu la t�che consid�rablement plus facile et rapide. Les diff�rences syntaxiques entre le SQL accept� par les syst�mes Oracles et celui accept� par SQLite ne nous ont pas pos�s de probl�mes majeurs puisque l'apprentissage de l'alg�bre relationelle nous a pourvu un cadre th�orique solide et invariant sur lequel nous pouvons nous baser dans toutes situations. Notre projet est ainsi complet et pratiquement utilisable mais certaines fonctionnalit�s telles que l'ajout de questions � la base pourraient �tre int�ressantes � consid�rer.
