# À vous de jouer !

Maintenant que vous savez utiliser Datasette et son écosystème, nous vous proposons de mettre en pratique vos nouvelles connaissances ! Les différentes parties sont indépendantes mais sont classées par niveau de compétences requises.

## Niveau 1 : Questions

Avec la méthode de votre choix (interface web et/ou requêtes SQL), tentez de répondre aux questions suivantes :

- [ ] Combien d'appartement ont été vendues à Grenoble en 2022 ?
- [ ] Quelles sont les villes avec le plus de maisons vendues en Isère en 2022 ?
- [ ] Quel est le prix moyen au mètre carré en Isère en 2022 ?
- [ ] Quel est le prix moyen au mètre carré à Montbonnot Saint-Martin en 2022 ?
- [ ] Quelles sont les 5 villes où le plus de transactions immobilières ont été entrées en 2022 ?
- [ ] Quelles sont les villes où aucune transaction immobilière n'a été enregistrée en 2022 ?

## Niveau 2 : Tableau de bord

À l'aide du plugin `datasette-dashboards`, créer un tableau de bord des transactions immobilières permettant de visualiser :

- Le nombre total de transactions immobilières
- Le nombre total de ventes de maisons
- Le nombre total de ventes d'appartements
- L'évolution du nombre de transactions mois par mois
- Une carte choroplèthe du volume de transactions par commune

Idéalement, votre tableau de bord doit être filtrable sur les critères suivants :

- Nom de la commune
- Date de début
- Date de fin

## Niveau 3 : Prédictions

À l'aide du plugin `datasette-ml`, créer un modèle d'apprentissage machine permettant de prédire le prix de vente d'un appartement à Grenoble !
