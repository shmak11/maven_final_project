Use mavenmovies;
-- Q1
Select * from address;      -- manager_names_for_each_store, full address(strret, district, city country)
Select * from store;
Select * from staff;
/*Select first_name, last_name, staff.store_id, address, district, postal_code, address2,  manager_staff_id as manager_id from staff 
JOIN address on address.address_id= staff.address_id 
join store on  address.address_id= store.address_id*/
Select manager_staff_id, staff.store_id, first_name, last_name, address, country.country, city, district, postal_code from store 
join staff on store.manager_staff_id= staff.staff_id
join address on staff.address_id= address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;
-- Q2 

-- inventory_list, store_id, inventory_id, film_name, rating, rental_RATE, REPLACEMENT_cost
Select * from inventory;
Select * from film;
Select  store_id, 
inventory_id, 
title, 
rental_rate, 
replacement_cost, 
rating from inventory 
join film on inventory.film_id = film.film_id;
-- Q3 
Use mavenmovies;
Select inventory.store_id,
film.rating,
count(inventory_id) as inventory_items from inventory
join film on inventory.film_id = film.film_id 
group by inventory.store_id,
film.rating;
-- Q4
Select
store_id,
category.name as category,
count(inventory_id) as no_of_films,
avg (replacement_cost) as avg_r_cost,
sum(replacement_cost) as total_r_cost
from inventory 
left join film on inventory.film_id = film.film_id
left join film_category on film.film_id= film_category.film_id
left join category on category.category_id = film_category.category_id
group by 
store_id, 
category.name 
order by sum(replacement_cost) desc;

-- Q5
Select 
first_name, last_name, store_id, active, address, district,city, country from 
customer left join address on customer.address_id= address.address_id
left join city on address.city_id = city.city_id
left join country on city.country_id = country.country_id
order by active;

-- Q6 

/*spending time of customer with us, 
valuable customer, 
total rental 
sum of all payments
total life time value  and valuable customer on the top of the lisr */
Select first_name, last_name, 
count(rental.rental_id) as total_rental,
sum(payment.amount) as total_payment
from customer
left join rental on customer.customer_id = rental.customer_id
left join payment on rental.rental_id = payment.rental_id

group by first_name, last_name
order by sum(payment.amount) desc;

-- Q7
Select 'investor' as type, first_name, last_name, company_name from investor
union 
Select 'advisor' as type, first_name, last_name, 'n/a' from advisor;

-- Q8
Select * from actor_award;
Select 
Case 
when actor_award.awards =  'Emmy,Oscar,Tony' then '3 awards'
when actor_award.awards in ('Emmy, Oscar','Oscar, Tony', 'Emmy, Tony') then '2 awards'
else '1 award'
end as no_of_awards,
avg(Case 
when actor_award.actor_id is null then 0 else 1 end) as pct_w_once_film
from actor_award 
group by 
Case 
when actor_award.awards =  'Emmy,Oscar,Tony' then '3 awards'
when actor_award.awards in ('Emmy, Oscar','Oscar, Tony', 'Emmy, Tony') then '2 awards'
else '1 award'
end;
Select awards from actor_award  
where awards = 'Emmy, Oscar, Tony'
group by awards;
/* alternate
SELECT 
  CASE 
    WHEN REPLACE(actor_award.awards, ' ', '') = 'Emmy,Oscar,Tony' THEN '3 awards'
    WHEN REPLACE(actor_award.awards, ' ', '') IN ('Emmy,Oscar', 'Oscar,Tony', 'Emmy,Tony') THEN '2 awards'
    ELSE '1 award'
  END AS no_of_awards,
  AVG(CASE 
    WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 
  END) AS pct_w_once_film
FROM actor_award 
GROUP BY 
  CASE 
    WHEN REPLACE(actor_award.awards, ' ', '') = 'Emmy,Oscar,Tony' THEN '3 awards'
    WHEN REPLACE(actor_award.awards, ' ', '') IN ('Emmy,Oscar', 'Oscar,Tony', 'Emmy,Tony') THEN '2 awards'
    ELSE '1 award'
  END; */