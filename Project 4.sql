-- Exercise 1
SELECT
SUM(CASE
  when device_type = 'laptop' THEN 1
  else 0
END) as laptop_views,
sum(CASE
  when device_type in ('phone','tablet') then 1
  else 0
END) as moblie_views
FROM viewership
-- Exercise2
select x,y,z,
case
    when x+y>z and x+z>y and y+z>x and x>0 and y>0 and z>0 then 'Yes'
    else 'No'
end as triangle
from triangle
-- Exercise 3
SELECT
    ROUND(SUM(
    CASE 
      WHEN call_category IS NULL THEN 1 
      WHEN call_category = 'n/a' THEN 1
      ELSE 0
    END) * 100 / COUNT(call_received), 1) as call_percentage
FROM callers
-- Exercise 4
select name
from customer
where referee_id !=2 or referee_id is null
-- Exercise 5
SELECT
    survived,
sum(CASE 
    WHEN pclass = 1 THEN 1 
    ELSE 0 
END) AS first_class,
sum(CASE 
    WHEN pclass = 2 THEN 1 
    ELSE 0 
END) AS second_class,
sum(CASE 
    WHEN pclass = 3 THEN 1 
    ELSE 0 
END) AS third_class
FROM titanic
GROUP BY 
    survived



