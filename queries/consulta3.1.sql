SELECT
  t.name, 
  t.milliseconds / 60000 AS duration, 
  t.unit_price
FROM 
  track t 
  INNER JOIN invoice_line il USING(track_id)
  INNER JOIN invoice i USING(invoice_id)
WHERE 
  i.billing_country = 'Canada'
ORDER BY 
  duration DESC
LIMIT 1;
