--Exercise 1
SELECT TO_TIMESTAMP(orderdate, 'MM/DD/YYYY HH24:MI') AS timestamp
from sales_dataset_rfm_prj 

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN status TYPE varchar USING (trim(status)::varchar);
ALTER COLUMN contactfullname TYPE varchar USING (trim(contactfullname)::varchar);
ALTER COLUMN quantityordered TYPE numeric USING (trim(quantityordered)::numeric);
ALTER COLUMN sales TYPE numeric USING (trim(sales)::numeric);
ALTER COLUMN status TYPE varchar USING (trim(status)::varchar);
ALTER COLUMN productline TYPE varchar USING (trim(productline)::varchar);
ALTER COLUMN priceeach TYPE numeric USING (trim(priceeach)::numeric);UMN priceeach TYPE numeric USING (trim(priceeach)::numeric);
ALTER COLUMN ordernumber TYPE numeric USING (trim(ordernumber)::numeric);
ALTER COLUMN sales TYPE numeric USING (trim(sales)::numeric);
ALTER COLUMN phone TYPE varchar USING (trim(phone)::varchar);
ALTER COLUMN postalcode TYPE varchar USING (trim(postalcode)::varchar);
ALTER COLUMN dealsize TYPE text USING (trim(dealsize)::text);
ALTER COLUMN status TYPE varchar USING (trim(status)::varchar);
ALTER COLUMN productline TYPE varchar USING (trim(productline)::varchar);
ALTER COLUMN customername TYPE varchar USING (trim(customername)::varchar);
ALTER COLUMN ordernumber TYPE int USING (trim(ordernumber)::int);

--Exercise 2
select *
from public.sales_dataset_rfm_prj
where ORDERNUMBER is null or QUANTITYORDERED is null or PRICEEACH is null or ORDERLINENUMBER is null or SALES is null or ORDERDATE is null
--Exercise 3
alter table sales_dataset_rfm_prj
add column contactlastname varchar(50)
alter table sales_dataset_rfm_prj
add column contactfirstname varchar(50)

insert into sales_dataset_rfm_prj(contactfirstname)
select initcap(left(contactfullname,position('-' in contactfullname)-1))
from sales_dataset_rfm_prj

INSERT INTO sales_dataset_rfm_prj(contactlastname) 
SELECT initcap(substring(contactfullname, position('-'in contactfullname)+1,length(contactfullname)))
FROM sales_dataset_rfm_prj
--Exercise 4
alter table sales_dataset_rfm_prj
add column QTR_ID numeric
alter table sales_dataset_rfm_prj
add column MONTH_ID numeric
alter table sales_dataset_rfm_prj
add column YEAR_ID numeric

insert into sales_dataset_rfm_prj(month_id)
select extract(month from new_orderdate)
from sales_dataset_rfm_prj

insert into sales_dataset_rfm_prj(year_id)
select extract(year from new_orderdate)
from sales_dataset_rfm_prj

insert into sales_dataset_rfm_prj(qtr_id)
select case
	when extract(month from new_orderdate) in(1,2,3) then 1
	when extract(month from new_orderdate) in(4,5,6) then 2
	when extract(month from new_orderdate) in(7,8,9) then 3
	else 4
end as quy
from sales_dataset_rfm_prj
--Exercise 5
--Cach 1
with cte as(
	select Q1-1.5*IQR as min_value,
			Q3+1.5*IQR as max_value
from(
select
percentile_cont(0.25) within group (order by quantityordered) as Q1,
percentile_cont(0.75) within group (order by quantityordered) as Q3,
percentile_cont(0.75) within group (order by quantityordered) - percentile_cont(0.25) within group (order by quantityordered) as IQR
from sales_dataset_rfm_prj) as a)
select * from sales_dataset_rfm_prj
where quantityordered < (select min_value from cte) or quantityordered>(select max_value from cte)
--Cach 2
with cte as(
select *,(select avg(quantityordered) from sales_dataset_rfm_prj) as avg,
(select stddev(quantityordered) from sales_dataset_rfm_prj) as stddev
from sales_dataset_rfm_prj)
select (quantityordered - avg)/stddev as z_score
from cte
where abs((quantityordered - avg)/stddev) >3
--Exercise 6:
alter table sales_dataset_rfm_prj
rename to SALES_DATASET_RFM_PRJ_CLEAN
