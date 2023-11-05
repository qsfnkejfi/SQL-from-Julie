--Exercise 1
with cte as(
select extract(year from created_at) as year, extract(month from created_at) as month,
count(user_id) as total_user, 
count(order_id) as total_order
from bigquery-public-data.thelook_ecommerce.orders
where created_at between '2020-01-01' and '2022-05-01'
group by 1,2
order by 1,2)

select year||'-' ||month as year_month, total_user,total_order
from cte
/*Số lượng người mua và số lượng đơn hàng tăng dần theo thời gian*/

--Exercise 2
with cte1 as(select
extract(year from created_at) as year, extract(month from created_at) as month,
count(distinct user_id) as distinct_user, 
count (order_id) as total_order,
sum(sale_price) as total_sale
from bigquery-public-data.thelook_ecommerce.order_items
where created_at between '2019-01-01' and '2022-05-01'
group by 1,2
order by 1,2)

select year||'-' ||month as year_month, distinct_user,
round(total_sale/total_order,2) as aov
from cte1
/*Giá trị đơn hàng trung bình tăng theo thời gian*/

--Exercise 3
begin
create temp table tmp_age as(
(with cte2 as(
select first_name, last_name, gender,age
from bigquery-public-data.thelook_ecommerce.users
where gender like'M' and created_at between '2019-01-01' and '2022-05-01'
group by 1,2,3,4
order by 4)

select first_name, last_name, gender, age,
(case
  when age = (select max(age) from bigquery-public-data.thelook_ecommerce.users) then 'oldest'
  when age = (select min(age) from bigquery-public-data.thelook_ecommerce.users) then 'youngest'
  else ''
end) as tag
from cte2)

union all

(with cte3 as(
select first_name, last_name, gender,age
from bigquery-public-data.thelook_ecommerce.users
where gender like'F' and created_at between '2019-01-01' and '2022-05-01'
group by 1,2,3,4
order by 4)

select first_name, last_name, gender, age,
(case
  when age = (select max(age) from bigquery-public-data.thelook_ecommerce.users) then 'oldest'
  when age = (select min(age) from bigquery-public-data.thelook_ecommerce.users) then 'youngest'
  else ''
end) as tag
from cte3));
end;

select count(age) as max_female
from stately-winter-404203._scriptd1e74b5baaacc891a4c47cea1e27362175776830.tmp_age
where age = (select max(age) from bigquery-public-data.thelook_ecommerce.users) and gender like'F'

select count(age) as min_female
from stately-winter-404203._scriptd1e74b5baaacc891a4c47cea1e27362175776830.tmp_age
where age = (select min(age) from bigquery-public-data.thelook_ecommerce.users) and gender like'F'

select count(age) as max_male
from stately-winter-404203._scriptd1e74b5baaacc891a4c47cea1e27362175776830.tmp_age
where age = (select max(age) from bigquery-public-data.thelook_ecommerce.users) and gender like'M'

select count(age) as min_male
from stately-winter-404203._scriptd1e74b5baaacc891a4c47cea1e27362175776830.tmp_age
where age = (select min(age) from bigquery-public-data.thelook_ecommerce.users) and gender like'M'

/* Nữ :có 568 người lớn tuổi nhất và 70 tuổi
       có 607 người nhỏ tuổi nhất và 12 tuổi
   Nam: có 554 người lớn tuổi nhất và 70 tuổi
        có 557 người nhỏ tuổi nhất và 12 tuổi*/
-- Exercise 4
with cte4 as(select
extract(year from b.created_at) as year, extract(month from b.created_at) as month,
a.id,a.name, a.retail_price, a.cost, retail_price - cost as profits,
from bigquery-public-data.thelook_ecommerce.products as a
join bigquery-public-data.thelook_ecommerce.order_items as b 
on a.id =b.id
group by 1,2,3,4,5,6
order by 1,2)

select year||'-'||month, id,name, retail_price, cost,profits,
dense_rank() over (partition by id, name  order by profits desc) as rank
from cte4
limit 5
-- Exercise 5
select date(created_at), product_category,  sum(product_retail_price) as revenue
from bigquery-public-data.thelook_ecommerce.inventory_items
where date(created_at) between '2022-01-15' and '2022-04-15'
group by 1,2
order by 1,2
      
