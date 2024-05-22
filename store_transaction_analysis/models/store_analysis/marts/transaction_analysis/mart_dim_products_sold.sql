/*
    Table:
        mart_dim_products_sold

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Dim table for getting the number of accepted transactions and its transacted amount per product (Top 10 products sold)
        
    Modification History:
        2024-05-22 - JdG - Initial commit.

*/

{{
    config(
      materialized='table'
    )
}}

WITH store_transactions_base AS (
    SELECT 
        product_name,
        COUNT(transaction_id) AS number_of_transactions, 
        SUM(amount_in_euros) AS total_transacted_amount_in_euros
    FROM {{ ref('mart_fct_store_transactions')}} 
    WHERE transaction_status = 'ACCEPTED'
    GROUP BY 
        product_name
)

SELECT * 
FROM store_transactions_base 
ORDER BY number_of_transactions DESC