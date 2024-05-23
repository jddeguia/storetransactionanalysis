# Store Transaction Analysis using DBT

This is a repository for answering the following questions using data transformation done in SQL and dbt 

The following questions are:
- Top 10 stores per transacted amount
- Top 10 products sold
- Average transacted amount per store typology and country
- Percentage of transactions per device type
- Average time for a store to perform its 5 first transactions

The following questions are answered by creating mart models specific for each of this questions

## Methodology

![image](https://github.com/jddeguia/storetransactionanalysis/assets/70092528/692b56e5-ebd1-41ad-b2fa-3edd270a0cb7)

- The CSV files are uploaded to the data warehouse. In this case, we used BigQuery
- Once the CSV files are connected, we connect dbt-core to BigQuery by generating a Service Account JSON file. This will be later used for setting up the dbt environment
- The uploaded CSV files will be treated as source tables. We will use this source tables to create models for staging and mart level models

## DAG

![dbt dag](https://github.com/jddeguia/storetransactionanalysis/assets/70092528/1b8cc358-2979-4108-a2ae-10e251f8f235)

Our philosophy in creating models are
- The uploaded CSV files are our source tables
- We create staging models to clean the data in each source tables. There are unwanted special characters on some of the columns and we wish to clean them. Also, there are also values which we think is better to set them all to uppercase
- We then create mart models which is specifically used to answer our questions

Methodololgy
- create source models (which is from the file upload)
- create staging model from the source model. This is where we clean the source model
- create 1 big mart model `mart_fct_store_transactions`. This mart model contains all the column that we need to answer the following questions
- create mart models from `mart_fct_store_transactions`

The following mart models we're used to answer the following questions
> Top 10 stores per transacted amount

This is answered by `mart_dim_store_transacted_amounts`

> Top 10 products sold

This is answered by `mart_dim_products_sold`

> Average transacted amount per store typology and country

This is answered by `mart_dim_average_transacted_amount_store_typology` and `mart_dim_average_transacted_amount_store_country`

> Percentage of transactions per device type

This is answered by `mart_dim_transaction_percentage_per_device_type`

> Average time for a store to perform its 5 first transactions

This is answered by `mart_dim_average_transaction_time_performance`

Go to `store_transaction_analysis` folder to see the results from these marts. The results are on the README file
Here is the link for the results
`https://github.com/jddeguia/storetransactionanalysis/edit/main/store_transaction_analysis/README.md`
