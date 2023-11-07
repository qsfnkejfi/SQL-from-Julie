-- Exercise 1
create view vw_ecommerce_analyst as(
with cte as 
(select Extract(year from created_at) as year, Extract(month from created_at) as month, 
a.category as category,
count(b.order_id) as TPO,
sum(b.sale_price) as TPV,
sum(a.cost) as total_cost,
sum(b.sale_price)-sum(a.cost) as total_profit,
from bigquery-public-data.thelook_ecommerce.products as a 
join bigquery-public-data.thelook_ecommerce.order_items as b on a.id=b.id
group by 1,2,3
order by 1,2,3)

select *,
round((100.00*(next_revenue-TPV)/TPV),2) as revenue_growth,
round((100.00*(next_order-TPO)/TPO),2) as order_growth,
from(
select year,month,
category,
TPO,
TPV,
lead(TPV) over(partition by category order by year,month ) as next_revenue,
lead(TPO) over(partition by category order by year,month ) as next_order,
round(total_profit/total_cost,2) as profit_to_cost_ratio
from cte)
)

--Exercise 2:
with cte2 as(
select product_id, 
product_retail_price,
extract(year from created_at) ||'-' || extract(month from created_at) as cohort_date,
created_at,
(extract(year from created_at)-extract(year from first_purchase_date))*12
+ extract(month from created_at)-extract(month from first_purchase_date) +1 as index

from(
select product_id,
product_retail_price,
min(created_at) over (partition by product_id) as first_purchase_date,
created_at
from bigquery-public-data.thelook_ecommerce.inventory_items)
order by extract(year from created_at), extract(month from created_at)
)
,cte3 as(
select cohort_date,
index,
count(distinct product_id) as cnt,
sum(product_retail_price) as revenue
from cte2
group by 1,2
)

, product_cohort as(
select cohort_date,
sum(case when index =1 then cnt else 0 end) as m1,
sum(case when index =2 then cnt else 0 end) as m2,
sum(case when index =3 then cnt else 0 end) as m3,
sum(case when index =4 then cnt else 0 end) as m4,
from cte3
group by 1
order by 1
)

select cohort_date,
round(100.00* m1/nullif(m1,0) ,2) as m1,
round(100.00* m2/nullif(m1,0) ,2) as m2,
round(100.00* m3/nullif(m1,0) ,2) as m3,
round(100.00* m4/nullif(m1,0) ,2) as m4
from product_cohort
