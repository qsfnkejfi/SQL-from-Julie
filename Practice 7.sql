-- Exercise 1
WITH cte AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,product_id,spend AS current_spend,
    LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id, EXTRACT(YEAR FROM transaction_date)) AS previous_spend 
  FROM user_transactions
)
SELECT year,product_id, current_spend, previous_spend, 
  ROUND(100 * (current_spend - previous_spend)/ previous_spend,2) AS yoy_rate 
FROM cte;
--Exercise 2
WITH rank_cards AS
(SELECT card_name, issued_amount,
  RANK() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS ranker
FROM monthly_cards_issued)

SELECT card_name,issued_amount
FROM rank_cards
WHERE ranker = 1
ORDER BY issued_amount DESC;
-- Exercise 3
SELECT user_id,spend,transaction_date
FROM (
  SELECT user_id, spend, transaction_date, 
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS row_num
  FROM transactions) AS so_hang 
WHERE row_num = 3;
-- Exercise 4
SELECT transaction_date,user_id,COUNT(transaction_date) as count_purchase
FROM(SELECT *,
    RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC)
    FROM user_transactions
    ORDER BY user_id,transaction_date DESC) a
WHERE rank = 1
GROUP BY user_id,transaction_date
ORDER BY transaction_date
-- Exercise 5
SELECT user_id,tweet_date,   
  ROUND(AVG(tweet_count) OVER (PARTITION BY user_id ORDER BY tweet_date     
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS roll_avg
FROM tweets;
--Exercise 6
WITH CTE AS (
  SELECT merchant_id,credit_card_id,amount,
    EXTRACT(MINUTE FROM transaction_timestamp - 
    FIRST_VALUE(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount
      ORDER BY transaction_timestamp)) AS time_gap
  FROM transactions
)

SELECT COUNT(DISTINCT merchant_id) AS payment_count
FROM cte
WHERE time_gap<=10
-- Exercise 7
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
-- Exercise 8
select artist_name,artist_rank 
from 
(SELECT a.artist_name,
dense_rank() over(order by count(c.song_id) desc) artist_rank FROM artists a 
inner join songs b
on a.artist_id=b.artist_id
JOIN global_song_rank c 
on c.song_id=b.song_id
and c.rank<=10 group by a.artist_name)x where artist_rank<6 ;
