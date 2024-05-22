/*
    Table:
        mart_dim_average_transacted_amount_store_typology

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Dim table for getting the average of transacted amount per store typology 
        
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
        store_typology,
        ROUND(AVG(amount_in_euros),2) AS average_transacted_amount_in_euros
    FROM {{ ref('mart_fct_store_transactions')}} 
    WHERE transaction_status = 'ACCEPTED'
    GROUP BY 
        store_typology
    
)

SELECT * 
FROM store_transactions_base
ORDER BY average_transacted_amount_in_euros DESC