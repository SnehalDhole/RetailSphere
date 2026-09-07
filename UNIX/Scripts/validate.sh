#!/bin/bash
LOG_FILE="$HOME/retail_sales_etl/logs/validate.log"

echo "ETL Started" | tee -a "$LOG_FILE"
echo "Checking Source File..." | tee -a "$LOG_FILE"

if [ -f "$HOME/retail_sales_etl/data/superstore.csv" ]
then
    echo "File Exists" | tee -a "$LOG_FILE"
else
    echo "File does not Exist" | tee -a "$LOG_FILE"
    exit 1
fi





if [ -s "$HOME/retail_sales_etl/data/superstore.csv" ]
then
	echo "File Exists" | tee -a "$LOG_FILE"
else
	echo "File does not Exists" | tee -a "$LOG_FILE"
	exit 1
fi





echo "Checking Header..." | tee -a "$LOG_FILE"

HEADER=$(head -1 "$HOME/retail_sales_etl/data/superstore.csv")

if [ -n "$HEADER" ]
then
	echo "Header Exists" | tee -a "$LOG_FILE"
else
	echo "Header is Missing" | tee -a "$LOG_FILE"
	exit 1
fi


echo "Checking Data Rows..." | tee -a "$LOG_FILE"
ROW_COUNT=$(tail -n +2 "$HOME/retail_sales_etl/data/superstore.csv" | wc -l)

if [ "$ROW_COUNT" -gt 0 ]
then 
	echo "Data rows found : $ROW_COUNT" | tee -a "$LOG_FILE"
else
	echo "No data rows found" | tee -a "$LOG_FILE"
	exit 1
fi


echo "Validation Completed" | tee -a "$LOG_FILE"
