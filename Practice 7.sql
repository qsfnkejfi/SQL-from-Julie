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
