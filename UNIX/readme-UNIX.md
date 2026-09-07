# RETAIL SALES ETL PROJECT

#PROJECT OVERVIEW:

This project demonstrates a simple ETL process using Unix/Linux Shell Scripting

This project takes a retail sales CSV file, Validates it, Process it, and Copies the processed file to a staging folder

#ETL FLOW

Source CSV file
|
validate.sh
|
process.sh
|
staging

#PROJECT STRUCTURE

retail_sales_etl/

- data/			- contains source CSV file
- staging/		- contains the processed file
- scripts/		- contains Shell scripts
- logs/			- contains execution logs
- README.md		- Project Documentation


#SHELL SCRIPTS
#validate.sh

Checks:
- whether the source file exists
- Whether the file contains data
- whether the header exists
- whether the data row exists


#process.sh

- copies the source CSV to the staging folder
- counts the rows in the processed file


#etl.sh

- runs the validation and processing scripts in sequence


# How to run

Go to scripts directory :

cd ~/retail_sales_etl/scripts

Run the complete ETL pipeline :

./etl.sh


#Technologies Used

- Unix/Linux
- Bash shell scripting
- csv
