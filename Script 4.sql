--4.Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?--

SELECT 
    p.common_year,
    ROUND(
        ((AVG(p.average_wage::numeric) - AVG(p2.average_wage::numeric)) / AVG(p2.average_wage::numeric)) * 100, 2
    ) AS salary_growth,
    ROUND(
        ((AVG(p.average_price::numeric) - AVG(p2.average_price::numeric)) / AVG(p2.average_price::numeric)) * 100, 2
    ) AS price_growth,
    ROUND(
        ((AVG(p.average_price::numeric) - AVG(p2.average_price::numeric)) / AVG(p2.average_price::numeric)) * 100, 2
    ) - ROUND(
        ((AVG(p.average_wage::numeric) - AVG(p2.average_wage::numeric)) / AVG(p2.average_wage::numeric)) * 100, 2
    ) AS difference
FROM 
    t_petra_zokova_project_SQL_primary_final AS p
JOIN 
    t_petra_zokova_project_SQL_primary_final AS p2
    ON p.common_year = p2.common_year + 1
GROUP BY 
    p.common_year
ORDER BY 
    p.common_year;
