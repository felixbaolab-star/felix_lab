with source_data as (
SELECT 
*
FROM `vit-lam-data.wide_world_importers.sales__orders`
)
, rename_columns as (
  select
  order_id as sales_order_key,
  customer_id as customer_key
  from source_data
)
, cast_type as (
  select
  CAST(sales_order_key AS INTEGER) AS sales_order_key,
  CAST(customer_key AS INTEGER) AS customer_key
  from rename_columns
)
select 
sales_order_key,
customer_key
from cast_type