-- Devolver el nombre del g´enero musical con m´as cantidad de playlists.
-- Esquema del resultado: name. 

-- VERSION 1
SELECT g.name AS genre_name
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN playlist_track pt ON t.track_id = pt.track_id
GROUP BY g.genre_id, g.name
HAVING COUNT(DISTINCT pt.playlist_id) = (
  SELECT MAX(playlist_count) FROM (
      SELECT COUNT(DISTINCT pt.playlist_id) AS playlist_count FROM 
        genre g
        JOIN track t ON g.genre_id = t.genre_id
        JOIN playlist_track pt ON t.track_id = pt.track_id
        GROUP BY g.genre_id
        ) AS subquery
    )
ORDER BY g.name;

-- VERSION 2
SELECT genre_name
FROM (
  SELECT g.name AS genre_name,
  COUNT(DISTINCT pt.playlist_id) AS playlist_count,
  MAX(COUNT(DISTINCT pt.playlist_id)) OVER () AS max_playlist_count 
  FROM genre g
  JOIN track t ON g.genre_id = t.genre_id
  JOIN playlist_track pt ON t.track_id = pt.track_id
  GROUP BY g.genre_id, g.name
)
WHERE playlist_count = max_playlist_count
ORDER BY genre_name;
