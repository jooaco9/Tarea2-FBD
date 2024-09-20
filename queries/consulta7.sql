-- Devolver el nombre del g´enero musical con m´as cantidad de playlists.
-- Esquema del resultado: name. 

SELECT g.name AS genre_name
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN playlist_track pt ON t.track_id = pt.track_id
GROUP BY g.name
HAVING COUNT(DISTINCT pt.playlist_id) = (
        SELECT MAX(playlist_count)
        FROM (
            SELECT COUNT(DISTINCT pt.playlist_id) AS playlist_count
            FROM genre g2
            JOIN track t2 ON g2.genre_id = t2.genre_id
            JOIN playlist_track pt ON t2.track_id = pt.track_id
            GROUP BY g2.name
        )
  );
