/*
    Table:
        mart_fct_store_transactions

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Fact table for store transactions (mart level)
        
    Modification History:
        2024-05-22 - JdG - Initial commit.

*/

{{
    config(
      materialized='table'
    )
}}

WITH transaction_base AS (
    SELECT
        transaction_id,
        device_id,
        amount_in_euros,
        product_name,           
        transaction_created_at,
        transaction_happened_at,
        transaction_status
    FROM {{ ref('stg_fct_transactions')}} 
),

stores_with_devices_base AS (
    SELECT 
        store_id,
        store_name,
        store_typology,
        store_country,
        device_id,
        device_type
    FROM {{ ref('stg_dim_stores_with_devices')}}
),

transactions_with_store_and_product_info AS (
  SELECT
      transaction_created_at,
      transaction_happened_at,
      transaction_id,
      transaction_status,
      device_id,
      device_type,
      store_id,
      store_name,
      store_typology,
      store_country,
      product_name,
      amount_in_euros
  FROM transaction_base tb
  INNER JOIN stores_with_devices_base s USING (device_id)
)

SELECT * FROM transactions_with_store_and_product_info