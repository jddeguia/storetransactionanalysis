/*
    Table:
        stg_dim_transactions_v1

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Fact table for store's transaction (staging level)

    Note:
        * Removing whitespaces and other special characters on columns
        * Casting each columns to their appropriate data types explicitly

    Modification History:
        2024-05-22 - JdG - Initial commit.
*/


{{
    config(
      materialized='table'
    )
}}

WITH transaction AS (
    SELECT
        CAST(id AS STRING) AS transaction_id,
        CAST(device_id AS STRING) AS device_id,
        UPPER(REGEXP_REPLACE(product_name, '[^a-zA-Z0-9]', '')) AS product_name,
        UPPER(REGEXP_REPLACE(product_name_4, '[^a-zA-Z0-9]', '')) AS product_name_4,
        CASE 
            WHEN REGEXP_CONTAINS(product_sku, r'[eE]') THEN CAST(FORMAT("%.0f", CAST(product_sku AS FLOAT64)) AS STRING)  
            ELSE CAST(product_sku AS STRING)
        END AS product_sku,
        CAST(amount AS INT64) AS amount_in_euros,
        CAST(UPPER(status) AS STRING) AS transaction_status,
        CASE 
            WHEN REGEXP_CONTAINS(card_number, r'[eE]') THEN CAST(FORMAT("%.0f", CAST(card_number AS FLOAT64)) AS STRING)  
            ELSE CAST(card_number AS STRING)
        END AS card_number,
        CAST(cvv AS STRING) AS cvv,
        CAST(created_at AS TIMESTAMP) AS transaction_created_at,
        CAST(happened_at AS TIMESTAMP) AS transaction_happened_at,
    FROM {{ source('store-transaction-analysis', 'transaction_source')}}
),

clean_columns_more AS (
    SELECT 
        * EXCEPT (product_sku, card_number, product_name, product_name_4),
        REGEXP_REPLACE(REGEXP_REPLACE(product_sku, r'^\s+', ''), r'^v', '') AS product_sku,
        REPLACE(card_number, ' ', '') AS card_number,
        CONCAT(product_name, " ", product_name_4) AS product_name,
    FROM transaction
)

SELECT * FROM clean_columns_more