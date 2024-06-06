SELECT
  zipcode,
  gender,
  total_population,
  DENSE_RANK() OVER (PARTITION BY gender ORDER BY total_population ASC) AS male_rank
FROM (
  SELECT
    zipcode,
    gender,
    SUM(population) AS total_population
  FROM
    `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
  WHERE
    gender = 'male'
  GROUP BY
    zipcode,
    gender )
QUALIFY
  DENSE_RANK() OVER (PARTITION BY gender ORDER BY total_population ASC)<10
ORDER BY
male_rank;