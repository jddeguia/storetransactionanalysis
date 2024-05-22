/*
    Table:
        stg_dim_devices_v1

    Authors:
        Justin de Guia (JdG)
        
    Description & Comments:
        Dimension table for devices (staging level)

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

WITH devices AS (
    SELECT
        CAST(store_id AS STRING) AS store_id,
        CAST(id AS STRING) AS device_id,
        CAST(type AS STRING) AS device_type,
    FROM {{ source('store-transaction-analysis', 'device_source')}}
)

SELECT * FROM devices