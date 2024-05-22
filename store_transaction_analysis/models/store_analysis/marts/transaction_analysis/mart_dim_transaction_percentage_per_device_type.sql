/*
    Table:
        mart_dim_transaction_percentage_per_device_type

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Dim table for getting the percentage of transactions per device type 
        
    Modification History:
        2024-05-22 - JdG - Initial commit.

*/

{{
    config(
      materialized='table'
    )
}}

WITH total_accepted_transactions AS (
    SELECT 
        COUNT(DISTINCT transaction_id) AS total_transactions
    FROM {{ ref('mart_fct_store_transactions')}} 
    WHERE transaction_status = 'ACCEPTED'
),

device_transaction_counts AS (
    SELECT
        device_type,
        COUNT(transaction_id) AS transaction_count
    FROM {{ ref('mart_fct_store_transactions')}} 
    GROUP BY
        device_type
),

transaction_percentage AS (
    SELECT 
        device_type,
        transaction_count,
        total_transactions,
        ROUND((transaction_count / total_transactions) * 100,2) AS transaction_percentage
    FROM 
        device_transaction_counts,
        total_accepted_transactions
)

SELECT * 
FROM transaction_percentage

