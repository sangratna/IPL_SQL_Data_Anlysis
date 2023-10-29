SELECT * FROM ipl_data.ipl_dataset;
-- Matches per venue
select venue_name,count(venue_name) 
from ipl_data.ipl_dataset
group by venue_name;

-- POM list
select 
pom,count(pom)
from ipl_data.ipl_dataset
group by pom
having count(pom) > 10
order by count(pom) desc;

-- Finding high scoring venue
select 
season,venue_name, max(1st_inning_score), max(2nd_inning_score)
from ipl_data.ipl_dataset
group by season,venue_name
order by season, max(1st_inning_score) desc;

SELECT season,
       venue_name,
       MAX(CAST(SUBSTRING_INDEX(1st_inning_score, '/', 1) AS UNSIGNED)) AS First_inning_score,
       MAX(CAST(SUBSTRING_INDEX(2nd_inning_score, '/', 1) AS UNSIGNED)) AS Second_inning_score
FROM ipl_data.ipl_dataset
WHERE CAST(SUBSTRING_INDEX(1st_inning_score, '/', 1) AS UNSIGNED) > 200
GROUP BY season, venue_name
order by First_inning_score desc;

SELECT venue_name,
       COUNT(*) AS 200_plus_games
FROM ipl_data.ipl_dataset
WHERE CAST(SUBSTRING_INDEX(1st_inning_score, '/', 1) AS UNSIGNED) > 200
GROUP BY venue_name
order by 200_plus_games desc;

-- Team Decision by Venue
select venue_name,decision,
count(*) AS team_decision
from ipl_data.ipl_dataset
group by venue_name,decision;

-- Team Win count
select winner,count(winner) AS Matches_Won
from ipl_data.ipl_dataset
group by winner
order by Matches_Won desc;

-- Most away game winners
SELECT 
    DISTINCT team_name as Team_names, 
    COUNT(*) as away_wins 
FROM (
    SELECT 
        CASE 
            WHEN away_team = winner THEN away_team 
            ELSE home_team 
        END as team_name 
    FROM ipl_data.ipl_dataset
    WHERE away_team = winner
) AS Away_wins 
GROUP BY team_name 
ORDER BY away_wins DESC;

-- Most home game winners
SELECT 
    DISTINCT team_name as Team_names, 
    COUNT(*) as Home_wins 
FROM (
    SELECT 
        CASE 
            WHEN home_team = winner THEN home_team 
            ELSE away_team 
        END as team_name 
    FROM ipl_data.ipl_dataset
    WHERE home_team = winner
) AS Home_wins 
GROUP BY team_name 
ORDER BY Home_wins DESC;


-- Team win records by venue
SELECT DISTINCT 
    winner as Teams, 
    venue_name, 
    COUNT(winner) As Win_count
FROM 
    ipl_data.ipl_dataset
GROUP BY 
    venue_name, winner
HAVING 
    COUNT(winner) > 10
ORDER BY 
    Win_count DESC;

-- Season wise victory
select season, winner,
count(winner) AS Game_won
from ipl_data.ipl_dataset
group by season, winner
order by season desc;

SELECT 
    team_names,
    SUM(CASE WHEN year = 2008 THEN victories ELSE 0 END) as `2008`,
    SUM(CASE WHEN year = 2009 THEN victories ELSE 0 END) as `2009`,
    SUM(CASE WHEN year = 2010 THEN victories ELSE 0 END) as `2010`,
    SUM(CASE WHEN year = 2011 THEN victories ELSE 0 END) as `2011`,
    SUM(CASE WHEN year = 2012 THEN victories ELSE 0 END) as `2012`,
    SUM(CASE WHEN year = 2013 THEN victories ELSE 0 END) as `2013`,
    SUM(CASE WHEN year = 2014 THEN victories ELSE 0 END) as `2014`,
    SUM(CASE WHEN year = 2015 THEN victories ELSE 0 END) as `2015`,
    SUM(CASE WHEN year = 2016 THEN victories ELSE 0 END) as `2016`,
    SUM(CASE WHEN year = 2017 THEN victories ELSE 0 END) as `2017`,
    SUM(CASE WHEN year = 2018 THEN victories ELSE 0 END) as `2018`,
    SUM(CASE WHEN year = 2019 THEN victories ELSE 0 END) as `2019`,
    SUM(CASE WHEN year = 2020 THEN victories ELSE 0 END) as `2020`,
    SUM(CASE WHEN year = 2021 THEN victories ELSE 0 END) as `2021`,
    SUM(CASE WHEN year = 2022 THEN victories ELSE 0 END) as `2022`,
    SUM(CASE WHEN year = 2023 THEN victories ELSE 0 END) as `2023`
FROM (
    SELECT 
        winner AS team_names,
        YEAR(start_date) as year,
        COUNT(*) as victories
    FROM 
        ipl_data.ipl_dataset
    WHERE 
        winner = winner
        AND season BETWEEN 2008 AND 2023
    GROUP BY 
        team_names, year
) AS team_wins
GROUP BY 
    team_names
ORDER BY 
    team_names;
-- Umpiring pair
select umpire1,
count(umpire1) AS Umpiring_Experience,
umpire2,count(umpire2) AS Umpiring_Experience
from ipl_data.ipl_dataset
group by umpire1, umpire2
order by Umpiring_Experience desc;

-- Individual umpiring Experience
select distinct umpire1,
count(umpire1) AS Umpiring_Experience
from ipl_data.ipl_dataset
group by umpire1
order by Umpiring_Experience desc;

select distinct umpire2,
count(umpire2) AS Umpiring_Experience
from ipl_data.ipl_dataset
group by umpire2
order by Umpiring_Experience desc;




