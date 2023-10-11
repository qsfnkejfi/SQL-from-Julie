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
select name
from employee
where salary > 2000 and months <10
order by employee_id asc
-- Exercise 9
select product_id
from Products
where low_fats like 'Y' and recyclable like'Y'
-- Exercise 10
select name
from customer
where referee_id !=2 or referee_id is null
-- Exercise 11
select name, population, area
from world
where area >= 3000000 or population >= 25000000
-- Exercise 12
select distinct author_id as id
from Views
where article_id >1
order by author_id asc
-- Exercise 13
SELECT part, assembly_step
FROM parts_assembly
where finish_date is null
-- Exercise 14
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary>70000
-- Exercise 15
select * from uber_advertising
where money_spent > 100000
