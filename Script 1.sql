--1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?--

CREATE VIEW yearly_payroll AS
SELECT
	common_year,
	industry,
	average_wage
FROM
	t_petra_zokova_project_SQL_primary_final
GROUP BY
	common_year,
	industry,
	average_wage
ORDER BY
	industry,
	common_year;

SELECT * FROM yearly_payroll;

SELECT
	yp.common_year,
	yp.industry,
	ROUND(((yp.average_wage-yp2.average_wage) / yp2.average_wage * 100),
	2) AS yearly_growth
FROM
	yearly_payroll yp
JOIN yearly_payroll yp2 ON
	yp.industry = yp2.industry
	AND yp.common_year = yp2.common_year + 1
WHERE
	ROUND(((yp.average_wage-yp2.average_wage) / yp2.average_wage * 100),
	2) < 0
ORDER BY
	yp.common_year,
	yp.industry;
