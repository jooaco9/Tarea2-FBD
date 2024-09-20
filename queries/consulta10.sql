 SELECT *, COUNT(t.track_id) as count
 FROM invoice_line il
 JOIN invoice i ON i.invoice_id = il.invoice_id
 JOIN track t ON t.track_id = il.track_id
 WHERE i.invoice_date BETWEEN ’2013-01-01’ and ’2013-12-31’
 GROUP BY t.track_id
 ORDER BY count DESC;

Selecciona todas las columnas (*) de las tablas involucradas y cuenta el número de veces que 
cada pista (track) aparece en las líneas de factura (invoice_line) para el año 2013.

Se une la tabla invoice_line (il) con la tabla invoice (i) usando invoice_id. Esto vincula cada línea de factura con su correspondiente factura.
Se une la tabla invoice_line con la tabla track (t) usando track_id, lo que permite acceder a los detalles de cada pista en las líneas de factura.

se usa WHERE para filtrar las facturas e incluir solo aquellas con una fecha de factura (invoice_date)
entre el 1 de enero de 2013 y el 31 de diciembre de 2013.

se usa GROUP BY t.track_id para agrupar los resultados por el identificador de la pista. 

los resultados se ordenan en orden descendente (DESC) según el conteo de pistas.
 
RESUMEN:
La consulta busca identificar y contar cuántas veces se ha facturado cada pista de música en el año 2013.
Luego, muestra estas pistas ordenadas de la más facturada a la menos facturada.


Dato extra: 
Hay un problema en la consulta, usar SELECT * junto con GROUP BY 
puede no funcionar correctamente en algunos sistemas SQL debido a que se espera que todas las columnas no agregadas estén en la cláusula GROUP BY.
(En resumen si no les anda la consulta al probarla es por esto mismo, pero si se prueba en un editor online en vez de postgres anda bien, o en la mayoria)
