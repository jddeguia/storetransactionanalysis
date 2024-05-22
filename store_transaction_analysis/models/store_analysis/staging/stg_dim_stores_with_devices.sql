/*
    Table:
        stg_dim_stores_with_devices_v1

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Dimension table for store with device info (staging level)
        This was made in order to join it with transactions table

    Modification History:
        2024-05-22 - JdG - Initial commit.
*/

WITH store_base AS (
  SELECT
    store_id,
    store_name,
    store_typology,
    store_country  
  FROM {{ ref('stg_dim_store')}}  
),

device_base AS (
  SELECT 
    store_id,
    device_id,
    device_type
FROM {{ ref('stg_dim_devices')}}
),

merged_table AS (
  SELECT
    store_base.store_id,
    store_name,
    store_typology,
    store_country,
    device_id,
    device_type
  FROM store_base
  INNER JOIN device_base USING (store_id)
)

SELECT * FROM merged_table