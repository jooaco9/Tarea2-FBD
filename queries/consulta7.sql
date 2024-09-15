-- Devolver el nombre del g´enero musical con m´as cantidad de playlists.
-- Esquema del resultado: name. 

SELECT g.name AS genre_name
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id
GROUP BY g.name
ORDER BY COUNT(DISTINCT p.playlist_id) DESC;

