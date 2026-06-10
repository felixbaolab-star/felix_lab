with source_data as (
select 
* 
from `vit-lam-data.wide_world_importers.sales__customer_categories`
)
, rename_columns as (
  select 
  customer_category_id as customer_category_key,
  customer_category_name
  from source_data
)
, cast_type as (
  select 
  CAST(customer_category_key AS INTEGER) AS customer_category_key,
  CAST(customer_category_name AS STRING) AS customer_category_name
  from rename_columns
)
select 
customer_category_key,
customer_category_name
from cast_type