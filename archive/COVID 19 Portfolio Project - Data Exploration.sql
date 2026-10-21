-- Portfolio: COVID-19 Data Exploration
-- Skills used: SQL Server, Joins, CTE's, Temp Tables, Window Functions, Aggregate Functions, Creating Views, Converting Data Types

-- Selecting COVID-19 data for Indonesia
Select *
From PortfolioProject..CovidDeaths
Where location = 'Indonesia'
order by 3, 4

-- Select Data that we are starting with
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where location = 'Indonesia'
order by 1, 2

-- Total Cases vs Total Deaths (likelihood of dying if you contract COVID-19 in your country)
Select Location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location = 'Indonesia'
order by 1, 2

-- Total Cases vs Population (percentage of population infected with COVID-19)
Select Location, date, Population, total_cases, (total_cases / population) * 100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where location = 'Indonesia'
order by 1, 2

-- Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases / population)) * 100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where location = 'Indonesia'
Group by Location, Population
order by PercentPopulationInfected desc

-- Countries with Highest Death Count per Population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where location = 'Indonesia'
Group by Location
order by TotalDeathCount desc

-- BREAKING THINGS DOWN BY CONTINENT
-- Showing continents with the highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where location = 'Indonesia'
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int)) / SUM(New_Cases) * 100 as DeathPercentage
From PortfolioProject..CovidDeaths
where location = 'Indonesia'
-- Group By date
order by 1, 2
