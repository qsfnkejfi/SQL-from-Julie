-- Exercise 1
select name
from city
where population > 120000 and countrycode like 'USA'
-- Exercise 2
select *
from city
where countrycode like 'JPN'
-- Exercise 3
select city, state
from station
-- Exercise 4
select distinct city
from station
where city like 'e%' or city like 'a%' or city like 'i%' or city like 'o%' or city like 'u%'
-- Exercise 5
select distinct city
from station
where city like '%e' or city like '%a' or city like '%i' or city like '%o' or city like '%u'
-- Exercise 6
select distinct city
from station
where not (city like 'e%' or city like 'a%' or city like 'i%' or city like 'o%' or city like 'u%')
-- Exercise 7
select name
from Employee
order by name
-- Exercise 8

