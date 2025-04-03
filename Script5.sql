--5. Má výška HDP vliv na změny ve mzdách a cenách potravin ? Neboli, pokud HDP vzroste výrazněji v jednom roce,
projeví se TO na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem ?--

SELECT 
	a.year,
	ROUND(((AVG(a.wage::NUMERIC) - AVG(a.previous_wage::NUMERIC)) / AVG(a.previous_wage::NUMERIC) * 100),
	2) AS salary_growth,
	ROUND(((AVG(a.price::NUMERIC) - AVG(a.previous_price::NUMERIC)) / AVG(a.previous_price::NUMERIC) * 100),
	2) AS price_growth,
	ROUND(((b.gdp::NUMERIC-b.previous_gdp::NUMERIC) / b.previous_gdp::NUMERIC * 100),
	2) AS gdp_growth
FROM
	(
	SELECT
		p.common_year AS YEAR,
		p2.common_year AS previous_year,
		p.average_wage AS wage,
		p2.average_wage AS previous_wage,
		p.average_price AS price,
		p2.average_price AS previous_price
	FROM
		t_petra_zokova_project_SQL_primary_final p
	JOIN t_petra_zokova_project_SQL_primary_final p2 ON
		p.industry = p2.industry
		AND p.food_category = p2.food_category
		AND
	p.common_year = p2.common_year + 1
)a
JOIN
    (
	SELECT
		s.country AS country,
		s.year AS eco_year,
		s2.year AS eco_previous_year,
		s.gdp AS gdp,
		s2.gdp AS previous_gdp
	FROM
		t_petra_zokova_project_SQL_secondary_final s
	JOIN t_petra_zokova_project_SQL_secondary_final s2 ON
		s.country = s2.country
		AND s.year = s2.year + 1
		AND s.year BETWEEN '2006' AND '2018'
		AND s.country = 'Czech Republic'
     )b
 ON
	a.year = b.eco_year
GROUP BY
	a.year,
	b.gdp,
	b.previous_gdp;
