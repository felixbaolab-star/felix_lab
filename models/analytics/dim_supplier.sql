with source_data as (
  SELECT * 
  FROM `vit-lam-data.wide_world_importers.purchasing__suppliers`
)
, rename_columns as (
  SELECT 
  supplier_id AS supplier_key,
  supplier_name
  FROM source_data
)
, cast_type as (
  SELECT 
  CAST(supplier_key AS INTEGER) AS supplier_key,
  CAST(supplier_name AS STRING) AS supplier_name
  FROM rename_columns
)
, union_undefined_record AS (
  SELECT 
    supplier_key,
    supplier_name
  FROM cast_type
  UNION ALL
  SELECT 
  0 AS supplier_key,
  'Undefined' AS supplier_name
  UNION ALL
  SELECT
  -1 AS supplier_key,
  'Invalid' AS supplier_name
)
SELECT 
supplier_key,
supplier_name
FROM union_undefined_record