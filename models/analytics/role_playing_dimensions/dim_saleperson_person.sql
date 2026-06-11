WITH source_data as (
  SELECT 
  *
  FROM {{ ref('dim_person') }}
)
SELECT 
person_key as salesperson_person_key,
full_name as salesperson_full_name
FROM source_data