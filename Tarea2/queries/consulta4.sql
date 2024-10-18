SELECT 
	c.first_name, c.last_name
FROM 
	customer c
	JOIN invoice i ON c.customer_id = i.customer_id
	JOIN invoice_line il ON i.invoice_id = il.invoice_id
	JOIN track t ON il.track_id = t.track_id
	JOIN genre g ON t.genre_id = g.genre_id
		WHERE g.name = 'Rock'
		GROUP BY c.customer_id
		HAVING COUNT(DISTINCT t.track_id) >= 2;