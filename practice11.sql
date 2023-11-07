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
