SELECT
  minimum_age,
  maximum_age,
  gender,
  total_population,
   DENSE_RANK() OVER (PARTITION BY gender ORDER BY total_population desc) AS rank
FROM (
  SELECT
    minimum_age,
    maximum_age,
    gender,
    SUM(population) AS total_population
  FROM
    `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
  WHERE
    minimum_age IS NOT NULL
    AND maximum_age IS NOT NULL
  GROUP BY
    minimum_age,
    maximum_age,
    gender )
QUALIFY
  dense_rank () OVER(PARTITION BY gender ORDER BY total_population desc)<6
order by rank,
gender
