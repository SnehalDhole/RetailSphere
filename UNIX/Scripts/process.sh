#!/bin/bash

echo "ETL Process Started"

cp ../data/superstore.csv ../staging/

echo "File copied to staging"

wc -l ../staging/superstore.csv

echo "ETL process completed"

