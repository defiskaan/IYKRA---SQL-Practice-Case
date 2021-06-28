-- Name		: Defiska Andang Nugraha
-- Program	: Data Fellowship IYKRA Batch 6
-- Modul	: SQL

-- A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
select count(film_id) as num_review from film 
where description like '%Astronauts%';

-- I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
select count(title) as num_film from film 
where rating ='R'
and replacement_cost between 5 and 15;

/* We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments. 
   How many payments did each staff member handle? And how much was the total amount processed by each staff member? */
select staff_id, count(1) as num_payment, sum(amount) as total_amount from payment
group by staff_id
order by total_amount desc;

-- Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
select rating, avg(replacement_cost) as avg_repl_cost from film 
group by rating;

/* We want to send coupons to the 5 customers who have spent the most amount of money. 
   Get the customer name, email and their spent amount! */
select c.first_name, c.last_name, c.email, sum(p.amount) as spent_amount from customer c 
join payment p 
on c.customer_id = p.customer_id
group by c.first_name, c.last_name, c.email
order by spent_amount desc 
limit 5;

-- We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
select f.title, i.store_id, count(i.inventory_id) as film_stock from inventory i 
join film f 
on i.film_id = f.film_id
group by f.title, i.store_id
order by f.title, i.store_id;

/* We want to know what customers are eligible for our platinum credit card. 
   The requirements are that the customer has at least a total of 40 transaction payments. 
   Get the customer name, email who are eligible for the credit card!*/
select c.first_name, c.last_name, c.email, count(p.payment_id) as num_trans from payment p 
join customer c 
on p.customer_id = c.customer_id 
group by c.first_name, c.last_name, c.email
having count(p.payment_id) >= 40
order by count(p.payment_id) desc;
