with source_data as (
  select * 
  from `vit-lam-data.wide_world_importers.sales__customers`
)
, rename_columns as (
  SELECT 
  customer_id AS customer_key,
  customer_name,
  customer_category_id as customer_category_key,
  buying_group_id as buying_group_key,
  is_on_credit_hold
  FROM source_data
)
, cast_type as (
  SELECT 
  CAST(customer_key AS INTEGER) AS customer_key,
  CAST(customer_name AS STRING) AS customer_name,
  CAST(customer_category_key AS INTEGER) AS customer_category_key,
  CAST(buying_group_key AS INTEGER) AS buying_group_key,
  CAST(is_on_credit_hold AS BOOLEAN) AS is_on_credit_hold_boolean
  FROM rename_columns
)
, convert_boolean AS (
  SELECT
  *,
  CASE 
      WHEN is_on_credit_hold_boolean is TRUE THEN 'On Credit Hold' 
      WHEN is_on_credit_hold_boolean is FALSE THEN 'Not On Credit Hold' 
      WHEN is_on_credit_hold_boolean IS NULL THEN 'Undefined'
      ELSE 'Invalid'
      END AS is_on_credit_hold
  FROM cast_type
)
, union_undefined_record AS (
  SELECT 
    customer_key,
    customer_name,
    customer_category_key,
    buying_group_key,
    is_on_credit_hold
  FROM convert_boolean
  UNION ALL
  SELECT 
  0 AS customer_key,
  'Undefined' AS customer_name,
  0 AS customer_category_key,
  0 AS buying_group_key,
  'Undefined' AS is_on_credit_hold
  UNION ALL
  SELECT
  -1 AS customer_key,
  'Invalid' AS customer_name,
  -1 AS customer_category_key,
  -1 AS buying_group_key,
  'Invalid' AS is_on_credit_hold
)
select 
customer.customer_key,
customer.customer_name,
customer.customer_category_key,
COALESCE(customer_category.customer_category_name, 'Invalid') AS customer_category_name,
customer.buying_group_key,
COALESCE(buying_group.buying_group_name, 'Invalid') AS buying_group_name,
customer.is_on_credit_hold
from union_undefined_record as customer
left join {{ref('stg_dim_customer_categories')}} customer_category
on customer.customer_category_key = customer_category.customer_category_key
left join {{ref('stg_dim_buying_group')}} buying_group
on customer.buying_group_key = buying_group.buying_group_key