--1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají ?--

SELECT
	p.common_year,
	p.industry,
	p.average_wage,
	p2.average_wage AS previous_wage,
	ROUND(((p.average_wage-p2.average_wage) / p2.average_wage * 100),
	2) AS yearly_growth,
	CASE
		WHEN ROUND(((p.average_wage-p2.average_wage) / p2.average_wage * 100),
		2) < 0 THEN 'DECREASE'
		ELSE 'increase'
	END AS wage_fluctuation
FROM
	t_petra_zokova_project_SQL_primary_final p
JOIN t_petra_zokova_project_SQL_primary_final p2 ON
	p.industry = p2.industry
	AND p.common_YEAR = p2.common_YEAR + 1
GROUP BY
	p.common_year,
	p.industry,
	p.average_wage,
	p2.average_wage
ORDER BY
	p.industry,
	p.common_year;
