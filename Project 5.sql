-- Exercise 2
SELECT ROUND(COUNT(b.email_id)::DECIMAL/COUNT(DISTINCT a.email_id),2) AS activation_rate
FROM emails as a
LEFT JOIN texts as b
ON a.email_id = b.email_id
AND b.signup_action = 'Confirmed'
-- Exercise 1
select b.continent, floor(avg(a.population))
from city as a
inner join country as b
on a.countrycode= b.code
group by b.continent
-- Exercise 3
SELECT b.age_bucket,
      round(100.0*(select sum(a.time_spent) from activities as a where a.activity_type='send')/sum(a.time_spent),2) as send_perc,
      round(100.0*(select sum(a.time_spent) from activities as a where a.activity_type='open')/sum(a.time_spent),2) as open_perc
FROM activities as a
left join age_breakdown as b 
on a.user_id = b.user_id
where a.activity_type in('send', 'open')
group by b.age_bucket
-- Exercise 4
SELECT a.customer_id 
from customer_contracts as a 
LEFT JOIN products as b  
on a.product_id = b.product_id
group by a.customer_id
having count(distinct(b.product_category)) = (select count(distinct(product_category)) from products)
-- Exercise 5
select b.employee_id, b.name, count(a.reports_to) as reports_count, round(avg(a.age)) as average_age
from employees as a
join employees as b
on a.reports_to=b.employee_id
group by b.employee_id, b.name
having count(a.reports_to)>=1
order by employee_id
-- Exercise 6
