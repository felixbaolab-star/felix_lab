with source_data AS (
  SELECT 
  *
  FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
)
, rename_columns AS (
  SELECT 
  stock_item_id AS product_key,
  stock_item_name AS product_name,
  brand AS brand_name
  FROM source_data
)
, cast_type AS (
  SELECT
  CAST(product_key AS INTEGER) AS product_key,
  CAST(product_name AS STRING) AS product_name,
  CAST(brand_name AS STRING) AS brand_name
  FROM rename_columns
)
SELECT  
product_key,
product_name,
brand_name
 FROM 
cast_type