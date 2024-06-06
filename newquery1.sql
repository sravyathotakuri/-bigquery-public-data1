SELECT zipcode,
total_population,
dense_rank() over (partition by zipcode order by total_population) AS rank
FROM
(SELECT
zipcode,
Sum(population) AS total_population
FROM
  `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
  WHERE 
  zipcode = '94085'
  GROUP BY zipcode
)
  ORDER BY total_population DESC;