#!/bin/bash

set -e

DATA="${PWD}/.datasets"
DATABASE=data/immobilier.db

CURRENT_YEAR=$(date +"%Y")
START_YEAR=$((${CURRENT_YEAR}-5))
END_YEAR=$((${CURRENT_YEAR}-1))
YEARS=($(seq ${START_YEAR} ${END_YEAR}))

setup() {
    echo "setup database"

    rm -f ${DATABASE}
    sqlite3 ${DATABASE} < schema.sql

    rm -rf ${DATA}
    mkdir -p ${DATA}
}

load_dvf() {
    echo "load dvf dataset"

    DVF_BASE_URL=https://files.data.gouv.fr/geo-dvf/latest/csv

    for YEAR in ${YEARS[@]}
    do
        url="${DVF_BASE_URL}/${YEAR}/departements/38.csv.gz"
        gz_file="${DATA}/dvf_${YEAR}.csv.gz"
        csv_file="${DATA}/dvf_${YEAR}.csv"

        curl -L -o "${gz_file}" "${url}"
        gzip -d -f "${gz_file}"
        sqlite3 ${DATABASE} ".import --csv --skip 1 ${csv_file} dvf"
    done
}

load_communes_geojson() {
    echo "load communes geojson dataset"

    COMMUNES_URL=https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/departements/38-isere/communes-38-isere.geojson
    COMMUNES_JSON="${DATA}/communes.geojson"

    curl -L -o "${COMMUNES_JSON}" "${COMMUNES_URL}"
    sqlite3 ${DATABASE} <<EOF
CREATE TEMP TABLE IF NOT EXISTS communes_geojson(geojson TEXT);
.mode json
.import ${COMMUNES_JSON} communes_geojson

INSERT INTO communes(code, nom, feature_type, feature_geometry)
SELECT
    value ->> '$.properties.code',
    value ->> '$.properties.nom',
    value ->> '$.type',
    value ->> '$.geometry'
FROM
    (
        SELECT geojson -> '$.features' AS array
        FROM communes_geojson
    ) features,
    json_each(features.array)
;
EOF
}

assert_loaded_lines() {
    echo "assert loaded lines"

    TOTAL_CSV_LINES=$(cat ${DATA}/dvf_*.csv | wc -l)
    EXPECTED_LINES=$((${TOTAL_CSV_LINES} - ${#YEARS[@]}))
    DATABASE_LINES=$(sqlite3 ${DATABASE} "select count(*) from dvf;")
    ASSERT_LINES="${DATABASE_LINES} -eq ${EXPECTED_LINES}"

    if [ ! ${ASSERT_LINES} ]
    then
        echo "number of loaded lines in database different from csv data"
        echo "csv lines: ${EXPECTED_LINES}"
        echo "database lines: ${DATABASE_LINES}"
        exit 1
    fi
}

cleanup() {
    rm -rf ${DATA}
}

setup
load_dvf
load_communes_geojson
assert_loaded_lines
cleanup
