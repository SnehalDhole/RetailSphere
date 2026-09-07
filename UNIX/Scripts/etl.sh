#!/bin/bash

echo "ETL Pipeline Started"
./validate.sh
echo "Validation Completed"

./process.sh
echo "Processing Completed"

echo "ETL Pipeline Completed"
