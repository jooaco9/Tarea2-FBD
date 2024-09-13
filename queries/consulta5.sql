--Devolver el nombre y apellido de los clientes que compraron todas las canciones de la artista “Amy Winehouse”.
--Esquema del resultado: first name, last name.


-- Paso 1: Obtener todos los álbumes de Amy Winehouse
WITH amy_albums AS (
    SELECT a.album_id
    FROM album a
    JOIN artist ar ON a.artist_id = ar.artist_id
    WHERE ar.name = 'Amy Winehouse'
),

-- Paso 2: Obtener los clientes que han comprado álbumes de Amy Winehouse
client_purchases AS (
    SELECT c.customer_id, COUNT(DISTINCT a.album_id) AS albums_purchased
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN album a ON t.album_id = a.album_id
    JOIN amy_albums aa ON a.album_id = aa.album_id
    GROUP BY c.customer_id
),

-- Paso 3: Verificar que el cliente ha comprado todos los álbumes
client_all_albums AS (
    SELECT customer_id
    FROM client_purchases
    WHERE albums_purchased = (SELECT COUNT(*) FROM amy_albums)
)

-- Paso 4: Obtener la información de los clientes que han comprado todos los álbumes
SELECT c.first_name, c.last_name
FROM customer c
JOIN client_all_albums ca ON c.customer_id = ca.customer_id;
