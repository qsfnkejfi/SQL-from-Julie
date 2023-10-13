-- Exercise 1
select distinct city
from station
where ID%2=0
-- Exercise 2
select count(city)-count(distinct city) as diference
from station
-- Exercise 4
SELECT round(cast(sum(item_count*order_occurrences) / sum(order_occurrences) as decimal),1) as mean
FROM items_per_order
-- Exercise 5
SELECT DISTINCT candidate_id
FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
having count(skill)=3
-- Exercise 6

