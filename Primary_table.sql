CREATE TABLE t_petra_zokova_project_SQL_primary_final AS
SELECT
	a.common_year,
	a.industry,
	a.average_wage,
	b.food_category,
	b.average_price,
	b.price_value,
	b.price_unit
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
		AND calculation_code = 200
	GROUP BY
		cp.payroll_year,
		cpib.name ) a
JOIN
(
	SELECT
		date_part('year',
		cpr.date_from) AS price_year,
		cpc.name AS food_category,
		AVG(cpr.value) AS average_price,
		cpc.price_value AS price_value,
		cpc.price_unit AS price_unit
	FROM
		czechia_price cpr
	JOIN czechia_price_category cpc ON
		cpr.category_code = cpc.code
		AND region_code IS NULL
	GROUP BY
		cpc.name,
		date_part('year',
		cpr.date_from),
		cpc.price_value,
		cpc.price_unit) b
ON
	a.common_year = b.price_year
ORDER BY
	a.common_year,
	a.industry,
	b.food_category;
