WITH
  female_age_group AS(
  SELECT
    minimum_age,
    maximum_age,
    SUM(CASE
        WHEN gender='Male' THEN population ELSE 0
    END
      ) AS male_population
  FROM
    `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
  WHERE
    zipcode = '94085'
    AND gender='female'
  GROUP BY
    minimum_age,
    maximum_age 
    )
SELECT
  minimum_age,
  maximum_age,
   male_population,
   dense_rank() over (partition by minimum_age, maximum_age order by male_population DESC) AS male_headcount
FROM
  female_age_group
ORDER BY
  male_population DESC;