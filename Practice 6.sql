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
