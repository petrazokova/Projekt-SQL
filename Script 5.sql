--5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?--     
 
 SELECT 
	p.common_year,
	ROUND(((AVG(p.average_wage::NUMERIC) - AVG(p2.average_wage::NUMERIC)) / AVG(p2.average_wage::NUMERIC) * 100),
	2) AS salary_growth,
	ROUND(((AVG(p.average_price::NUMERIC) - AVG(p2.average_price::NUMERIC)) / AVG(p2.average_price::NUMERIC) * 100),
	2) AS price_growth,
	 ROUND(((p.gdp::NUMERIC-p2.gdp::NUMERIC) / p2.gdp::NUMERIC * 100),
	2) AS gdp_growth
FROM
	t_petra_zokova_project_SQL_primary_final p
JOIN t_petra_zokova_project_SQL_primary_final p2 ON
	p.common_year = p2.common_year + 1
GROUP BY
	p.common_year,
	p.gdp,
	p2.gdp
ORDER BY
	p.common_year;
 
