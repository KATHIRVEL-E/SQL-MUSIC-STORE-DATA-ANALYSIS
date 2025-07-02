--1)Who is the senior most employee based on job title?
SELECT * FROM employee
ORDER BY TITLE DESC
LIMIT 1;

--2)Which countries have the most invoices?
SELECT count(*),billing_country
FROM invoice
GROUP BY billing_country
ORDER BY BILLING_COUNTRY DESC;

--3)What are top 3 values of totla invoice?
SELECT total AS Total_invoice
FROM INVOICE
ORDER BY total DESC
LIMIT 3;

/*4)Which city has the best customers? We would like to throw a promotional
music festival in the city we made the most money,Write a query that returns
one city that has the highest sum of invoice totals.Return both the 
city name&sum of all invoice totals*/
SELECT SUM(total) AS total,billing_city AS city
FROM invoice
GROUP BY billing_city
ORDER BY total DESC
LIMIT 1;

/*5)Who is the best customer?The customer who has spent the most money 
will be declared the best customer.Write a query that returns the person 
who has spent the money most*/
SELECT customer.customer_id,customer.first_name,customer.last_name,SUM(invoice.total) AS total
FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
LIMIT 1;

/*6)Write query to return email,first name,last name,& genre of all
rock music listeners.Return your list ordered alphabetically
by email starting with A*/
SELECT DISTINCT customer.email,customer.first_name,customer.last_name
FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
JOIN track ON invoice_line.track_id=track.track_id
JOIN genre ON track.genre_id=genre.genre_id
WHERE genre.name ILIKE 'Rock'
AND customer.email ILIKE 'A%'
ORDER BY customer.email;

/*7)Let's invite the artists who have written the most rock music in our dataset.
write a query that returns the artist name and total track count of the top 10
rock bands.*/
SELECT artist.artist_id,artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id=track.album_id
JOIN artist ON artist.artist_id=album.artist_id
JOIN genre ON genre.genre_id=track.genre_id
WHERE genre.name ILIKE 'ROCK'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/*8)Return all the track names that have a song length longer than the 
average song length.Return the name and milliseconds for each track.
Order by the song length with the longest songs listed first.*/
SELECT name,milliseconds
FROM track
WHERE milliseconds> (
SELECT AVG(milliseconds) AS avg_track_length
FROM track)
ORDER BY milliseconds DESC;
