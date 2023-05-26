# 🏆 Solutions

Nous vous fournissons des axes de réponses aux différents challenges proposés en fin d'atelier. Il est **fortement conseillé d'essayer par vous-même** avant de regarder les réponses proposées ci-dessous ! Dans tous les cas, il est possible de trouver d'autres réponses concluant à des résultats similaires.

## ⁉️ Niveau 1 : Questions

Propositions de réponses aux questions, sous la forme de requêtes SQL. D'autres réponses sont possibles, d'ailleurs cela constitue un excellent entraînement aux requêtes SQL !

- [x] Combien d'appartements ont été vendus à Grenoble en 2022 ?
```sql
select
  count(*) as ventes
from
  dvf
where
  nature_mutation = 'Vente'
  and type_local = 'Appartement'
  and nom_commune = 'Grenoble'
  and strftime('%Y', date_mutation) = '2022'
```

- [x] Combien de DVF par année ont été enregistrées depuis 2018 ?
```sql
select
  strftime('%Y', date_mutation) as annee,
  count(*) as ventes
from
  dvf
group by
  annee
order by
  annee asc
```

- [x] Quelle est la tendance de ventes de maisons depuis 2018 ?
```sql
select
  strftime('%Y', date_mutation) as annee,
  count(*) as ventes
from
  dvf
where
  type_local = 'Maison'
  and nature_mutation = 'Vente'
group by
  annee
order by
  annee asc
```

- [x] Quelles sont les villes avec le plus de maisons vendues en Isère en 2022 ?
```sql
select
  nom_commune,
  count(*) as ventes
from
  dvf
where
  type_local = 'Maison'
  and strftime('%Y', date_mutation) = '2022'
group by
  nom_commune
order by
  ventes desc
```

- [x] Quel est le prix de vente moyen au mètre carré des appartements en Isère en 2022 ?
```sql
select
  cast(
    avg(valeur_fonciere / surface_reelle_bati) as int
  ) as prix_metre_carre
from
  dvf
where
  nature_mutation = 'Vente'
  and type_local = 'Appartement'
  and strftime('%Y', date_mutation) = '2022'
```

- [x] Quelles sont les 10 rues de Grenoble où le prix de vente moyen au mètre carré des appartements est le plus faible en 2021 ?
```sql
select
  adresse_nom_voie,
  cast(
    avg(valeur_fonciere / surface_reelle_bati) as int
  ) as prix_metre_carre,
  avg(latitude) as latitude,
  avg(longitude) as longitude
from
  dvf
where
  nature_mutation = 'Vente'
  and type_local = 'Appartement'
  and strftime('%Y', date_mutation) = '2021'
  and nom_commune = 'Grenoble'
group by
  adresse_nom_voie
order by
  prix_metre_carre asc
limit
  10
```

- [x] Quelles sont les 20 villes avec le plus haut prix de vente moyen au mètre carré des appartements en 2022, ayant comptabilisé au moins 10 ventes ?
```sql
select
  nom_commune,
  count(*) as ventes,
  cast(
    avg(valeur_fonciere / surface_reelle_bati) as int
  ) as prix_metre_carre
from
  dvf
where
  nature_mutation = 'Vente'
  and type_local = 'Appartement'
  and strftime('%Y', date_mutation) = '2022'
group by nom_commune
having ventes > 10
order by prix_metre_carre desc
limit 20
```

- [x] Quelles sont les 20 villes avec le plus bas prix de vente moyen au mètre carré des appartements en 2022, ayant comptabilisé au moins 10 ventes ?
```sql
select
  nom_commune,
  count(*) as ventes,
  cast(
    avg(valeur_fonciere / surface_reelle_bati) as int
  ) as prix_metre_carre
from
  dvf
where
  nature_mutation = 'Vente'
  and type_local = 'Appartement'
  and strftime('%Y', date_mutation) = '2022'
group by nom_commune
having ventes > 10
order by prix_metre_carre asc
limit 20
```

- [x] Quelle est la tendance d'évolution du prix de vente moyen au mètre carré des studios à Grenoble, Gières, Saint-Martin-d'Hères, Echirolles, Meylan et la Tronche depuis 2018 ?
```sql
select
  strftime('%Y', date_mutation) as annee,
  nom_commune,
  cast(
    avg(valeur_fonciere / surface_reelle_bati) as int
  ) as prix_metre_carre
from
  dvf
where
  nature_mutation = 'Vente'
  and type_local = 'Appartement'
  and nom_commune in (
    'Grenoble',
    'Gières',
    'Saint-Martin-d''Hères',
    'Echirolles',
    'Meylan',
    'La Tronche'
  )
  and nombre_pieces_principales = 1
group by
  annee,
  nom_commune
order by
  annee,
  nom_commune asc
```

