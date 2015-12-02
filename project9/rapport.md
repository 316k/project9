#Projet #9
## Présenté par Patrice Dumontier-Houle, Guillaume Riou, Nicolas Hurtubis et Mathieu Morin

### Introduction
Le projet que nous avons mené a terme consiste en un système de questions à choix multiples. Les

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
 Nous avons implantés plusieurs fonctionnalités que nous trouvions pertinentes pour un projet de la sorte tel que la classification de questions par parties de cours ou par catégories ainsi que des statistiques plus avancées. Bien entendu, le système de base de donnée est essentiel au fonctionnement d'un tel projet. Pour l'implantation logiciel du projet nous nous sommes tournés vers une application web utilisant le framework flask en python ainsi que le système de base de donnée SQLite que nous avons choisis pour sa légèreté et sa simplicité.


>>>>>>> 2eb45505a0926bbd0ba03b014304a75b08756718
