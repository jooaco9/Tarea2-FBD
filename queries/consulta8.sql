SELECT 
  al.title, 
  COUNT(DISTINCT i.invoice_id) AS "number_of_purchases"
FROM 
  album al
  JOIN track t ON al.album_id = t.album_id
  JOIN invoice_line il ON t.track_id = il.track_id
  JOIN invoice i ON il.invoice_id = i.invoice_id
	GROUP BY al.album_id, al.title
	ORDER BY number_of_purchases DESC
	LIMIT 3;