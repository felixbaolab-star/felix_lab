WITH source_data as (
  SELECT 
  *
  FROM {{ ref('dim_person') }}
)
SELECT 
person_key as picked_by_person_key,
full_name as picked_by_full_name
FROM source_data