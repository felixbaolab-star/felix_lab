with source_data as (
SELECT 
*
FROM `vit-lam-data.wide_world_importers.sales__orders`
)
, rename_columns as (
  select
  order_id as sales_order_key,
  order_date,
  customer_id as customer_key,
  picked_by_person_id as picked_by_person_key
  from source_data
)
, cast_type as (
  select
  CAST(order_date AS DATE) AS order_date,
  CAST(sales_order_key AS INTEGER) AS sales_order_key,
  CAST(customer_key AS INTEGER) AS customer_key,
  CAST(picked_by_person_key AS INTEGER) AS picked_by_person_key
  from rename_columns
)
select 
sales_order_key,
order_date,
customer_key,
COALESCE(picked_by_person_key, 0) AS picked_by_person_key
from cast_type