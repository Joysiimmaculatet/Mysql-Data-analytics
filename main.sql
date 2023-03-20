-----Total deaths
select sum(convert(int,total_deaths))as totaldeaths from dbo.CovidDeaths$
------coviddeath trends by totaldeaths,totalcases,totaltests per datewise
SELECT date,isnull(sum(convert(int,total_cases)),0),isnull(sum(convert(int,total_deaths)),0) as TotalDeaths ,isnull(sum(convert(int,total_tests)),0)
FROM dbo.CovidDeaths$
GROUP BY Date
ORDER BY Date ASC

-----Top 10 countries with highest number of coviddeaths
select location, sum(convert(int,total_deaths))as totaldeaths from dbo.CovidDeaths$ group by location order by totaldeaths desc
------totaltest
SELECT SUM(ISNULL(CONVERT(decimal, total_tests), 0)) AS totaltests
FROM dbo.CovidVaccinations$
----totaltest taken by top 10 countries

SELECT location,SUM(ISNULL(CONVERT(decimal, total_tests), 0)) AS totaltests from dbo.CovidVaccinations$ group by location order by totaltests desc

--select data that weare going to share
select location,date,population,new_cases,new_cases_smoothed,new_deaths,new_tests,new_cases_per_million,new_deaths_per_million from  dbo.CovidDeaths$ where continent is not null
--compare total cases vs total deaths and get infection rate from France location only
select total_deaths,max(total_cases) as infection_count,(total_deaths/population)*100 as population_Infection_rate from dbo.CovidDeaths$ where continent is not null and location='France' 
--Countries with highest infection rate for all continents
Select continent,max(total_cases)as infection_count
From dbo.CovidDeaths$
--Where location like '%states%'
Where continent is not null 
Group by continent
order by infection_count desc
-- Showing contintents with the highest death count per population
select location,max(total_deaths)as death_count from dbo.CovidDeaths$ where continent is not null group by location
--Total population vs total vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From dbo.CovidDeaths$ dea
Join dbo.CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3



