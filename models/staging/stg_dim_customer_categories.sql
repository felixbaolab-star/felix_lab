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
, union_undefined_record AS (
  SELECT 
    customer_category_key,
    customer_category_name
  FROM cast_type
  UNION ALL
  SELECT 
  0 AS customer_category_key,
  'Undefined' AS customer_category_name
  UNION ALL
  SELECT
  -1 AS customer_category_key,
  'Invalid' AS customer_category_name
)
select 
customer_category_key,
customer_category_name
from union_undefined_record