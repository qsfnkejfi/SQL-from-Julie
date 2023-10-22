-- Exercise 1
select min(replacement_cost)
from film
-- Exercise 2
select
case
	when replacement_cost between 9.99 and 19.99 then 1
	else 0
end as low,
count(*)
from film
group by low
-- Exercise 3
select a.title, a.length, c.name
from film as a
join film_category as b
on a.film_id=b.film_id
join category as c
on b.category_id=c.category_id
where c.name in('Drama','Sports')
order by a.length desc
-- Exercise 4
from film as a
join film_category as b
on a.film_id=b.film_id
join category as c
on b.category_id=c.category_id
-- Exercise 5
select c.first_name ||' '|| c.last_name, count(a.film_id)
from film as a
join film_actor as b
on a.film_id=b.film_id
join actor as c
on b.actor_id=c.actor_id
group by c.first_name ||' '|| c.last_name
order by count(a.film_id) desc
-- Exercise 6
select a.address, a.address2
from address as a
left join customer as b
on a.address_id=b.address_id and b.address_id is null
-- Exercise 7
select a.city, sum(d.amount)
from city as a
join address as b
on a.city_id=b.city_id
join customer as c
on b.address_id=c.address_id
join payment as d
on c.customer_id=d.customer_id
group by a.city
order by sum(d.amount) desc
-- Exercise 8
select concat(a.city,', ',o.country) as thanh_pho, sum(d.amount)
from country as o
join city as a
on o.country_id=a.country_id
join address as b
on a.city_id=b.city_id
join customer as c
on b.address_id=c.address_id
join payment as d
on c.customer_id=d.customer_id
group by concat(a.city,', ',o.country)
order by sum(d.amount) asc
