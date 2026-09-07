# *# RetailSphere - Retail Sales Data Warehouse and ETL Pipeline*

# 

##### **## Project Overview**



RetailSphere is an end-to-end Retail Sales Data Warehouse and ETL Project developed to demonstrate practical experience with Oracle SQL

Informatica PowerCenter, Unix Shell Scripting, Data Warehousing concepts, data validation, and SQL reporting.

The project uses retail sales data containing customer, product, order, and item-level information.

The data is extracted from source tables, transformed and validated using Informatica, and loaded into dimensional and fact tables in an Oracle data warehouse







##### **## Business Objective**



The main objective of this project is build a structured retail data warehouse can help analyse:



Customer Sales

Product Performance

Regional Sales

Category-wise Profit

Monthy Sales Trends

Customer Order Activity

Top Performing Products



The project also demonstrates how new and changed customer data can be handled using Slowly Changing Dimensions(SCD)



##### **## Technologies Used**

##### 

Oracle Database - Source and Target Database

Sql Developer - Table Creation, Validation, and Reporting

Informatica Powercenter - ETL Development

Unix Shell Scripting - File Validation and Processing

GitHub - Project Version Control and Documentation

Microsoft Excel(CSV) - Source retail database





##### **## Source Data**



The project uses a Superstore retail sales dataset

The Source data contains information related to

Customers

Products

Orders

Items





The source tables used in this project are :
**Source Table 			Description**

Customers			Customer Information

Products			Product Information

Orders				Order level Information

Items 				Item level Information





##### **## Data Warehouse Design**

The warehouse contains dimension and fact tables



###### **### Dimension Table**



**#### DIM\_CUSTOMERS** : Stores Customer Information

Important columns :

* CUST\_KEY
* CUSTOMER\_ID
* CUSTOMER\_NAME
* SEGMENT
* REGION
* COUNTRY
* STATE
* POSTAL CODE

"CUST\_KEY" is a surrogate key used as the primary key.



**#### DIM\_PRODUCTS** : Stores Product Information

Important Columns :

* PROD\_KEY
* PRODUCT\_ID
* PRODUCT\_NAME
* CATEGORY
* SUB\_CATEGORY

"PROD\_KEY"  is a surrogate key used as the primary key.



###### **### Fact Table**



**#### FACT\_ORDERS** : Stores Order Related Information

Columns :

* ORDER\_ID
* ORDER\_DATE
* SHIP\_DATE
* SHIP\_MODE
* CUSTOMER\_ID





**#### FACT\_ITEMS** : Stores Item-level Sales Transactions

Columns :

* ORDER\_ID
* PRODUCT\_ID
* SALES
* QUANTITY
* DISCOUNT
* PROFIT

##### 

##### **## ETL Architecture**

The overall ETL process is :



Source Data

|

Unix File Validation

|

Staging

|

Informatica Powercenter

|

Oracle Data Warehouse

|

SQL Reporting





##### **## Customer SCD Type 1**

Customer data is processed using Slowly Changing Dimension Type 1



###### **### Logic**

* If Customer data already exists -> Update
* If Customer is new -> Insert

Type 1 does not maintain historical values



###### **### Informatica Objects**

Mapping : 	m\_LOAD\_CUSTOMERS\_SCD\_TYPE1

Session : 	s\_LOAD\_CUSTOMERS\_SCD\_TYPE1

##### 

##### **## Customer SCD Type 2**

Customer data is also processed using Slowly Changing Dimension Type 2 to maintain historical information



###### **### Logic**

When an existing customer's the tracked information changes : then

* Existing Record is retained as historical data
* The old version is ended
* A new version of the customer record is inserted

This allows the warehouse to preserve customer history



###### **### Informatica Objects**

Mapping : 	m\_LOAD\_CUSTOMERS\_SCD\_TYPE2

Session : 	s\_LOAD\_CUSTOMERS\_SCD\_TYPE2







##### **## PRODUCT LOADING**

Products are loaded using a Lookup transformation



###### **### Logic :**

PRODUCTS

|

Lookup DIM\_PRODUCTS using PRODUCT\_ID

|

* Existing Product -> Update
* New Product -> Insert



###### **### Informatica Objects**

Mapping : 	m\_LOAD\_PRODUCTS

Session : 	s\_LOAD\_PRODUCTS



Duplicate product records present in the source were handled so that the warehouse maintains unique product records..





##### **## FULL\_LOAD - FACT\_ORDERS**

The order fact table is loaded using a full-load mapping



###### **### Flow**

Orders

|

Source Qualifier

|

Fact Orders



###### **### Informatica Objects**

Mapping : 	m\_LOAD\_FACT\_ORDERS

Session : 	s\_LOAD\_FACT\_ORDERS

The target contains order-level records



##### 

##### **## FULL\_LOAD - FACT\_ITEMS**

The item fact table is loaded using a full-load mapping



###### **### Flow**

Items

|

Source Qualifier

|
Fact Items



###### **### Informatica Objects**

Mapping : 	m\_LOAD\_FACT\_ITEMS

Session : 	s\_LOAD\_FACT\_ITEMS

The target maintains item-level transaction information



##### **## Incremental Load - Fact Orders**

An Incremental mapping was created to load only new orders.



###### **### Flow**

Orders

|

Source Qualifiers

|

Lookup Fact\_Orders

|

Filter

|

Fact\_Orders



The Lookup checks whether the order already exists

* Existing Order -> Rejected
* New Order -> Inserted



###### **### Informatica Object**

Mapping : 	m\_INCREMENTAL\_LOAD\_ORDERS ........

A test order was successfully inserted using the incremental process

the Fact\_Order count increase from  : 5009->5010

This demonstrated that the incremental process inserted the new order without reloading existing order



##### **## Incremental Load - Fact\_Items**

An Incremental mapping was also created for item-level data



###### **### Flow**

Items

|

Source Qualifier

|

Lookup Fact\_Items

|

Filter

|

Fact\_Items



The mapping checks whether the incoming record already exists in the target before inserting it

##### 

##### **## ETL Workflow**

###### **### Full Load Workflow**



Workflow : WFL\_RETAIL\_SALES\_ETL\_FLOW



Sequence :

START

|

LOAD CUSTOMER TYPE 1

|

LOAD CUSTOMER TYPE 2

|

LOAD PRODUCTS

|

LOAD FACT ORDERS

|

LOAD FACT ITEMS



###### 

###### **### INCREMENTAL WORKFLOW**

###### 

Workflow : WFL\_RETAIL\_SALES\_ETL\_INCREMENTAL\_FLOW

The workflow handles incremental fact loading separately from the full-load process

##### 

##### **## UNIX SHELL SCRIPTING**

Unix Shell Scripting is used as a simple pre-processing step in the ETL process



The scripts demonstrate:

* File existence Checking
* File Copying
* Basic File Validation
* Record Counting
* ETL Process Execution



###### **###Scripts**

validate.sh

process.sh

ETL.sh



##### 

##### **## Data Validation**

* Compared source and target data counts
* Checked important columns for NULL values
* Verified customer and product referential integrity
* Checked for duplicate records
* Reconciled SALES, QUANTITY, and PROFIT totals between source and target.









