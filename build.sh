#!/bin/bash

set -ex

# DVF_URL=https://files.data.gouv.fr/geo-dvf/latest/csv/2022/full.csv.gz
DVF_URL=https://files.data.gouv.fr/geo-dvf/latest/csv/2022/departements/38.csv.gz
DVF_GZ=dvf.csv.gz
DVF_CSV=dvf.csv

COMMUNES_URL=https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/departements/38-isere/communes-38-isere.geojson
COMMUNES_JSON=communes.geojson

DATABASE=data.db

curl -L -o "${DVF_GZ}" "${DVF_URL}"
gzip -d -f "${DVF_GZ}"

curl -L -o "${COMMUNES_JSON}" "${COMMUNES_URL}"

rm -f ${DATABASE}
sqlite3 ${DATABASE} < schema.sql
sqlite3 ${DATABASE} ".import --csv --skip 1 ${DVF_CSV} dvf"
sqlite3 ${DATABASE} <<EOF
CREATE TEMP TABLE IF NOT EXISTS communes_geojson(geojson TEXT);
.mode json
.import communes.geojson communes_geojson

INSERT INTO communes
SELECT
    value ->> '$.properties.code' AS code,
    value ->> '$.properties.nom' AS name,
    value ->> '$.type' AS feature_type,
    value ->> '$.geometry' AS feature_geometry
FROM
    (
        SELECT geojson -> '$.features' AS array
        FROM communes_geojson
    ) features,
    json_each(features.array)
;
EOF

rm -f ${DVF_CSV}
rm -rf ${COMMUNES_JSON}
