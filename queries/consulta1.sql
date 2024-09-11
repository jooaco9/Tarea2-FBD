SELECT DISTINCT 
  g.name 
FROM 
  artist a 
  NATURAL JOIN album al 
  INNER JOIN track t USING(album_id) 
  INNER JOIN genre g USING(genre_id) 
WHERE 
  a.name = 'Amy Winehouse';