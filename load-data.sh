#!/bin/bash

echo Please enter table name:
read NAME
echo "Generating table schema dump $NAME ...\n"
find -name "*.shp" -exec shp2pgsql -I -s 4140 -p {} $NAME > table_schema.sql \;

echo "Generating data dump ...\n"
find -name "*.shp" -exec shp2pgsql -s 4140 -a {} $NAME  > $NAME.sql \;

echo "Enter the database name:"
read DB

echo "Creating table in db ...\n"
psql -d $DB -f ./table_schema.sql

echo "Loading data dump ...\n"
psql -d $DB -f ./$NAME.sql
