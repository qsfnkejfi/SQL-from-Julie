--Exercise 1
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
) AS job_count
WHERE job_count > 1;
--Exercise 2
SELECT category, product, total_spend 
FROM (SELECT category, product, SUM(spend) AS total_spend,
    RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking 
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product) AS ranked_spending
WHERE ranking <= 2 
ORDER BY category, ranking
-- Exercise 3
SELECT count(policy_holder_id)
from(
SELECT policy_holder_id, count(case_id) as call
FROM callers
group by policy_holder_id
having count(case_id)>=3) as call_count
--Exercise 4
SELECT a.page_id
FROM pages as a
where page_id not in(select page_id
from page_likes
where page_id is not null)
-- Exercise 5
with cte as 
(SELECT  user_id	
from user_actions 
where EXTRACT(month from event_date) in (6,7) 
and EXTRACT(year from event_date) = 2022 
GROUP BY user_id having count(DISTINCT EXTRACT(month from event_date)) = 2)
SELECT 7 as month_ , count(*) as number_of_user 
from cte
-- Exercise 6
select
    TO_CHAR(trans_date, 'yyyy-mm') as month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount
FROM transactions
GROUP BY country;
-- EXERCISE 7
select b.product_id, a.year as first_year, a.quantity, a.price
from Sales as a
inner join Product as b
on a.product_id=b.product_id
where a.year in  (select min(a.year) from Sales as a
where a.product_id=b.product_id)
--Exercise 8
  select customer_id 
from Customer
group by customer_id 
having count(distinct product_key) in (
  select count(distinct product_key)
  from Product 
)
--Exercise 9
select e.employee_id
from employees e
where e.salary < 30000 and e.manager_id not in(
select employee_id from employees
)
order by employee_id
-- Exercise 10
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
) AS job_count
WHERE job_count > 1;
-- Exercise 11
(SELECT name results
FROM `Users` a, `MovieRating` b
WHERE a.user_id = b.user_id
GROUP BY a.user_id
ORDER BY COUNT(b.user_id) DESC, name ASC LIMIT 1)
UNION ALL
(SELECT title results
FROM `Movies` c, `MovieRating` d
WHERE c.movie_id = d.movie_id AND created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY c.movie_id
ORDER BY AVG(rating) DESC, title ASC LIMIT 1)
--Exercise 12
select requester_id as id,
(select count(*) from RequestAccepted
where id=requester_id or id=accepter_id) as num
from RequestAccepted
group by requester_id
order by num desc 
limit 1
