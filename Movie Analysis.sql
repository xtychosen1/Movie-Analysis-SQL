/*
                                Movie Analysis
                                by Allen Xu




 */
########################################################################################################################
#                                    Exercise 1

# 1.Before doing any exercise, you should explore the data first.
    # -For Exercise 1, we will focus on the product, which is the film (DVD) in this project.
    # -Please explore the product-related tables (actor, film_actor, film, language, film_category, category) by using SELECT * – Do not forget to limit the number of records


use sakila;
select * from actor limit 10;
select * from film_actor limit 10;
select * from film limit 10;
select * from language limit 10;
select * from film_category limit 10;
select * from category limit 10;
## Use table FILM to solve the questions below:
# 2.What is the largest `rental_rate` for each rating?

select rating, max(rental_rate) as max_rental_rate
from film
group by 1;     -- Answer largest rental_rate for each rating are both 4.99


# 3.How many films are in each rating category?

Select rating, count(distinct film_id) as film_number
from film
group by 1;

-- Answer
--    rating     film_number
      G,          178
      PG,         194
      PG-13,      223
      R,          195
      NC-17,      210


# 4.Create a new column `film_length` to segment different films by length:
# `length < 60 then ‘short’; length < 120 then standard’; length >=120 then ‘long’, then count the number of films in each segment.`
select film_id,title,
       case when length < 60 then 'short'
            when length < 120 then 'standard'
            when length >=120 then 'long'
           end as film_length
from film;

-- Answer
-- film_id       title               film_length
   1,         ACADEMY DINOSAUR,       standard
   2,         ACE GOLDFINGER,         short
   3,         ADAPTATION HOLES,       short
   4,         AFFAIR PREJUDICE,       standard
   5,         AFRICAN EGG,             long
...             ...                   ...;





## Use table ACTOR to solve questions as below:
# 5.Which actors have the last name ‘Johansson’?
select actor_id,last_name,first_name
from actor
where last_name = 'johansson';

-- Answer
-- we have 3 actors hve the last name ‘Johansson’,they are
    -- JOHANSSON,MATTHEW
    -- JOHANSSON,RAY
    -- JOHANSSON,ALBERT



# 6.How many distinct actors’ last names are there?
select count(distinct last_name)
from actor;     -- Answer 121 distinct actors’ last names are there


# 7.Which last names are not repeated? Hint: use COUNT() and GROUP BY and HAVING

select last_name,count(*) as name_num
from actor
group by 1
having name_num =1 ;

-- Answer
ASTAIRE
BACALL
BALE
BALL
BARRYMORE
...;


# 8.Which last names appear more than once?
select last_name,count(*) as name_num
from actor
group by 1
having name_num >1 ;

-- Answer

AKROYD
ALLEN
BAILEY
BENING
BERRY
 ...;


## Use table FILM_ACTOR to solve questions as below:
# 9.Count the number of actors in each film, order the result by the number of actors in descending order

select film_id , count(actor_id) as actor_number
from film_actor
group by 1
order by 2 desc;

-- Answer
--      film_id    actor_number
          508,        15
          87,         13
          714,        13
          146,        13
          188,        13
          ...        ...;



# 10.How many films do each actor play in?

select actor_id , count(film_id) as film_number
from film_actor
group by 1;
-- Answer
--      actor_id    film_number
           1,            19
           2,            25
           3,            22
           4,            22
           5,            29
        ...             ...;



########################################################################################################################
#                        Exercise 2 :

# 1.Before doing any exercise, you should explore the data first.
    # -For Exercise 1, we will focus on the product, which is the film (DVD) in this project.
    # -Please explore the product-related tables (`actor, film_actor, film, language, film_category, category`) by using `SELECT *`
    # –Do not forget to limit the number of records;

select * from actor limit 10;
select * from film_actor limit 10;
select * from film limit 10;
select * from language limit 10;
select * from film_category limit 10;
select * from category limit 10;
# 2.Find language name for each film by using table Film and Language;

Select title , name as languagename
from film
join language
using(language_id);

-- Answer
--    title            languagename
      ACADEMY DINOSAUR,  English
      ACE GOLDFINGER,    English
      ADAPTATION HOLES,  English
      AFFAIR PREJUDICE,  English
      AFRICAN EGG,       English
          ...             ...;



# 3.In table `Film_actor`, there are `actor_id` and `film_id` columns. I want to know the actor name for each `actor_id`, and the film tile for each `film_id`.
# Hint: Use multiple table Inner Join
select film_actor.actor_id,last_name,first_name,film_actor.film_id,title
from film_actor
join film f on f.film_id = film_actor.film_id
join actor a on a.actor_id = film_actor.actor_id
order by 1;

