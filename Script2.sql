--2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd ?--

SELECT
	common_year,
	food_category,
	ROUND(AVG(average_wage)) AS average_wage,
	ROUND(AVG(average_price::NUMERIC),
	2) AS average_product_price,
	ROUND(AVG(average_wage) / AVG(average_price)) AS amount_of_products,
	price_value,
	price_unit
FROM
	t_petra_zokova_project_SQL_primary_final
WHERE
	common_year IN ('2006', '2018')
	AND food_category IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
GROUP BY
	food_category,
	common_year,
	price_value,
	price_unit
ORDER BY
	food_category,
	common_year;
