-- Exercise 1
select name
from students
where marks > 75
order by right(name,3) asc, id asc
-- Exercise 2
select user_id, concat(upper(left(name,1)),lower(substring(name from 2 for 9))) as name
from users
order by user_id
-- Exercise 3
SELECT 
  manufacturer,
  CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') AS sales
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer asc
-- Exercise 4
SELECT extract( month from submit_date) as mth, product_id,  round(avg(stars),2) 
FROM reviews
GROUP BY product_id, extract( month from submit_date)
ORDER BY extract( month from submit_date), product_id
-- Exercise 5
SELECT sender_id, COUNT(message_id)
FROM messages
where to_char(sent_date, 'mm/yyyy') like '08/2022'
GROUP BY sender_id
ORDER BY COUNT(message_id) desc
limit(2)
-- Exercise 6
select tweet_id
from tweets
where length(content) > 15
-- Exercise 7
select activity_date,user_id
from activity
where activity_date between'2019-06-27' and '2019-07-27'
group by user_id, activity_date
having count(activity_date) between'1' and '2'
-- Exercise 8
select count(id) 
from employees
where joining_date between'2021-12-31' and '2022-08-01'
-- Exercise 9
select position('a' in 'Amitah')
from worker
-- Exercise 10
select substring(title from position('2' in title) for 4) as Year, title
from winemag_p2
