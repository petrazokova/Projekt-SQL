# **Projekt z SQL** #

## **1. Úvod do projektu** ##

Projekt se zabývá cenami základních potravin, průměrnými mzdami v různých
odvětvích a HDP v letech 2006–2018. Cílem projektu bylo vypracovat datové
podklady, které pomohou odpovědět na níže uvedené výzkumné otázky.
Pracovalo se s volně přístupnými datovými sadami, které pocházejí z portálu
otevřených dat ČR. SQL skripty byly vytvořeny v relační databázi PostgreSQL
pomocí programu DBeaver v rámci absolvování Datové akademie Engeto.

### **Výzkumné otázky** ###

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a
poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší
procentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší
než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli,
pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách
potravin či mzdách ve stejném nebo následujícím roce výraznějším
růstem?

### **Datové sady, z kterých bylo možné čerpat.** ###

**Primární tabulky:**

* **czechia_payroll** – Informace o mzdách v různých odvětvích za několikaleté
období. Datová sada pochází z Portálu otevřených dat ČR.
* **czechia_payroll_calculation** – Číselník kalkulací v tabulce mezd.
* **czechia_payroll_industry_branch** – Číselník odvětví v tabulce mezd.
* **czechia_payroll_unit** – Číselník jednotek hodnot v tabulce mezd.
* **czechia_payroll_value_type** – Číselník typů hodnot v tabulce mezd.

* **czechia_price** – Informace o cenách vybraných potravin za několikaleté
období. Datová sada pochází z Portálu otevřených dat ČR.
* **czechia_price_category** – Číselník kategorií potravin, které se vyskytují v
našem přehledu.

**Číselníky sdílených informací o ČR:**

* **czechia_region** – Číselník krajů České republiky dle normy CZ-NUTS 2.
* **czechia_district** – Číselník okresů České republiky dle normy LAU.

**Dodatečné tabulky:**

* **countries** – všemožné informace o zemích na světě, například hlavní město,
měna, národní jídlo nebo průměrná výška populace.
* **economies** – HDP, GINI, daňová zátěž atd. pro daný stát a rok.

## **2. Vytvořené tabulky** ##
   
Ze vstupních dat byla nejdříve vytvořena tabulka
**t_petra_zokova_projekt_z_SQL_primary_final**, která obsahuje data
průměrných cen potravin a mezd v České republice sjednocené za totožné
období mezi roky 2006 a 2018. Tabulka vznikla spojením dvou částí: **části a** -
pro průměrné mzdy a **části b** - pro průměrné ceny potravin.
Pro část a byla zdrojem dat tabulka czechia_payroll a czechia_industry_branch
ze kterých byly vybrány názvy odvětví a průměrné mzdy. Výsledky byly
omezeny pouze na hodnoty, které mají ve sloupci value_type_code hodnotu
5958, což je kód průměrných mezd a ve sloupci calculation_code hodnotu 200,
kde se jedná o mzdu zaměstnanců na plný úvazek. Ve sloupci unit_code ve
zdrojových datech došlo k záměně kódů pro průměrnou hrubou mzdu a počet
zaměstnanců, z toho důvodu tento sloupec nebyl zahrnut do primární tabulky.
Zdrojem dat pro část b byly tabulky czechia_price a czechia_price_category, ze
kterých byly vybrány roky měření, názvy kategorií potravin, jejich průměrná
cena a dále množství a jednotky ve kterých byla cena produktů uvedena.
Výsledky byly omezeny pouze na hodnoty, které měly ve sloupci region_code
hodnotu NULL, jelikož se jedná o celorepublikový průměr.
Primární tabulka obsahuje 7 sloupců:

* **common_year** – společné roky měření
* **industry** – název odvětví
* **average_wage** – průměrná mzda
* **food_category** – název kategorie potravin
* **average_price** – průměrná cena produktu
* **price_value** – množství produktu
* **price_unit** – jednotka produktu
  
Následně byla vytvořena tabulka
**t_petra_zokova_projekt_z_SQL_secondary_final** pro dodatečná data o
dalších evropských státech (HDP, Giniho koeficient, populace). Jako zdroj dat
byly použity tabulky economies a countries.

Na závěr byla vytvořena sada SQL, která nám umožnila z tabulek získat
odpovědi na výzkumné otázky.

## **3. Výsledky projektu** ##

**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých
klesají**

Porovnáním průměrných mezd v letech 2006 a 2018 je zřejmé, že ve všech
odvětvích se průměrné mzdy zvyšovaly, existují ale odvětví, kde v některých
letech došlo k jejímu snížení. Tyto roky a odvětví jsou označeny v posledním
sloupci wage_fluctuation jako DECREASE. Z tabulky je zřejmé, že největší
propad mezd byl zaznamenán v oblasti peněžnictví a pojišťovnictví v roku
2013, kdy se průměrná mzda propadla o 8,83 %. Nejčastější propad mezd
zaznamenalo odvětví těžby a dobývání, kde se průměrná mzda za sledované
období propadla ve čtyřech obdobích, a to v letech 2009, 2013, 2014 a 2016.

**2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a
poslední srovnatelné období v dostupných datech cen a mezd?**

Byl vytvořen dotaz, v jehož rámci byla spočítána průměrná cena produktů a
souhrnná průměrná mzda v ČR v jednotlivých letech. Následně byla vydělena
průměrná mzda průměrnou cenou produktu. Výsledky byly omezeny pouze na
kategorie potravin, kterých se otázka týká – mléko a chléb za první a poslední
srovnatelné období, tedy roky 2006 a 2018. Výsledkem byla tabulka, ve které
lze vidět, že v roce 2006 bylo za průměrnou mzdu 21165 Kč možné koupit 1313
kg chleba v ceně 16,12 Kč za kilogram a 1466 litrů mléka v ceně 14,44 Kč za
litr. V roce 2018 byla průměrná mzda 33091 Kč a bylo za ni možné koupit
1365kg chleba v ceně 24,24 Kč za kilogram a 1670 litrů mléka v ceně 19,82
Kč za litr.

**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší
procentuální meziroční nárůst)?**

Pro odpověď na tuto otázku byl vytvořen dotaz, ve kterém byl pro každou
kategorii potravin spočítán průměrný meziroční procentuální růst. Z výsledné
tabulky je zřejmé, že kategorií potravin, která zdražovala nejpomaleji byly
banány žluté s meziročním růstem 0,81 %. Kategoriemi potravin které
meziročně dokonce zlevňovaly byl krystalový cukr a rajská jablka.

**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně
vyšší než růst mezd (větší než 10 %)?**

Nejprve byl spočítán průměrný meziroční růst mezd a cen potravin a následně
rozdíl mezi těmito hodnotami. Výsledkem je tabulka, kde v posledním sloupci
difference lze vidět procentuální rozdíl mezi růstem cen a mezd. Je zřejmé, že
existují roky, kdy byl meziroční růst cen vyšší než růst mezd, ale tato hodnota
nikdy nebyla vyšší než 10 %. Nejvýrazněji rostla cena potravin oproti mzdám v
roce 2013 a to o 6,66 %. Mzdy oproti potravinám nejvíce rostly v roce 2009 a to
o 9,48 %.

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
není možné jednoznačně prokázat, jelikož mzdy a ceny potravin jsou ovlivněny
kromě ekonomických podmínek i jinými faktory.
