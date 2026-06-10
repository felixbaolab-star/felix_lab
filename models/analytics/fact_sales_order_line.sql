with source_data as (
  select * 
  from 
  `vit-lam-data.wide_world_importers.sales__order_lines`
)
, rename_columns as (
  select 
  order_line_id as sales_order_line_key,
  order_id as sales_order_key,
  stock_item_id as product_key,
  quantity,
  unit_price
  from source_data
)
, cast_type as (
  select 
  CAST(sales_order_line_key AS INTEGER) AS sales_order_line_key,
  cast(sales_order_key AS INTEGER) AS sales_order_key,
  CAST(product_key AS INTEGER) AS product_key,
  CAST(quantity AS INTEGER) AS quantity,
  CAST(unit_price AS NUMERIC) AS unit_price
  from rename_columns
)
  select 
  fact_line.sales_order_line_key,
  fact_line.sales_order_key,
  fact_line.product_key,
  fact_line.quantity,
  fact_line.unit_price,
  fact_line.quantity * fact_line.unit_price AS gross_amount,
  fact_header.customer_key
  from cast_type fact_line
  left join {{ref('stg_fact_sales_order')}} fact_header
  on fact_line.sales_order_key = fact_header.sales_order_key