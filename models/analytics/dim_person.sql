with source_data as (
  SELECT * 
  fROM `vit-lam-data.wide_world_importers.application__people`
)
, rename_columns as (
  SELECT 
  person_id as person_key,
  full_name
  FROM source_data
)
, cast_type as (
  SELECT 
  CAST(person_key AS INTEGER) AS person_key,
  CAST(full_name AS STRING) AS full_name
  FROM rename_columns
)
, union_undefined_record as (
  SELECT 
    person_key,
    full_name 
  from cast_type
  UNION ALL
  SELECT 
  0 AS person_key,
  'Undefined' AS full_name
  UNION ALL
  SELECT
  -1 AS person_key,
  'Invalid' AS full_name
)
SELECT 
person_key,
full_name
FROM union_undefined_record