-- Answer
--  actor_id        Last_name       first_name         film_id         title
       1,            GUINESS,        PENELOPE,          1,         ACADEMY DINOSAUR
       1,            GUINESS,        PENELOPE,          23,        ANACONDA CONFESSIONS
       1,            GUINESS,        PENELOPE,          25,        ANGELS LIFE
       1,            GUINESS,        PENELOPE,          106,       BULWORTH COMMANDMENTS
       1,            GUINESS,        PENELOPE,          140,       CHEAPER CLYDE
    ...              ...              ...               ...               ...;




# 4.In table Film, there is no category information. I want to know which category each film belongs to.
# Hint: use table `film_category` to find the category id for each film and then use table category to get the category name
select film_id,title,name as categoryname
from(
    select film_id,film_category.category_id,name
    from film_category
    join category c
        on c.category_id = film_category.category_id
    order by 1
    ) as sub
join film
using (film_id);


-- Answer
--   film_id            title               categoryname
        19,           AMADEUS HOLY,           Action
        21,           AMERICAN CIRCUS,        Action
        29,           ANTITRUST TOMATOES,     Action
        38,           ARK RIDGEMONT,          Action
        56,           BAREFOOT MANCHURIAN,    Action
        ...          ...                       ...;




# 5.Select films with `rental_rate` > 2 and then combine the results with films with ratings G, PG-13, or PG.
select title,rental_rate,rating
from film
where rental_rate >2
and rating in ('G','PG-13','PG');

-- Answer
--    title                 rental_rate               rating
   ACE GOLDFINGER,           4.99,                      G
   AFFAIR PREJUDICE,         2.99,                      G
   AFRICAN EGG,              2.99,                      G
   AGENT TRUMAN,             2.99,                      PG
   AIRPLANE SIERRA,          4.99,                      PG-13
   ...                       ...                        ...;


########################################################################################################################
#                                    Exercise 3:



# 1.How many rentals (basically, the sales volume) happened from 2005-05 to 2005-08? Hint: use date between '2005-05-01' and '2005-08-31';

select count(distinct rental_id) as rental_volume
from rental
where rental_date between '2005-05-01' and '2005-08-31'; -- Answer 15862 rentals happened from 2005-05 to 2005-08




# 2.I want to see the rental volume by month. Hint: you need to use the substring function to create a month column, e.g.

select substr(rental_date,1,7)as month,count(distinct rental_id) as  rental_volume
from rental
group by 1
order by 1;

-- Answer
-- month     rental_volume
   2005-05,     1156
   2005-06,     2311
   2005-07,     6709
   2005-08,     5686
   2006-02,     182
       ...      ...;



# 3.Rank the staff by total rental volumes for all time periods. I need the staff’s names, so you have to join with the staff table
select  staff_id,first_name,last_name,rentail_volumes
from(
     select staff_id,count(rental_id)as rentail_volumes
     from rental
     group by 1
     order by 2 desc) as sub
join staff
using (staff_id);

-- Answer
--  steff_id       firstname        lastname          rentail_volumes
     1,            Mike,            Hillyer,             8040
     2,            Jon,             Stephens,            8004


## How about inventory?
# 4.Create the current inventory level report for each film in each store.
    # -The inventory table has the inventory information for each film at each store
    # - `inventory_id` - A surrogate primary key used to uniquely identify each item in inventory, so each inventory id means each available film.

select * from inventory;

select film_id,store_id,count(inventory_id) as inventory_level
from inventory
group by 1,2
order by 3 desc;


-- Answer
--  film_id          store_id         inventory_level
     1,                1,                   4
     4,                1,                   4
     10,               1,                   4
     11,               1,                   4
     19,               1,                   4
    ...                  ...                  ...;






# 5.When you show the inventory level to your manager, your manager definitely wants to know the film's name. Please add the film's name to the inventory report.
    # -Tile column in film table is the film name
    # -Should you use left join or inner join? – this depends on how you want to present your result to your manager, so there is no right or wrong answer
    # -Which table should be your base table if you want to use left join?

select film_id,store_id,count(inventory_id) as inventory_level,title as film_name
from inventory
left join  film
using(film_id)
group by 1,2
order by 3 desc;

