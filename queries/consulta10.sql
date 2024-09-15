 SELECT *, COUNT(t.track_id) as count
 FROM invoice_line il
 JOIN invoice i ON i.invoice_id = il.invoice_id
 JOIN track t ON t.track_id = il.track_id
 WHERE i.invoice_date BETWEEN ’2013-01-01’ and ’2013-12-31’
 GROUP BY t.track_id
 ORDER BY count DESC;

La consulta busca identificar y contar cuántas veces se ha facturado cada pista de música en el año 2013.
Luego, muestra estas pistas ordenadas de la más facturada a la menos facturada.

Dato extra: 
Hay un problema en la consulta, usar SELECT * junto con GROUP BY 
puede no funcionar correctamente en algunos sistemas SQL debido a que se espera que todas las columnas no agregadas estén en la cláusula GROUP BY.
(En resumen si no les anda la consulta al probarla es por esto mismo, pero si se prueba en un editor online en vez de postgres anda bien, o en la mayoria)
