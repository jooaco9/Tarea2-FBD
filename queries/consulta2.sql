SELECT DISTINCT a.name FROM 
  artist a NATURAL JOIN album al 
  INNER JOIN track t USING(album_id) 
  INNER JOIN genre g USING(genre_id) 
  GROUP BY a.name 
  HAVING COUNT(g.name) = 1;