- [x] Quelles sont les villes où aucune transaction immobilière n'a été enregistrée en 2022 ?
```sql
with dvf_2022 as (
  select
    *
  from
    dvf
  where
    strftime('%Y', dvf.date_mutation) = '2022'
)
select
  communes.nom as commune
from
  communes
  left outer join dvf_2022 on dvf_2022.code_commune = communes.code
group by
  commune
having
  count(dvf_2022.id_mutation) = 0
order by
  commune
```

## 🎨 Niveau 2 : Tableau de bord

Au préablable, installer le plugin `datasette-dashboards` :

```bash
datasette install datasette-dashboards
```

Activer le plugin et déclarer un tableau de bord dans le fichier `metadata.yml` :

```yaml
plugins:
  datasette-dashboards:
    immobilier:
      title: Tableau de bord immobilier
      description: Métriques des transactions immobilières de l'Isère
      layout: []
      filters: {}
      charts: {}
```

Ajouter les filtres demandés :

```yaml hl_lines="6-16"
plugins:
  datasette-dashboards:
    immobilier:
      ...
      filters:
        date_depart:
          name: Date de départ
          type: date
        date_fin:
          name: Date de fin
          type: date
        commune:
          name: Commune
          type: select
          db: immobilier
          query: SELECT distinct nom_commune FROM dvf ORDER BY nom_commune ASC
```

On peut désormais ajouter nos graphiques avec les conditions de filtrage (syntaxe `[[ condition ]]`, référence à la valeur du filtre par `:nom_filtre`).

"Le nombre total de transactions immobilières" :

```yaml hl_lines="6 9-18"
plugins:
  datasette-dashboards:
    immobilier:
      ...
      layout:
        - [total-transactions]
      ...
      charts:
        total-transactions:
          title: Nombre total de transactions immobilières
          db: immobilier
          query: >-
            SELECT count(*) AS transactions
            FROM dvf
            WHERE TRUE
              [[ AND date(date_mutation) >= date(:date_depart) ]]
              [[ AND date(date_mutation) <= date(:date_fin) ]]
              [[ AND nom_commune = :commune ]]
```

"Le nombre total de ventes de maisons" :

```yaml hl_lines="6 10-24"
plugins:
  datasette-dashboards:
    immobilier:
      ...
      layout:
        - [total-transactions, total-ventes-maisons]
      ...
      charts:
        ...
        total-ventes-maisons:
          title: Nombre total de ventes de maisons
          db: immobilier
          query: >-
            SELECT count(*) AS maisons
            FROM dvf
            WHERE
              nature_mutation = 'Vente'
              AND type_local = 'Maison'
              [[ AND date(date_mutation) >= date(:date_depart) ]]
              [[ AND date(date_mutation) <= date(:date_fin) ]]
              [[ AND nom_commune = :commune ]]
          library: metric
          display:
            field: maisons
```

"Le nombre total de ventes d'appartements" :

```yaml hl_lines="6 10-24"
plugins:
  datasette-dashboards:
    immobilier:
      ...
      layout:
        - [total-transactions, total-ventes-maisons, total-ventes-appartements]
      ...
      charts:
        ...
        total-ventes-appartements:
          title: Nombre total de ventes d'appartements
          db: immobilier
          query: >-
            SELECT count(*) AS appartements
            FROM dvf
            WHERE
              nature_mutation = 'Vente'
              AND type_local = 'Appartement'
              [[ AND date(date_mutation) >= date(:date_depart) ]]
              [[ AND date(date_mutation) <= date(:date_fin) ]]
              [[ AND nom_commune = :commune ]]
          library: metric
          display:
            field: appartements
```

"L'évolution du nombre de transactions mois par mois" :

```yaml  hl_lines="7 11-30"
plugins:
  datasette-dashboards:
    immobilier:
      ...
      layout:
        - [total-transactions, total-ventes-maisons, total-ventes-appartements]
        - [transactions-mois, transactions-mois, transactions-mois]
      ...
      charts:
        ...
        transactions-mois:
          title: Evolution du nombre de transactions mois par mois
          db: immobilier
          query: >-
            SELECT
              date(date_mutation, 'start of month') as month,
              count(*) as transactions
            FROM dvf
            WHERE TRUE
              [[ AND date(date_mutation) >= date(:date_depart) ]]
              [[ AND date(date_mutation) <= date(:date_fin) ]]
              [[ AND nom_commune = :commune ]]
            GROUP BY month
            ORDER BY month
          library: vega-lite
          display:
            mark: { type: line, tooltip: true }
            encoding:
              x: { field: month, type: temporal, timeUnit: yearmonth }
              y: { field: transactions, type: quantitative }
```

