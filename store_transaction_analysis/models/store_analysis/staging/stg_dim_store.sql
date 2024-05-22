/*
    Table:
        stg_dim_store_v1

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Dimension table for store (staging level)

    Note:
        * Casting each columns to their appropriate data types explicitly

    Modification History:
        2024-05-22 - JdG - Initial commit.
*/


{{
    config(
      materialized='table'
    )
}}

WITH store AS (
    SELECT
        CAST(id AS STRING) AS store_id,
        CAST(name AS STRING) AS store_name,
        CAST(address AS STRING) AS store_address,
        CAST(REGEXP_REPLACE(city, '[^a-zA-Z0-9 ]', '') AS STRING) AS store_city,
        CAST(country AS STRING) AS store_country,
        CAST(created_at AS TIMESTAMP) AS store_created_at,
        CAST(UPPER(typology) AS STRING) AS store_typology,
        CAST(customer_id AS STRING) AS customer_id,
    FROM {{ source('store-transaction-analysis', 'store_source')}}
)

SELECT * FROM store