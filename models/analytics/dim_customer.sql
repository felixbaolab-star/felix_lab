with source_data as (
  select * 
  from `vit-lam-data.wide_world_importers.sales__customers`
)
, rename_columns as (
  SELECT 
  customer_id AS customer_key,
  customer_name
  FROM source_data
)
, cast_type as (
  SELECT 
  CAST(customer_key AS INTEGER) AS customer_key,
  CAST(customer_name AS STRING) AS customer_name
  FROM rename_columns
)
select 
customer_key,
customer_name
from cast_type