"Une carte choroplèthe du volume de transactions par commune" :

```yaml hl_lines="7 11-51"
plugins:
  datasette-dashboards:
    immobilier:
      ...
      layout:
        - [total-transactions, total-ventes-maisons, total-ventes-appartements]
        - [transactions-mois, transactions-mois, transactions-commune]
      ...
      charts:
        ...
        transactions-commune:
          title: Volume de transactions par commune
          db: immobilier
          query: >-
            WITH dvf_stats AS (
              SELECT code_commune, nom_commune, count(*) AS transactions
              FROM dvf
              WHERE TRUE
                [[ AND date(date_mutation) >= date(:date_depart) ]]
                [[ AND date(date_mutation) <= date(:date_fin) ]]
                [[ AND nom_commune = :commune ]]
              GROUP BY code_commune, nom_commune
              ORDER BY code_commune, nom_commune
            )
            SELECT
              communes.nom AS commune,
              coalesce(dvf_stats.transactions, 0) AS transactions
            FROM
              communes
              LEFT OUTER JOIN dvf_stats ON dvf_stats.code_commune = communes.code
          library: vega-lite
          display:
            mark: geoshape
            projection: { type: mercator }
            transform:
              - lookup: commune
                from:
                  data:
                    url: https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/departements/38-isere/communes-38-isere.geojson
                    format: { type: json, property: features }
                  key: properties.nom
                  fields: [type, geometry]
            encoding:
              fill:
                field: transactions
                type: quantitative
                scale: { scheme: blues }
              stroke: { value: white }
              tooltip:
                - { field: commune, type: nominal }
                - { field: transactions, type: quantitative }
```

## 🔮 Niveau 3 : Prédictions

Au préalable, installer le plugin `datasette-ml` :

```bash
datasette install datasette-ml
```

Avant de commencer à entraîner un modèle, il est nécessaire de préparer le jeu de données. Nous allons créer une _vue SQL_ pour :

- Filtrer les données sur les ventes d'appartements à Grenoble en 2021
- Sélectionner les caractéristiques utiles : surface réelle, nombre de pièces principales, latitude, longitude
- Sélectionner la colonne cible : valeur foncière
- Transformer les caractéristiques en valeurs réelles flottantes

Dans un terminal, ouvrir la base SQLite avec l'interpréteur en ligne de commande :

```bash
sqlite3 data/immobilier.db
```

Puis entrer la requête SQL suivante :

```sql
CREATE VIEW appartements_grenoble_2021 AS
SELECT
  CAST(surface_reelle_bati AS REAL) AS surface,
  CAST(nombre_pieces_principales AS REAL) AS pieces,
  CAST(latitude AS REAL) as latitude,
  CAST(longitude AS REAL) as longitude,
  CAST(valeur_fonciere AS REAL) AS valeur
FROM dvf
WHERE
  nature_mutation = 'Vente'
  AND type_local = 'Appartement'
  AND nom_commune = 'Grenoble'
  AND date_mutation >= '2021-01-01'
  AND date_mutation <= '2021-12-31'
  AND latitude != ''
  AND longitude != ''
;
```

Fermer l'interpréteur :

```sql
.quit
```

Configurer le plugin `datasette-ml` dans le fichier `metadata.yml`:

```yaml
plugins:
  datasette-ml:
    db: immobilier
```

Redémarrer Datasette et passons à l'entraînement d'un modèle de régression à partir de la vue créée, le tout directement via des requêtes SQL :

```sql
SELECT sqml_train(
  'Prediction appartements Grenoble',
  'regression',
  'linear_regression',
  'appartements_grenoble_2021',
  'valeur'
) AS training;
```

Nous pouvons désormais effectuer des prédictions de valeur foncière pour les appartements à Grenoble !

Par exemple, pour prédire la valeur foncière d'un T3 de 50m2 place Victor Hugo :

```sql
SELECT round(
  sqml_predict(
    'Prediction appartements Grenoble',
    json_object(
      'surface', 50,
      'pieces', 3,
      'latitude', 45.1893525,
      'longitude', 5.7216074
    )
  )
) AS prediction
```

Par exemple, pour prédire la valeur foncière d'un T4 100m2 place Victor Hugo :

```sql
SELECT round(
  sqml_predict(
    'Prediction appartements Grenoble',
    json_object(
      'surface', 100,
      'pieces', 4,
      'latitude', 45.1893525,
      'longitude', 5.7216074
    )
  )
) AS prediction
```
