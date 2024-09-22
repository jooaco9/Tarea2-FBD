SELECT 
  a.name
FROM 
  artist a 
  JOIN album al USING(artist_id)
  JOIN track t USING(album_id) 
  JOIN genre g USING(genre_id) 
GROUP BY 
  a.artist_id
HAVING 
  COUNT(DISTINCT g.genre_id) = 1
