--3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?--

SELECT
	p.food_category,
	ROUND((AVG((p.average_price::NUMERIC - p2.average_price::NUMERIC) / p2.average_price::NUMERIC) * 100),
	2) AS avg_price_growth
FROM
	t_petra_zokova_project_SQL_primary_final p
JOIN t_petra_zokova_project_SQL_primary_final p2
	ON
	p.food_category = p2.food_category
	AND p.common_year = p2.common_year + 1
GROUP BY
	p.food_category
ORDER BY
	avg_price_growth;
