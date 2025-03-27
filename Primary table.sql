CREATE TABLE t_petra_zokova_project_SQL_primary_final AS
SELECT
	a.common_year,
	a.industry,
	a.average_wage,
	b.food_category,
	b.average_price,
	c.gdp
FROM
	(
	SELECT
		cp.payroll_year AS common_year,
		cpib.name AS industry,
		AVG(cp.value) AS average_wage
	FROM
		czechia_payroll cp
	JOIN czechia_payroll_industry_branch cpib ON
		cp.industry_branch_code = cpib.code
		AND value_type_code = 5958
	GROUP BY
		cp.payroll_year,
		cpib.name ) a
JOIN
(
	SELECT
		date_part('year',
		cpr.date_from) AS price_year,
		cpc.name AS food_category,
		AVG(cpr.value) AS average_price
	FROM
		czechia_price cpr
	JOIN czechia_price_category cpc ON
		cpr.category_code = cpc.code
	GROUP BY
		cpc.name,
		date_part('year',
		cpr.date_from)) b
ON
	a.common_year = b.price_year
JOIN
(
	SELECT
		YEAR AS economy_year,
		gdp
	FROM
		economies e
	WHERE
		country = 'Czech Republic'
	GROUP BY
		economy_year,
		gdp)c
ON
	b.price_year = c.economy_year
ORDER BY a.common_year, a.industry, b.food_category;
