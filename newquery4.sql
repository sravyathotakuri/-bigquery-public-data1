SELECT
gender,
minimum_age,
maximum_age,
total_population,
dense_rank() over(partition by gender order by total_population DESC) AS male_rank
from
(SELECT
  gender,
  minimum_age,
  maximum_age,
  SUM(population) AS total_population
FROM
  `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
WHERE
  zipcode ='94085'
  AND gender = 'male' AND
  minimum_age is not null AND
  maximum_age is not null
GROUP BY
  minimum_age,
  maximum_age,
  gender
)
ORDER BY
  total_population DESC;