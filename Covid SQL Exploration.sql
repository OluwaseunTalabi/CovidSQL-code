-- Creating a Database with the name Portfolio_Project
Create database Portfolio_Project
CREATE TABLE Covid_deaths (
    iso_code CHAR(255),
    continent CHAR(255),
    location CHAR(255),
    new_date CHAR(15),
    population CHAR(255),
    total_cases CHAR(255),
    new_cases CHAR(255),
    new_cases_smoothed CHAR(255),
    total_deaths CHAR(255),
    new_deaths CHAR(255),
    new_deaths_smoothed CHAR(255),
    total_cases_per_million CHAR(255),
    new_cases_per_million CHAR(255),
    new_cases_smoothed_per_million CHAR(255),
    total_deaths_per_million CHAR(255),
    new_deaths_per_million CHAR(255),
    new_deaths_smoothed_per_million CHAR(255),
    reproduction_rate CHAR(255),
    icu_patients CHAR(255),
    icu_patients_per_million CHAR(255),
    hosp_patients CHAR(255),
    hosp_patients_per_million CHAR(255),
    weekly_icu_admissions CHAR(255),
    weekly_icu_admissions_per_million CHAR(255),
    weekly_hosp_admissions CHAR(255),
    weekly_hosp_admissions_per_million CHAR(255)
)

-- Show the whole dataset
SELECT 
    *
FROM
    portfolio_project.covid_deaths;


-- Number of the Countries Affected with Covid 
SELECT 
    COUNT(DISTINCT location) AS TotalCountries_withCovid
FROM
    portfolio_project.covid_deaths;
   

-- Distinct count of each Countries Affected with Covid   
SELECT 
    DISTINCT (location) AS Countries_withCovid
FROM
    portfolio_project.covid_deaths; 
    

-- Filtering the data to show 3 countries Germany, Afghanistan, Cambodia
SELECT 
    *
FROM
    portfolio_project.covid_deaths
WHERE
    location IN ('Germany' , 'Afghanistan', 'Cambodia');

-- OR 

SELECT 
    *
FROM
    portfolio_project.covid_deaths
WHERE
    location = 'Germany'
        OR location = 'Afghanistan'
        OR location = 'Cambodia';      


-- Selection of Data to be used
SELECT 
    location,
    new_date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM
    portfolio_project.covid_deaths
ORDER BY 1 , 2;


-- Calculating Total Cases Vs Total Deaths
-- Probability of dying if one contact Covid-19 in Nigeria
SELECT 
    location,
    new_date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS Deaths_Percentage
FROM
    portfolio_project.covid_deaths
WHERE
    location LIKE '%Nigeria%'
ORDER BY 1 , 2;


-- Probability of dying if one contacts Covid-19 in USA
SELECT 
    location,
    new_date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS Deaths_Percentage
FROM
    portfolio_project.covid_deaths
WHERE
    location = 'United States'
ORDER BY 1 , 2;


-- Calculating Total Cases Vs Population
-- Show percentage of population that contacted Covid-19 in Germany
SELECT 
    location,
    new_date,
    population,
    total_cases,
    (total_cases / population) * 100 AS Corona_Percentage
FROM
    portfolio_project.covid_deaths
WHERE
    location = 'Germany'
ORDER BY 1 , 2;


-- Showing Countries with Highest Infections of Covid
SELECT 
    location,
    population,
    MAX(total_cases) AS HighestInfectedCount,
    MAX(total_cases / population) * 100 AS Percent_of_PopulationInfected
FROM
    portfolio_project.covid_deaths
GROUP BY location , population
ORDER BY Percent_of_PopulationInfected DESC;


-- Filtering to show Countries with Highest Deathrate per population
SELECT 
    location, MAX(total_deaths) AS TotalDeathsCount
FROM
    portfolio_project.covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathsCount DESC;


-- Filtering to check total deaths by Continents
SELECT 
    continent, MAX(total_deaths) AS DeathsCount_byContinent
FROM
    portfolio_project.covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY continent
ORDER BY DeathsCount_byContinent DESC;


-- Total Death Count around the World by Dates
SELECT 
    new_date, SUM(new_cases) AS NewCases
FROM
    portfolio_project.covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY location
ORDER BY NewCases DESC;


-- Total sum of people referred to Intensive Care Unit (ICU) around the World 
SELECT 
    SUM(icu_patients)
FROM
    portfolio_project.covid_deaths;


-- Different Date of Covid Cases, Deaths and Percentage around the World
SELECT 
    new_date,
    SUM(new_cases) AS totalcases,
    SUM(new_deaths) AS totaldeaths,
    SUM(new_deaths) / SUM(new_cases) * 100 AS Deaths_Percentage
FROM
    portfolio_project.covid_deaths
WHERE
    continent IS NOT NULL
GROUP BY new_date;


-- Sum of Total cases, Total Deaths and Deaths Percentage in the World
SELECT 
    SUM(new_cases) AS totalcases,
    SUM(new_deaths) AS totaldeaths,
    SUM(new_deaths) / SUM(new_cases) * 100 AS Deaths_Percentage
FROM
    portfolio_project.covid_deaths;
    

-- Joining Covid Deaths and Covid Vaccinations tables
-- JOINS

SELECT 
    covid_deaths.continent,
    covid_deaths.location,
    covid_deaths.new_date,
    covid_deaths.population,
    covid_vaccinations.new_vaccinations
FROM
    portfolio_project.covid_deaths
        JOIN
    portfolio_project.covid_vaccinations ON covid_deaths.location = covid_vaccinations.location
        AND covid_deaths.new_date = covid_vaccinations.new_date
WHERE
    covid_deaths.continent IS NOT NULL
ORDER BY 2 , 3;
