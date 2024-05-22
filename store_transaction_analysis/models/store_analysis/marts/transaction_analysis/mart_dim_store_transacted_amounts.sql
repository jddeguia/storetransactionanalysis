/*
    Table:
        mart_dim_store_transacted_amounts

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Dim table for getting the transacted amount per store (Top 10 stores per transacted amount)
        
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
        store_id,
        store_name,
        SUM(amount_in_euros) as total_transacted_amount_in_euros
    FROM {{ ref('mart_fct_store_transactions')}} 
    WHERE transaction_status = 'ACCEPTED'
    GROUP BY 
        store_id, 
        store_name 
)

SELECT * 
FROM store_transactions_base 
ORDER BY total_transacted_amount_in_euros DESC