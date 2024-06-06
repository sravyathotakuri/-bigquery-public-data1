SELECT gender, age_group1, age_group2,total_population,
dense_rank() over (partition by gender order by total_population DESC) AS head_count
from(
SELECT
gender,
minimum_age AS age_group1,
maximum_age AS age_group2,
Sum(population) AS total_population
FROM
  `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
  WHERE zipcode = '94085'  AND
  minimum_age is not null AND
  maximum_age is not null AND
  gender is not null
  group by
  age_group1,
  age_group2,
  gender
)
  ORDER BY total_population DESC;

