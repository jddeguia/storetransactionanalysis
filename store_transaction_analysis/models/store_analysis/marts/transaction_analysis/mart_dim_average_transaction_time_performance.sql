/*
    Table:
        mart_dim_average_transaction_time_performance

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Dim table for getting the average time for a store to perform its 5 first transactions 
        
    Modification History:
        2024-05-22 - JdG - Initial commit.

*/

{{
    config(
      materialized='table'
    )
}}

WITH calculate_time_difference AS (
    SELECT
        store_id,
        store_name,
        TIMESTAMP_DIFF(transaction_created_at, transaction_happened_at, MINUTE) AS time_diff_minutes,
        ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY transaction_created_at) AS rn
    FROM {{ ref('mart_fct_store_transactions')}}
),

first_five_transactions AS (
    SELECT
        store_id,
        store_name,
        time_diff_minutes
    FROM calculate_time_difference
    WHERE rn <= 5
),

summary AS (
    SELECT
        store_id,
        store_name,
        ROUND(AVG(time_diff_minutes), 2) AS average_time_minutes,
        ROUND(AVG(time_diff_minutes/60), 2) AS average_time_hours,
        ROUND(AVG(time_diff_minutes/1440), 2) AS average_time_days
    FROM first_five_transactions
    GROUP BY
        store_id,
        store_name
)

SELECT * FROM summary
