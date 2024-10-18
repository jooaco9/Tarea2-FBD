SELECT 
  t.name, 
  t.milliseconds / 60000 AS duration, 
  t.unit_price
  FROM track t
  	INNER JOIN invoice_line il USING(track_id)
	INNER JOIN invoice i USING(invoice_id)
WHERE
	t.milliseconds = (
		SELECT MAX(milliseconds) 
		FROM track
		INNER JOIN invoice_line il2 USING(track_id)
		INNER JOIN invoice i2 USING(invoice_id)
		WHERE i2.billing_country = 'Canada'
	);