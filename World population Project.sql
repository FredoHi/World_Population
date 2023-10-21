use wolrd_population;

SELECT 
    distinct *
FROM
    wolrd_population.population
group by country;


-- 1. top 10 countries with the highest population in 2015
SELECT 
    Years, Country, Population_Total
FROM
    wolrd_population.population
WHERE
    Years = '2015' -- filter the population result to 2015 only 
ORDER BY Population_Total DESC
LIMIT 10; -- limit the result to 10 rows


-- 2. Yearly world population growth rate 
SELECT
    p1.Years, -- Select the 'Years' column
    ROUND(SUM(p1.Population_Total) - SUM(p2.Population_Total) / SUM(p2.Population_Total) * 100, 2) AS WorldGrowthRate -- Calculate the world's population growth rate and round to two decimal places

-- From the 'population' table, alias it as 'p1'
FROM
    population p1

-- Left join 'population' with itself using an alias 'p2' to find the population data for the previous year
LEFT JOIN
    population p2 ON p1.Years = p2.Years - 1 

-- Group the results by year
GROUP BY p1.Years

-- Order the results by year in ascending order
ORDER BY p1.Years;



-- 3. Average population growth rate per year; average percentage change in population from one year to the next for all countries
SELECT
    p.Years, -- Select the 'Years' column
    AVG(((p.Population_Total - p_prev.Population_Total) / p_prev.Population_Total) * 100) AS AvgGrowthRate -- Calculate the average growth rate

-- From the 'population' table, alias it as 'p'
FROM
    population p

-- Left join 'population' with itself to find the population data for the previous year
LEFT JOIN
    population p_prev ON p.country = p_prev.country AND p.Years = p_prev.Years + 1

-- Group the results by year
GROUP BY p.Years

-- Order the results by year
ORDER BY p.Years;


    
    

-- 4. Top 10 countries with the highest population growth rate in 2015 
SELECT
    p1.country, -- Select the 'country' column
    p1.Years,   -- Select the 'Years' column
    ROUND((p1.Population_Total - p2.Population_Total) / p2.Population_Total * 100, 2) AS GrowthRate -- Calculate the growth rate with two decimal places

-- From the 'population' table, alias it as 'p1'
FROM
    population p1

-- inner join 'population' with itself using an alias 'p2' to find the population data for the previous year
JOIN
    population p2 ON p1.Country = p2.Country
                 AND p2.Years = p1.Years - 1

-- Filter the results to include only records for the year 2015
WHERE
    p1.years = '2015'

-- Order the results by GrowthRate in descending order
ORDER BY GrowthRate DESC

-- Limit the results to the top 10 rows
LIMIT 10;


-- 5. Population distribution by countries in 2015
SELECT
    Years, -- Select the 'Years' column
    country, -- Select the 'country' column
    ROUND((Population_Total / (SELECT SUM(Population_Total) -- Calculate the population distribution with two decimal places
                              FROM population
                              WHERE years = p.Years)) * 100, 2) AS PopulationDistribution

-- From the 'population' table, alias it as 'p'
FROM
    population p

-- Filter the results to include only records for the year 2015
WHERE
    years = '2015'

-- Order the results by PopulationDistribution in descending order
ORDER BY PopulationDistribution DESC;


    
    
    