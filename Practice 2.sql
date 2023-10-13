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
SELECT  user_id, (max(date(post_date))-min(date(post_date))) as number_days
FROM posts
where post_date < '2022/01/01' and post_date>= '2021/01/01'
group by user_id
having count(post_id) >= 2
-- Exercise 7
SELECT card_name, max(issued_amount)-min(issued_amount) as Difference
FROM monthly_cards_issued
group by card_name
order by Difference DESC
-- Exercise 8
SELECT manufacturer, count(drug) as count, abs(sum(total_sales - cogs)) as loss
FROM pharmacy_sales
where total_sales < cogs
group by manufacturer
order by loss desc
-- Exercise 9
select *
from cinema
where id%2=1 and description not like 'boring'
order by rating desc
-- Execise 10
select distinct teacher_id, count(distinct subject_id) as cnt
from teacher
group by teacher_id
-- Exercise 11
select user_id, count(follower_id) as followers_count
from Followers
group by user_id
order by user_id asc
--Excercise 12
select class
from courses
group by class
having count(student)>=5
