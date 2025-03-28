# **Projekt z SQL** #

## **1. Úvod do projektu** ##

Projekt se zabývá cenami základních potravin, průměrnými mzdami v různých
odvětvích a HDP v letech 2006–2018. Cílem projektu bylo vypracovat datové
podklady, které pomohou odpovědět na níže uvedené výzkumné otázky.
Pracovalo se s volně přístupnými datovými sadami, které pocházejí z portálu
otevřených dat ČR. SQL dotazy byly vytvořeny v relační databázi PostgreSQL
pomocí programu DBeaver v rámci absolvování Datové akademie Engeto.

**Výzkumné otázky**

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a
poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší
percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší
než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli,
pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách
potravin či mzdách ve stejném nebo následujícím roce výraznějším
růstem?

**Datové sady, z kterých bylo možné čerpat**

**Primární tabulky:**

- **czechia_payroll** – Informace o mzdách v různých odvětvích za několikaleté
období. Datová sada pochází z Portálu otevřených dat ČR.
- **czechia_payroll_calculation** – Číselník kalkulací v tabulce mezd.
- **czechia_payroll_industry_branch** – Číselník odvětví v tabulce mezd.
- **czechia_payroll_unit** – Číselník jednotek hodnot v tabulce mezd.
- **czechia_payroll_value_type** – Číselník typů hodnot v tabulce mezd.
- **czechia_price** – Informace o cenách vybraných potravin za několikaleté
období. Datová sada pochází z Portálu otevřených dat ČR.
- **czechia_price_category** – Číselník kategorií potravin, které se vyskytují v
našem přehledu.

**Číselníky sdílených informací o ČR:**

- **czechia_region** – Číselník krajů České republiky dle normy CZ-NUTS 2.
- **czechia_district** – Číselník okresů České republiky dle normy LAU.

**Dodatečné tabulky:**

- **countries** – všemožné informace o zemích na světě, například hlavní město,
měna, národní jídlo nebo průměrná výška populace.
- **economies** – HDP, GINI, daňová zátěž atd. pro daný stát a rok.

## **2. Vytvořené tabulky** ##

Ze vstupních dat byly vytvořeny dvě tabulky:

- **t_petra_zokova_projekt_z_SQL_primary_final**, která obsahuje data cen
potravin, mezd a HDP v České republice sjednocené za totožné období mezi
roky 2006 a 2018. Tabulka vznikla spojením tří hlavních částí:
  - část a – informace o průměrných mzdách v různých odvětvích ČR.
Jako zdroj dat byla použita tabulka czechia_payroll a
czechia_industry_branch,
  - část b – informace o průměrných cenách potravin v ČR, jako zdroj byla
použita tabulka czechia_price a czechia_price_category,
  - část c – informace o hodnotě HDP v ČR, zdrojem dat byla tabulka
economies.

- **t_petra_zokova_projekt_z_SQL_secondary_final** pro dodatečná data o
dalších evropských státech (HDP, Giniho koeficient, populace). Jako
zdroj dat byly použity tabulky economies a countries.
Dále byla vytvořena sada SQL, která umožnila z vytvořených tabulek získat
odpovědi na výzkumné otázky.

## **3. Výsledky projektu** ##

**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých
klesají?**

Nejdříve byl vytvořen pohled yearly_payroll, kde je vidět průměrnou mzdu v
jednotlivých odvětvích za jednotlivé roky. Porovnáním průměrných mezd
v letech 2006 a 2018 je zřejmé, že ve všech odvětvích se průměrné mzdy
zvyšovaly, existují ale odvětví, kde v některých letech došlo k jejímu snížení.
Ke zjištění, o které roky a odvětví se jedná, byl v rámci pohledu yearly_payroll
vytvořen dotaz, ve kterém byl spočítán průměrný meziroční nárůst mezd.
Výsledky byly omezeny pouze na hodnoty menší než 0, tedy období, kde
průměrný růst mezd byl záporný. Z tabulky je zřejmé, že největší propad mezd
byl zaznamenán v oblasti peněžnictví a pojišťovnictví v roku 2013, kdy se
průměrná mzda propadla o 8,91 %. Nejčastější propad mezd zaznamenalo
odvětví těžby a dobývání, kde se průměrná mzda za sledované období propadla
ve čtyřech obdobích, a to v letech 2009, 2013, 2014 a 2016.

**2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a
poslední srovnatelné období v dostupných datech cen a mezd?**

Byl vytvořen dotaz, v jehož rámci byla spočítána průměrná cena produktů a
souhrnná průměrná mzda v ČR v jednotlivých letech. Následně byla vydělena
průměrná mzda průměrnou cenou produktu. Výsledky byly omezeny pouze na
kategorie potravin, kterých se otázka týká – mléko a chléb za první a poslední
srovnatelné období, tedy roky 2006 a 2018. Výsledkem byla tabulka, ve které
lze vidět, že v roce 2006 bylo za průměrnou mzdu 20 754 Kč možné koupit
1287 kg chleba v ceně 16,12 Kč za kilogram a 1437 litrů mléka v ceně 14,44
Kč za litr. V roce 2018 byla průměrná mzda 32 536 Kč a bylo za ni možné
koupit 1342 kg chleba v ceně 24,24 Kč za kilogram a 1642 litrů mléka v ceně
19,82 Kč za litr.

**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší
procentuální meziroční nárůst)?**

Pro odpověď na tuto otázku byl vytvořen dotaz, ve kterém byl pro každou
kategorii potravin spočítán průměrný meziroční procentuální růst. Z výsledné
tabulky lze vidět, že kategorií potravin, která zdražovala nejpomaleji, byl
krystalový cukr, a to o -1,92 %. Druhou kategorií potravin se záporným
meziročním růstem byly rajská jablka, a to o -0,74 %. Cena těchto produktů
tedy meziročně klesala. Potravinou s nejvyšším růstem byly papriky, u kterých
se cena meziročně zvyšovala o 7,29 %.

**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně
vyšší než růst mezd (větší než 10 %)?**

Nejprve byl spočítán průměrný meziroční růst mezd a cen potravin a následně
rozdíl mezi těmito hodnotami. Výsledkem je tabulka, kde v posledním sloupci
difference lze vidět procentuální rozdíl mezi růstem cen a mezd. Je zřejmé, že
existují roky, kdy byl meziroční růst cen vyšší než růst mezd, ale tato hodnota
nikdy nebyla vyšší než 10 %. Nejvýrazněji rostla cena potravin oproti mzdám v
roce 2013 a to o 6,66 %. Mzdy oproti potravinám nejvíce rostly v roce 2009 a to
o 9,57 %.

**5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli,
pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách
potravin či mzdách ve stejném nebo následujícím roce výraznějším
růstem?**

Pro odpověď na poslední otázku byl spočítán průměrný meziroční růst mezd,
cen potravin a HDP. Z výsledků lze vyvodit, že v roce 2007 došlo k růstu HDP
o 5,57 % a zároveň v tom samém a následujícím roce došlo k výraznému růstu
cen i mezd. V roce 2015, kdy opět došlo k výraznému růstu HDP o 5,39 %, se
růst mezd v totožném a následujícím roce nijak významně nezvýšil a meziroční
růst cen se naopak propadl. Vliv růstu HDP na růst mezd a cen potravin tedy
není možné jednoznačně prokázat, jelikož mzdy a ceny potravin jsou ovlivněné
kromě ekonomických podmínek i jinými faktory.
