-- Devolver el nombre, apellido y cantidad de compras de cada cliente asesorado por “Steve Johnson”.
-- Esquema del resultado: first name, last name, number of purchases

SELECT
  c.first_name,
  c.last_name,
  COUNT(i.invoice_id) AS number_of_purchases
FROM
  invoice i 
  INNER JOIN customer c USING(customer_id)
  JOIN employee e ON e.employee_id = c.support_rep_id
WHERE
  e.first_name = 'Steve' and e.last_name = 'Johnson'
GROUP BY
  c.customer_id, c.first_name, c.last_name
ORDER BY
  c.first_name, c.last_name;
