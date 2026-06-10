with source_data AS (
  SELECT 
  *
  FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
)
, rename_columns AS (
  SELECT 
  stock_item_id AS product_key,
  stock_item_name AS product_name,
  brand AS brand_name,
  supplier_id AS supplier_key,
  is_chiller_stock
  FROM source_data
)
, cast_type AS (
  SELECT
  CAST(product_key AS INTEGER) AS product_key,
  CAST(product_name AS STRING) AS product_name,
  CAST(brand_name AS STRING) AS brand_name,
  CAST(supplier_key AS INTEGER) AS supplier_key,
  cast(is_chiller_stock AS BOOLEAN) AS is_chiller_stock_boolean
  FROM rename_columns
)
, convert_boolean AS (
  SELECT
  *,
  CASE 
      WHEN is_chiller_stock_boolean is TRUE THEN 'Chiller Stock' 
      WHEN is_chiller_stock_boolean is FALSE THEN 'Non-Chiller Stock' 
      WHEN is_chiller_stock_boolean IS NULL THEN 'Undefined'
      ELSE 'Invalid'
      END AS is_chiller_stock
  FROM cast_type
)
SELECT  
product.product_key,
product.product_name,
product.brand_name,
product.supplier_key,
supplier.supplier_name,
product.is_chiller_stock
FROM 
convert_boolean product
left join {{ref('dim_supplier')}} supplier
on product.supplier_key = supplier.supplier_key