select * from fifa21
#to get the total no of players
select count(id) from fifa21;
#to get the no of players per continent
select continents, count(id) as No_of_Players from fifa21
group by continents;
#to get the players with the highest release clause
select longname,`RELEASE CLAUSE` from fifa21
order by 2 desc
limit 10
#best defending playyers
select longname,def from fifa21
order by 2 desc
limit 10
#continents with the best defending ability
select continents, avg(def) from fifa21
group by 1
order by 2 desc
#to get the fastest players 
select longname,pac from fifa21
order by 2 desc
limit 10
#defensive midfielders with the highest interceptions
select longname,Interceptions from fifa21
where `best position` like '%dm%'
order by 2 desc
limit 10
#most versatile players
select longname, merged, `no of positions` from fifa21
where `best position` like '%dm%'
order by 3 desc
limit 10
select longname,`POT` from fifa21
#To get the tallest players
select longname, Club, `Height(cm)`from fifa21
order by 3 desc
limit 10
#to get players with long passing range
select longname, Club, `long passing`from fifa21
order by 3 desc
limit 10
#to get the players with the highest duration of contract
select longname, Club, `duration of contract`from fifa21
order by 3 desc
limit 10