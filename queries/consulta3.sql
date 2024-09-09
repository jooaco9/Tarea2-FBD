SELECT 
  t.name, 
  t.milliseconds / 60000 AS duration, 
  t.unit_price
FROM 
  track t INNER JOIN invoice_line USING(track_id) INNER JOIN invoice i USING(invoice_id)
WHERE 
  milliseconds = (SELECT MAX(milliseconds) FROM track)
  AND i.billing_country = 'Canadá';
