SELECT
    u.id,
    u.username,
    JSON_ARRAYAGG(fm.movie_id) AS favorite_movie_ids
FROM
    User u
    LEFT JOIN Favorite_Movie fm ON u.id = fm.user_id
GROUP BY
    u.id,
    u.username;