-- Answer
--  film_id    store_id    inventory_level    film_name
        1,        1,          4,          ACADEMY DINOSAUR
        1,        2,          4,          ACADEMY DINOSAUR
        2,        2,          4,          ACE GOLDFINGER
        3,        2,          4,          ADAPTATION HOLES
        4,        1,          4,          AFFAIR PREJUDICE
    ...       ...               ...               ...;

-- if use left join, use inventory level as base table




# 6.After you show the inventory level again to your manager, your manager still wants to know the category for each film. Please add the category for the inventory report.
    # -Name column in the category table is the category name
    # -You need to join film, category, inventory, and `film_category

select film_id,store_id,title as film_name,name as filmcategory,count(inventory_id) as inventory_level
from inventory
left join film using(film_id)
left join film_category using(film_id)
left join category using(category_id)
group  by 1,2,4
order by 5 desc;

-- Answer
--   film_id    store_id        film_name               filmcategoty      inventory_level
        1,        1,           ACADEMY DINOSAUR             Documentary             4
        1,        2,           ACADEMY DINOSAUR             Documentary             4
        3,        2,           ADAPTATION HOLES             Documentary             4
        4,        1,           AFFAIR PREJUDICE             Horror                  4
        8,        2,           AIRPORT POLLOCK              Horror                  4
        ...      ...           ...                  ...              ...;





# 7.Your manager is happy now, but you need to save the query result to a table, just in case your manager wants to check again, and you may need the table to do some analysis in the future.
    # Use the `CREATE` statement to create a table called `inventory_rep`

drop table if exists inventory_rep;
create table inventory_rep
    (select film_id, store_id, title as film_name, name as filmcategory, count(inventory_id) as inventory_level
     from inventory
              left join film using (film_id)
              left join film_category using (film_id)
              left join category using (category_id)
     group by 1, 2, 4
     order by 5 desc

);
select * from inventory_rep;


# 8.Use your report to identify the film which is not available in any store, and the next step will be to notice the supply chain team add the film to the store

select * from inventory_rep
where inventory_level = 0;

-- Answer  no movie



## Let’s look at Revenue:
    # -The payment table records each payment made by a customer, with information such as the amount and the rental paid for. Let us consider the payment amount as revenue and ignore the receivable revenue part
    # -`rental_id`: The rental that the payment is being applied. This is optional because some payments are for outstanding fees and may not be directly related to a rental – which means it can be null;

# 9.How much revenue was made from 2005-05 to 2005-08 by month?

select year(payment_date)as year,month(payment_date) as month,sum(amount)as revenue
from payment
where substr(payment_date,1,7) between '2005-05' and '2005-08'
group by 1,2;

-- Answer
--   year    month     revenue
     2005,     5,      4824.43
     2005,     6,      9631.88
     2005,     7,      28373.89
     2005,     8,      24072.13



# 10.How much revenue was made from 2005-05 to 2005-08 by each store?
select store_id,year(payment_date)as year,month(payment_date) as month,sum(amount)as revenue
from payment
join customer using (customer_id)
where substr(payment_date,1,7) between '2005-05' and '2005-08'
group by 1,2,3
order by 1,2,3;

-- Answer
--   store_id     year      month     revenue
         1,       2005,       5,      2694.62
         1,       2005,       6,      5148.57
         1,       2005,       7,      15739.22
         1,       2005,       8,      13136.09
         2,       2005,       5,      2129.81




# 11.Say the movie rental store wants to offer unpopular movies for sale to free up shelf space for newer ones. Help the store to identify unpopular movies by counting the number of rental times for each film. Provide the film id, film name, and category name so the store can also know which categories are not popular.
    # Hint: count how many times each film was checked out and rank the result by ascending order.


-- step1 find rental times for each film_id
select film_id,count(rental_id) as rentaltime
from rental
join inventory using (inventory_id)
group by 1
order by 2;

-- find solution by join table above into film, film_category and category table to get film name, and category name
select film_id ,title as filmname, name as filmcategory,rentaltime
from (select film_id, count(rental_id) as rentaltime
      from rental
               join inventory using (inventory_id)
      group by 1
      order by 2)as sub
join film using (film_id)
join film_category using(film_id)
join category using(category_id)
order by 4;

-- Answer
--   film_id    filmname           filmcategory       rentaltime
      400,     HARDLY ROBBERS,     Documentary,           4
      584,     MIXED DOORS,        Foreign,               4
      904,     TRAIN BUNCH,        Horror,                4
      94,      BRAVEHEART HUMAN,   Family,                5
      107,     BUNCH MINDS,        Drama,                 5
       ...       ...                ...                ...;
