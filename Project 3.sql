
--Exercise 1:
select year_id, productline, dealsize, sum(sales) 
from sales_dataset_rfm_prj_clean
group by year_id, productline, dealsize
order by year_id

--Exercise 2
select month_id, sum(sales), count(ordernumber)
from sales_dataset_rfm_prj_clean
group by month_id
order by sum(sales) desc, count(ordernumber) desc
limit 1

--Exercise 3
select productline, count(ordernumber)
from sales_dataset_rfm_prj_clean
where month_id = 11
group by productline
order by count(ordernumber) desc

-- Exercise 4
with cte as(
select year_id, productline, sum(sales) as revenue
from sales_dataset_rfm_prj_clean
group by year_id, productline)

select year_id, productline, revenue,
rank() over (partition by year_id, productline order by revenue desc)
from cte

-- Exercise 5
with cte as(
select customername,
current_date - max(new_orderdate) as R,
count(distinct ordernumber) as F,
sum(sales) as M
from sales_dataset_rfm_prj_clean
group by customername)

,cte2 as(
select customername,
ntile(5) over(order by R desc) as R_score,
ntile(5) over(order by F desc) as F_score,
ntile(5) over(order by M desc) as M_score
from cte)

, cte3 as(
select customername,
cast (r_score as varchar)||cast (f_score as varchar) || cast(m_score as varchar) as rfm_score
from cte2)

select a.customername, b.segment 
from cte3 as a
join segment_score as b 
on a.rfm_score =b.scores
order by customername
