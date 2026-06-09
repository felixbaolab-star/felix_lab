with source_data as (
  select * 
  from 
`vit-lam-data.wide_world_importers.sales__order_lines`
)
, rename_columns as (
  select 
  order_line_id as sales_order_line_key,
  stock_item_id as product_key,
  quantity,
  unit_price
  from source_data
)
, cast_type as (
  select 
  CAST(sales_order_line_key AS INTEGER) AS sales_order_line_key,
  CAST(product_key AS INTEGER) AS product_key,
  CAST(quantity AS INTEGER) AS quantity,
  CAST(unit_price AS NUMERIC) AS unit_price
  from rename_columns
)
  select 
  sales_order_line_key,
  product_key,
  quantity,
  unit_price,
  quantity * unit_price AS gross_amount
  from cast_type