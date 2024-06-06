SELECT zipcode,
gender,
total_population,
dense_rank() over(partition by gender order by total_population) AS rank_pop
FROM(
SELECT
  zipcode,
  gender,
  SUM(population) AS total_population
FROM
  `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
WHERE
  zipcode = '94085' and
  gender is not null
GROUP BY
  zipcode,
  gender
)
ORDER BY
  total_population;