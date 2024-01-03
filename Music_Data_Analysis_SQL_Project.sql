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

--Q5 5. Who is the best customer? The customer who has spent the most money will be 
--declared the best customer. Write a query that returns the person who has spent the 
--most money

SELECT c.first_name, c.last_name, SUM(i.total) AS "Total Amount"
FROM customer AS c
JOIN invoice AS i ON c.customer_id = i.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY "Total Amount" DESC;

--Q6----Write query to return the email, first name, last name, & Genre of all Rock Music 
--listeners. Return your list ordered alphabetically by email starting with A

select c.email,c.first_name,c.last_name from customer As c

join invoice  AS i on c.customer_id = i.customer_id
join invoice_line on  i.invoice_id = invoice_line.invoice_id 

where track_id in (
    select track_id from track
	join genre AS g on g.genre_id = track.genre_id
	Where g.name like 'Rock'
)
Order by email; 

---Q7  Let's invite the artists who have written the most rock music in our dataset. Write a 
--query that returns the Artist name and total track count of the top 10 rock bands

select artist.artist_id , artist.name , count(artist.artist_id) as "No of Songs"
from track
join album on album.album_id = track.album_id
join artist on album.album_id = artist.artist_id
join genre on track.genre_id = genre.genre_id

where genre.name like 'Rock'
group by artist.artist_id
order by "No of Songs" desc
limit 10;

---Q8 Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. Order by the song length with the 
--longest songs listed first


select name , milliseconds from track 
where milliseconds > (
select avg(milliseconds) AS "Avg Millisecond" from track
)
order by milliseconds desc


--Q9 Find how much amount spent by each customer on artists? Write a query to return
--customer name, artist name and total spent

select c.first_name ,c.last_name , artist.name , sum(invoice.total)  as "Amount Spent"
from customer as c

join invoice on invoice.customer_id = c.customer_id
join invoice_line as il on invoice.invoice_id = il.invoice_id
join track on il.track_id = track.track_id
join album on track.album_id = album.album_id
join artist on album.artist_id = artist.artist_id

group by c.first_name , c.last_name , artist.name
order by  "Amount Spent" desc limit 1

--Q10--We want to find out the most popular music Genre for each country. We determine the 
--most popular genre as the genre with the highest amount of purchases. Write a query 
--that returns each country along with the top Genre. For countries where the maximum 
--number of purchases is shared return all Genres

    SELECT
        invoice.billing_country,
        genre.name AS genre_name,
        COUNT(il.quantity) AS Purchases
    FROM
        invoice
    JOIN
        invoice_line AS il ON invoice.invoice_id = il.invoice_id
    JOIN
        track ON il.track_id = track.track_id
    JOIN
        genre ON track.genre_id = genre.genre_id
    GROUP BY
        invoice.billing_country, genre.name 
    ORDER BY
        Purchases DESC

--Q11---Write a query that determines the customer that has spent the most on music for each 
--country. Write a query that returns the country along with the top customer and how
--much they spent. For countries where the top amount spent is shared, provide all 
--customers who spent this amount

select customer.first_name, customer.last_name,customer.country, Sum(invoice.total) as "Total" from customer 
join invoice on invoice.customer_id = customer.customer_id 
group by customer.first_name,customer.last_name,customer.country
order by "Total" desc




