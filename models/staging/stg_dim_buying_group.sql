with source_data as (
select 
* 
from `vit-lam-data.wide_world_importers.sales__buying_groups`
)
, rename_columns as (
  select 
  buying_group_id as buying_group_key,
  buying_group_name
  from source_data
)
, cast_type as (
  select 
  CAST(buying_group_key AS INTEGER) AS buying_group_key,
  CAST(buying_group_name AS STRING) AS buying_group_name
  from rename_columns
)
, union_undefined_record AS (
  SELECT 
    buying_group_key,
    buying_group_name
  FROM cast_type
  UNION ALL
  SELECT 
  0 AS buying_group_key,
  'Undefined' AS buying_group_name
  UNION ALL
  SELECT
  -1 AS buying_group_key,
  'Invalid' AS buying_group_name
)
select 
buying_group_key,
buying_group_name
from 
union_undefined_record