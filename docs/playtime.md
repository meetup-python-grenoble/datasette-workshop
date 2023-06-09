# 🎲 À vous de jouer !

Maintenant que vous savez utiliser Datasette et son écosystème, nous vous proposons de mettre en pratique vos nouvelles connaissances ! Les différentes parties sont indépendantes mais sont classées par niveau de compétences requises.

## ⁉️ Niveau 1 : Questions

Avec la méthode de votre choix (interface web et/ou requêtes SQL), tentez de répondre aux questions suivantes :

- [ ] Combien d'appartements ont été vendus à Grenoble en 2022 ?
- [ ] Combien de DVF par année ont été enregistrées depuis 2018 ?
- [ ] Quelle est la tendance de ventes de maisons depuis 2018 ?
- [ ] Quelles sont les villes avec le plus de maisons vendues en Isère en 2022 ?
- [ ] Quel est le prix de vente moyen au mètre carré des appartements en Isère en 2022 ?
- [ ] Quelles sont les 10 rues de Grenoble où le prix de vente moyen au mètre carré des appartements est le plus faible en 2021 ?
- [ ] Quelles sont les 20 villes avec le plus haut prix de vente moyen au mètre carré des appartements en 2022, ayant comptabilisé au moins 10 ventes ?
- [ ] Quelles sont les 20 villes avec le plus bas prix de vente moyen au mètre carré des appartements en 2022, ayant comptabilisé au moins 10 ventes ?
- [ ] Quelle est la tendance d'évolution du prix de vente moyen au mètre carré des studios à Grenoble, Gières, Saint-Martin-d'Hères, Echirolles, Meylan et la Tronche depuis 2018 ?
- [ ] Quelles sont les villes où aucune transaction immobilière n'a été enregistrée en 2022 ?

## 🎨 Niveau 2 : Tableau de bord

À l'aide du plugin [`datasette-dashboards`](https://datasette.io/plugins/datasette-dashboards), créer un tableau de bord des transactions immobilières permettant de visualiser :

- Le nombre total de transactions immobilières
- Le nombre total de ventes de maisons
- Le nombre total de ventes d'appartements
- L'évolution du nombre de transactions mois par mois
- Une carte choroplèthe du volume de transactions par commune

Idéalement, votre tableau de bord doit être filtrable sur les critères suivants :

- Nom de la commune
- Date de début
- Date de fin

## 🔮 Niveau 3 : Prédictions

À l'aide du plugin [`datasette-ml`](https://github.com/rclement/datasette-ml), créer un modèle d'apprentissage machine permettant de prédire le prix de vente d'un appartement à Grenoble !

**Conseil** : pour être sûr d'utiliser uniquement les données désirées (lignes, colonnes), créer une vue SQL à partir des données DVF et utiliser cette vue comme argument de la fonction d'entrainement !

## 🕵️ Niveau 4 : investigation

**Datasette** a été créé en partie pour effectuer du **journaliste d’investigation**. A vous de vous mettre dans la peau d’un ou d’une journaliste d’investigation. Voici votre mission :

Une **transaction immobilière** très importante a été effectuée en **2019**. Il s’agit de **la plus importante transaction** en Isère des 5 dernières années. Mais qui se cache derrière cette transaction ? **A vous de le découvrir**. Comme vous n’avez pas des mois de recherche devant vous, nous allons vous guider un peu.

Tout d’abord, trouver le **montant de la transaction** la plus importante. **Regrouper** toutes les transactions de ce montant. **Localiser** l’emplacement des lots vendus.

*Selon vous et vos recherches sur internet, lequel de ces scénarios est le plus probable ?*

1. ☢️ La transaction est en lien avec l’entreprise EDF. En effet, les terrains se situent non loin de l’ancienne centrale nucléaire de Creys-Malville (Superphénix). Pour pouvoir finaliser le démantèlement complet de la centrale, EDF a besoin de nouveaux terrains.

2. 🏀 La transaction est en lien avec Tony Parker. En effet, les terrains se situent à Villard-de-Lans où Tony Parker cherche à créer un grand complexe hôtelier pour développer l’activité touristique.

3. ⚡ La transaction est en lien avec l’entreprise Cap Energy. En effet, les terrains se situent non loin de l’entreprise Jambon Aoste et vont en partie être utilisés pour implanter une usine de méthanisation des déchets de l’usine de jambons.

4. 🎢 La transaction est en lien avec l’entreprise Compagnie des Alpes. En effet, le parc Walibi Rhône-Alpes a besoin de nouveaux terrains pour créer le nouveau circuit de montagnes russes Mystic.

??? tip "Solutions"
    Nous vous conseillons d'essayer ces exercices par vous-même, en consultant les documentations de l'écosystème Datasette et SQLite au besoin.
    Si vous souhaitez néanmoins avoir des axes de réponses, nous vous en fournissons dans la page [🏆 Solutions](./playtime_solutions.md) 😉
