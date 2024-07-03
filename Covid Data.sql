--select * from PortfolioProject..CovidDeaths
--order by 3,4

--select * from PortfolioProject..CovidVaccinations
--order by 3,4

--select Location, date, total_cases, new_cases, total_deaths, population from PortfolioProject..CovidDeaths
--order by 1,2

select Location, date, total_cases, total_deaths, 
CONVERT(DECIMAL(18,2),total_deaths)/CONVERT(DECIMAL(18,2),total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2



select Location, date, total_cases, Population, 
Population/CONVERT(DECIMAL(18,2),total_cases)*100 as DeathPercentagePopulation
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2


select Location, Population, CONVERT(DECIMAL(18,2) ,total_cases),
total_cases as TC,
(MAX(total_cases/Population)*100) as ppi
from PortfolioProject..CovidDeaths
--where location like '%states%'
Group by Location, Population, total_cases
order by ppi desc;

select Location, CONVERT(DECIMAL(18,2) ,total_deaths),
total_deaths as TD,
(MAX(total_deaths)*100) as TDC
from PortfolioProject..CovidDeaths
--where location like '%pakistan%'
where continent is not null
Group by Location, total_deaths
order by TDC desc;

select * from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2

select location, (CONVERT(DECIMAL(18,2), total_deaths), (CONVERT(DECIMAL(18,2), total_cases)
((total_deaths/total_cases)*100) as TDP
from PortfolioProject..CovidDeaths
--where location like '%world%'
where continent is not null
Group by location,total_deaths, total_cases, TDP
order by 1,2;

select CONVERT(DECIMAL(18,2) ,total_deaths) as TD ,CONVERT(DECIMAL(18,2) ,total_cases) as TC,

from PortfolioProject..CovidDeaths

ALTER TABLE PortfolioProject..CovidDeaths
ADD TC INT;

Select total_cases,TC from PortfolioProject..CovidDeaths

UPDATE PortfolioProject..CovidDeaths
SET TD = CAST(total_deaths as INT); 

UPDATE PortfolioProject..CovidDeaths
SET TC = CAST(total_cases as INT); 

select Location, TC, TD, TC/TD * 100 as DP
from PortfolioProject..CovidDeaths
where TC is not null
order by 1,2

select *
from PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3