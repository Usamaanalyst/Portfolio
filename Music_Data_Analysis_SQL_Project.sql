--Q1: Who is the Senior most employee based on job title?
--Ans: Madan Mohan

select * from employee
order by levels desc limit 1

--Q2:Which countries have the most Invoices?

select billing_country,count(*) from invoice group by billing_country order by billing_country desc;

--Q3. What are top 3 values of total invoice?
select total from invoice order by total desc limit 3

--Q4:4. Which city has the best customers? We would like to throw a promotional Music 
--Festival in the city we made the most money. Write a query that returns one city that 
--has the highest sum of invoice totals. Return both the city name & sum of all invoice 
--totals

select billing_city, sum(total) as "Total Amount" from invoice group by billing_city order by "Total Amount" desc