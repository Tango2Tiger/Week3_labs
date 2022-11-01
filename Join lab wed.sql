
#0 virker ikke men lol alligevel
select * from sakila.actor_info
	group by actor_id
    order by count("%:%") desc;
    
select len(film_info)-len(replace(film_info, ":", "")) as cheese from sakila.actor_info;


# 1
select first_name, last_name, count(actor_id) as antal from sakila.actor
join sakila.film_actor using(actor_id)
group by actor_id 
order by antal desc
limit 1
;

# 2
select first_name, last_name, count(customer_id) as num from sakila.rental
join sakila.customer using(customer_id)
group by customer_id 
order by num desc
limit 1;

# 3
select name, count(category_id) as num from sakila.category
join sakila.film_category using(category_id)
	group by category_id
    order by name asc;

# 4
select first_name, last_name, address from sakila.staff 
join sakila.address using (address_id)
where sakila.staff.address_id = sakila.address.address_id
;

# 5
select title, name from sakila.film
join sakila.language using(language_id)
where (name="English" or name="Italian") and title like "M%"
;

# 6
select first_name, last_name, sum(amount) from sakila.staff
join sakila.payment using(staff_id)
where payment_date > "2005-08-01 00:00:00" and payment_date < "2005-09-01 00:00:00"
group by staff_id;

# 7
select title, count(film_id) as num from sakila.film
join sakila.film_actor using(film_id)
group by title
order by num desc
;

# 8
select first_name, last_name, sum(amount) from sakila.payment
join sakila.customer using(customer_id)
group by customer_id
order by last_name;

# 9
select * from sakila.actor
left join sakila.film_actor using(actor_id)
where film_id is null;

# 10
select address from sakila.customer
right join sakila.address using(address_id)
where customer_id is null and address like "%e";


# optional 11
select title, count(film_id) as count from sakila.rental
join sakila.inventory using(inventory_id)
join sakila.film using(film_id)
group by film_id
order by count desc
limit 1;

