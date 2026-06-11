SELECT
  FORMAT_DATE('%F', d) as id,
  d AS date,
  EXTRACT(WEEK FROM d) AS year_week,
  EXTRACT(DAY FROM d) AS year_day,
  EXTRACT(YEAR FROM d) AS year_number,
  FORMAT_DATE('%Q', d) as fiscal_qtr,
  FORMAT_DATE('%w', d) AS week_day,
  FORMAT_DATE('%A', d) AS day_of_week,
  FORMAT_DATE('%a', d) AS day_of_week_short,
  (CASE WHEN FORMAT_DATE('%A', d) IN ('Sunday', 'Saturday') THEN 'Weekend' ELSE 'Weekday' END) AS is_weekday_or_weekend,
  DATE_TRUNC(d, MONTH) AS year_month,
  DATE_TRUNC(d, YEAR) AS year
FROM (
  SELECT
    *
  FROM
    UNNEST(GENERATE_DATE_ARRAY('2014-01-01', '2050-01-01', INTERVAL 1 DAY)) AS d )