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
select 
buying_group_key,
buying_group_name
from 
cast_type