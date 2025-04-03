CREATE TABLE t_petra_zokova_project_SQL_secondary_final AS
SELECT
	e.year,
	e.country,
	e.gdp,
	e.gini,
	e.population
FROM
	economies e
JOIN countries c ON
	e.country = c.country
	AND c.continent = 'Europe'
	AND e.year BETWEEN 2006 AND 2018
GROUP BY
	e.year,
	e.country,
	e.gdp,
	e.gini,
	e.population
ORDER BY
	e.year,
	e.country;
