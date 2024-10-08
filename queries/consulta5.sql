--Devolver el nombre y apellido de los clientes que compraron todas las canciones de la artista “Amy Winehouse”.
--Esquema del resultado: first name, last name.


SELECT c.first_name, c.last_name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN album a ON t.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
WHERE ar.name = 'Amy Winehouse'
GROUP BY c.customer_id
HAVING COUNT(DISTINCT a.album_id) = (
    SELECT COUNT(DISTINCT a2.album_id)
    FROM album a2
    JOIN artist ar2 ON a2.artist_id = ar2.artist_id
    WHERE ar2.name = 'Amy Winehouse'
);
