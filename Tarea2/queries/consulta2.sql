SELECT DISTINCT 
  a.name 
FROM 
  artist a 
  NATURAL JOIN album al 
  JOIN track t USING(album_id) 
  JOIN genre g USING(genre_id) 
GROUP BY 
  a.name 
HAVING 
  COUNT(g.name) = 1;