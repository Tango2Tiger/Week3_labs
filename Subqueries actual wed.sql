
# 1 films longer than avg
select title from sakila.film
	where length >(
    select avg(length) from sakila.film);

# 2 copies of hunchback impossible in inventory
select count(film_id) from sakila.inventory
	join sakila.film using(film_id)
    where title = "Hunchback impossible"
    ;

# 3 all actors in alone trip
select first_name, last_name 
	from sakila.film_actor
	join sakila.film using(film_id)
    join sakila.actor using(actor_id)
	where film_id in (
		select film_id
		from sakila.film_actor
		join sakila.actor using(actor_id)
		where title = "alone trip"
    );
    
select first_name, last_name from sakila.actor
	where actor_id in (
		select actor_id from sakila.film_actor
		where film_id in (
			select film_id from sakila.film
			where title = "alone trip"
			)
    );    
    
    
select * from sakila.film_actor;    

# 4 films categorized as family films WITH JOINING - NOT THE EXERCISE
select title from sakila.film
	join sakila.film_category using (film_id)
    join sakila.category using (category_id)
    where category_id in (
    select category_id from sakila.film_category
    join sakila.category using(category_id)
    where name = "Family"
    );

# 4 again without joining
select title from sakila.film
	where film_id in (
	select film_id from sakila.film_category
		where category_id in (
			select category_id from sakila.category
			where name="Family"
			group by category_id
	)
);


# 5 with subqueries
select first_name, last_name, email from sakila.customer
where address_id in (
	select address_id from sakila.address
    where city_id in (
		select city_id from sakila.city
        where country_id in (
			select country_id from sakila.country
            where country = "Canada"
            )
		)
    );

# 5 with joins
select first_name, last_name, email from sakila.customer
	join sakila.address using(address_id)
    join sakila.city using(city_id)
    join sakila.country using(country_id)
    where country="Canada";

#OPTIONAL FROM HERE
# 6 which films is acted by the most prolific actor
select title from sakila.film
where film_id in (
select film_id from sakila.film_actor
	where actor_id = (
		select actor_id from sakila.film_actor
		group by actor_id
    order by count(film_id) desc
    limit 1
    ));

# 7
select distinct title from sakila.film 
join sakila.inventory using(film_id)
	where inventory_id in (
	select inventory_id from sakila.rental
		where customer_id = (
			select customer_id from sakila.payment
			group by customer_id
			order by sum(amount) desc
			limit 1
    ));

# 8 customers with more than avg payment
select first_name, last_name from sakila.customer
	where customer_id in (
	select distinct customer_id from sakila.payment
		where (select customer_id, sum(amount) from sakila.payment
        group by customer_id
        having sum(amount) > (
        select customer_id, avg(amount) from sakila.payment
        where avg(amount) > sum(amount)
        group by customer_id
        
        ))
        
        
        
        );
        
        
        
        
        > 
        (select avg(amount) from sakila.payment)
        
    )
order by first_name asc    
    
;    



select customer_id from sakila.payment
		where (select sum(amount) from sakila.payment
        ) > (
        select avg(amount) from sakila.payment)
;

select first_name, last_name from sakila.customer
order by first_name asc;


select * from sakila.customer;
select * from sakila.rental;
select * from sakila.payment;




