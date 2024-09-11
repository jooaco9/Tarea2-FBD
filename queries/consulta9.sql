-- Devolver el identificador, nombre y apellido del empleado que asesoro la mayor cantidad de ventas en el 2024
-- Esquema del resultado: employee_id, first_name, last_name.

SELECT
  e1.employee_id,
  e1.first_name,
  e1.last_name
FROM 
  employee e1
WHERE
  (SELECT 
      COUNT(*) --cantVentasEmp1
    FROM 
      employee e
      JOIN customer ON employee_id = support_rep_id
      INNER JOIN invoice i1 USING(customer_id)
    WHERE 
      i1.invoice_date::text LIKE '%2024%' AND
      e1.employee_id = e.employee_id
    GROUP BY
      e1.employee_id
  ) >= ALL (SELECT 
      COUNT(*) --cantVentasEmpleados
    FROM 
      employee e
      JOIN customer ON employee_id = support_rep_id
      INNER JOIN invoice i1 USING(customer_id)
    WHERE 
      i1.invoice_date::text LIKE '%2024%'
    GROUP BY
      e.employee_id
  );



 




