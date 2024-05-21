{{
    config(
      materialized='table'
    )
}}

WITH devices AS (
    SELECT * EXCEPT(id, type),
        id AS device_id,
        type AS device_type,
    FROM {{ source('store-transaction-analysis', 'device_source')}}
)

SELECT * FROM devices