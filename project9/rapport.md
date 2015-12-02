#Projet #9
## PrÃ©sentÃ© par Patrice Dumontier-Houle, Guillaume Riou, Nicolas Hurtubis et Mathieu Morin

### Introduction
Le projet que nous avons menÃ© a terme consiste en un systÃ¨me de questions Ã  choix multiples. Les

Le diagramme entité-relation a l'entité principale 'professeur', qui est représenté par son id, 
puis qui a comme informations son prénom, son nom et son mot-de-passe. Ce professeur donne 
(normalement) un cours, qui est représenté par son sigle (par exemple IFT2935) et qui a comme 
information le nom du cours. Le cours est subdivisé en parties de cours (partie_cours), qui sont 
représentées par leur id, et qui ont comme information le nom de la partie (name) et une référence 
au cours qui le contient (cours_id). Maintenant le coeur du sujet, les questions. Une question est 
faite avec comme sujet la partie du cours concernée. Une question a un id comme identifiant et a 
comme information son contenu (content), le nombre de réponses répondues correctement à la question 
(success) et le nombre de réponses répondues incorrectement à la question (failures). Ces nombres 
permettront au professeur qui se sert de la base de données à faire des statistiques. De plus, la 
question a une référence à la partie de cours qui la concerne (partie_cours_id). Les réponses à la 
question ont comme identifiant un id et ont comme information leur description (texte), un nombre 
qui représente la validité de la réponse (0 pour faux, 1 pour vrai) et une référence à la question 
associée (question_id). De plus, chaque question est classifiée par sa catégorie, qui est 
identifiée par son id et qui a comme information son nom (name) et une référence à la catégorie 
qui contient cette catégorie (category_id).


















### Conclusion.
 Nous avons implantÃ©s plusieurs fonctionnalitÃ©s que nous trouvions pertinentes pour un projet de la sorte tel que la classification de questions par parties de cours ou par catÃ©gories ainsi que des statistiques plus avancÃ©es. Bien entendu, le systÃ¨me de base de donnÃ©e est essentiel au fonctionnement d'un tel projet. Pour l'implantation logiciel du projet nous nous sommes tournÃ©s vers une application web utilisant le framework flask en python ainsi que le systÃ¨me de base de donnÃ©e SQLite que nous avons choisis pour sa lÃ©gÃ¨retÃ© et sa simplicitÃ©.


>>>>>>> 2eb45505a0926bbd0ba03b014304a75b08756718
