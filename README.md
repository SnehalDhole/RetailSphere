# RetailSphere - Retail Sales Data Warehouse and ETL Pipeline

## Project Overview

RetailSphere is an end-to-end Retail Sales Data Warehouse and ETL Project developed to demonstrate practical experience with Oracle SQL, Informatica PowerCenter, Unix Shell Scripting, Data Warehousing concepts, data validation, and SQL reporting.

The project uses retail sales data containing customer, product, order, and item-level information.

The data is extracted from source tables, transformed and validated using Informatica, and loaded into dimensional and fact tables in an Oracle data warehouse.

## Business Objective

The main objective of this project is to build a structured retail data warehouse that can help analyze:

- Customer Sales
- Product Performance
- Regional Sales
- Category-wise Profit
- Monthly Sales Trends
- Customer Order Activity
- Top Performing Products

The project also demonstrates how new and changed customer data can be handled using Slowly Changing Dimensions (SCD).

## Technologies Used

- Oracle Database - Source and Target Database
- SQL Developer - Table Creation, Validation, and Reporting
- Informatica PowerCenter - ETL Development
- Unix Shell Scripting - File Validation and Processing
- GitHub - Project Version Control and Documentation
- Microsoft Excel (CSV) - Source retail database

## Source Data

The project uses a Superstore retail sales dataset.

The source data contains information related to:

- Customers
- Products
- Orders
- Items

The source tables used in this project are:

| Source Table | Description |
|---|---|
| Customers | Customer information |
| Products | Product information |
| Orders | Order-level information |
| Items | Item-level information |

## Data Warehouse Design

The warehouse contains dimension and fact tables.

### Dimension Tables

#### DIM_CUSTOMERS

Stores customer information.

Important columns:

- CUST_KEY
- CUSTOMER_ID
- CUSTOMER_NAME
- SEGMENT
- REGION
- COUNTRY
- STATE
- POSTAL CODE

`CUST_KEY` is a surrogate key used as the primary key.

#### DIM_PRODUCTS

Stores product information.

Important columns:

- PROD_KEY
- PRODUCT_ID
- PRODUCT_NAME
- CATEGORY
- SUB_CATEGORY

`PROD_KEY` is a surrogate key used as the primary key.

### Fact Tables

#### FACT_ORDERS

Stores order-related information.

Columns:

- ORDER_ID
- ORDER_DATE
- SHIP_DATE
- SHIP_MODE
- CUSTOMER_ID

#### FACT_ITEMS

Stores item-level sales transactions.

Columns:

- ORDER_ID
- PRODUCT_ID
- SALES
- QUANTITY
- DISCOUNT
- PROFIT

## ETL Architecture

The overall ETL process is:

Source Data

↓

Unix File Validation

↓

Staging

↓

Informatica PowerCenter

↓

Oracle Data Warehouse

↓

SQL Reporting

## Customer SCD Type 1

Customer data is processed using Slowly Changing Dimension Type 1.

### Logic

- If customer data already exists → Update
- If customer is new → Insert

Type 1 does not maintain historical values.

### Informatica Objects

Mapping: `m_LOAD_CUSTOMERS_SCD_TYPE1`

Session: `s_LOAD_CUSTOMERS_SCD_TYPE1`

## Customer SCD Type 2

Customer data is also processed using Slowly Changing Dimension Type 2 to maintain historical information.

### Logic

When the tracked information of an existing customer changes:

- Existing record is retained as historical data
- The old version is ended
- A new version of the customer record is inserted

This allows the warehouse to preserve customer history.

### Informatica Objects

Mapping: `m_LOAD_CUSTOMERS_SCD_TYPE2`

Session: `s_LOAD_CUSTOMERS_SCD_TYPE2`

## Product Loading

Products are loaded using a Lookup transformation.

### Logic

PRODUCTS

↓

Lookup DIM_PRODUCTS using PRODUCT_ID

↓

- Existing Product → Update
- New Product → Insert

### Informatica Objects

Mapping: `m_LOAD_PRODUCTS`

Session: `s_LOAD_PRODUCTS`

Duplicate product records present in the source were handled so that the warehouse maintains unique product records.

## FULL_LOAD - FACT_ORDERS

The order fact table is loaded using a full-load mapping.

### Flow

Orders

↓

Source Qualifier

↓

Fact Orders

### Informatica Objects

Mapping: `m_LOAD_FACT_ORDERS`

Session: `s_LOAD_FACT_ORDERS`

The target contains order-level records.

## FULL_LOAD - FACT_ITEMS

The item fact table is loaded using a full-load mapping.

### Flow

Items

↓

Source Qualifier

↓

Fact Items

### Informatica Objects

Mapping: `m_LOAD_FACT_ITEMS`

Session: `s_LOAD_FACT_ITEMS`

The target maintains item-level transaction information.

## Incremental Load - Fact Orders

An incremental mapping was created to load only new orders.

### Flow

Orders

↓

Source Qualifier

↓

Lookup Fact_Orders

↓

Filter

↓

Fact_Orders

The Lookup checks whether the order already exists.

- Existing Order → Rejected
- New Order → Inserted

### Informatica Object

Mapping: `m_INCREMENTAL_LOAD_ORDERS`

A test order was successfully inserted using the incremental process.

The Fact_Order count increased from 5,009 to 5,010.

This demonstrated that the incremental process inserted the new order without reloading existing orders.

## Incremental Load - Fact Items

An incremental mapping was also created for item-level data.

### Flow

Items

↓

Source Qualifier

↓

Lookup Fact_Items

↓

Filter

↓

Fact_Items

The mapping checks whether the incoming record already exists in the target before inserting it.

## ETL Workflow

### Full Load Workflow

Workflow: `WFL_RETAIL_SALES_ETL_FLOW`

Sequence:

START

↓

LOAD CUSTOMER TYPE 1

↓

LOAD CUSTOMER TYPE 2

↓

LOAD PRODUCTS

↓

LOAD FACT ORDERS

↓

LOAD FACT ITEMS

### Incremental Workflow

Workflow: `WFL_RETAIL_SALES_ETL_INCREMENTAL_FLOW`

The workflow handles incremental fact loading separately from the full-load process.

## UNIX SHELL SCRIPTING

Unix Shell Scripting is used as a simple pre-processing step in the ETL process.

The scripts demonstrate:

- File existence checking
- File copying
- Basic file validation
- Record counting
- ETL process execution

### Scripts

- `validate.sh`
- `process.sh`
- `ETL.sh`

## Data Validation

- Compared source and target data counts
- Checked important columns for NULL values
- Verified customer and product referential integrity
- Checked for duplicate records
- Reconciled SALES, QUANTITY, and PROFIT totals between source and target
