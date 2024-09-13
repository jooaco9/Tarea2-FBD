SELECT DISTINCT 
  g.name 
FROM 
  artist a 
  NATURAL JOIN album al 
  JOIN track t USING(album_id) 
  JOIN genre g USING(genre_id) 
WHERE 
  a.name = 'Amy Winehouse';