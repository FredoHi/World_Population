# World Population Analysis 

## Introduction

Introduction/Project Overview:

The world's population is a critical demographic metric that shapes various aspects of our global society. Understanding population trends, growth rates, and distribution is vital for policymakers, researchers, and anyone interested in the dynamics of human societies. This project harnesses the 'wolrd_population' dataset to analyze and visualize key population statistics using SQL queries. The dataset contains population data with three column; country, year and total population allowing us to explore and extract valuable insights.

The project consists of five SQL queries that provide different perspectives on world population dynamics.


## Data Source
**World Population dataset**: the primary dataset used for this project is gotten from **_Kaggle_**


## Tools/Skills
 
- Excel - data cleaning
- Mysql - Data analysis


## Data Cleaning and Preparation
In the initial data preparation phase, we perform the following tasks:
- Data loading and inspection
- Data cleaning and formating.



## Exploratory data analysis

 EDA involve exploring the sales to answer key questions, such as

1. Top 10 Countries with the Highest Population in 2015
  ```SQL
SELECT 
    Years, Country, Population_Total
FROM
    wolrd_population.population
WHERE
    Years = '2015' -- filter the population result to 2015 only 
ORDER BY Population_Total DESC
LIMIT 10; -- limit the result to 10 rows
```

2. Yearly World Population Growth Rate.
```SQL
SELECT
    p1.Years, -- Select the 'Years' column
    ROUND(SUM(p1.Population_Total) - SUM(p2.Population_Total) / SUM(p2.Population_Total) * 100, 2) AS WorldGrowthRate -- Calculate the world's population growth rate and round to two decimal places

-- From the 'population' table, alias it as 'p1'
FROM
    population p1

-- Left join 'population' with itself using an alias 'p2' to find the population data for the previous year
LEFT JOIN
    population p2 ON p2.Years = p1.Years - 1 

-- Group the results by year
GROUP BY p1.Years

-- Order the results by year in ascending order
ORDER BY p1.Years;
```

   
3. Average Population Growth Rate per Year
```SQL
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
 ```


4. Top 10 Countries with the Highest Population Growth Rate in 2015
```SQL
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
```
 
5. Population Distribution by Countries in 2015'
```SQL
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
```



## Skills/Concepts Demonstrated
  These are the SQL functions/statement/Clause used in this query:
  - Aggregate functions
  - JOINS (Inner Join, Left Join, and Self Join)
  - Clause (WHERE, ORDER BY, GROUP BY and LIMIT)


## Results /Findings
- In 2015, China boasted the world's largest population, totaling 1,371,220,000, with India, the United States, Indonesia, Brazil, Pakistan, Nigeria, Bangladesh, the Russian Federation, and Japan following suit in terms of population size.
- The year 2015 witnessed the highest global population growth rate.
- In 2006, the world experienced its most significant average growth rate, whereas 2015 marked the year with the lowest growth rate.
- Oman recorded the highest average growth rate in 2015 at 5.6%, with Nauru, the Maldives, Qatar, Lebanon, Equatorial Guinea, Niger, Kuwait, Jordan, and Uganda rounding out the top 10 countries with the most substantial growth rates in 2015.
- China held the largest share of the global population in 2015, accounting for 18.75% of the total.
  
## Recommedation

###Population Growth Strategies:

- Given China's status as the most populous nation, policymakers should continue to focus on effective population management and family planning programs to ensure sustainable growth.
- Countries with high growth rates in 2015, such as Oman and Nauru, should invest in infrastructure, education, and healthcare to support their growing populations.
- Countries experiencing rapid population growth, like those in the top 10 growth rate list, should invest in job creation, education, and healthcare to harness the potential of their young populations for economic growth and development.
- China's significant population distribution suggests the need for efficient resource allocation, urban planning, and sustainable development practices to cater to the needs of a large and growing population.
- The rapid growth in countries like China and India can lead to increased rural-to-urban migration. Governments and international organizations should focus on effective urban planning, infrastructure development, and job creation to accommodate this transition.
- 2015 witnessed the highest global population growth rate, it is crucial for the international community to address this issue collectively. Collaboration on sustainable development goals, access to healthcare, and education can help manage and reduce the global population growth rate

## Conclusion
In conclusion, the findings highlight the significance of proactive measures to address the challenges posed by population growth. It is imperative for countries with burgeoning populations to prioritize family planning, healthcare, and education while encouraging sustainable development. Moreover, global cooperation is vital to collectively manage population growth and its associated impacts on resources and the environment. By implementing these recommendations, nations can navigate the complexities of growing populations while striving for a more balanced, equitable, and sustainable future.

Thank you for your time😄
