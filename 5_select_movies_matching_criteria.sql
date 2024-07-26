SELECT
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    JSON_OBJECT(
        'id',
        f.id,
        'file_name',
        f.file_name,
        'mime_type',
        f.mime_type,
        'key',
        f.key,
        'url',
        f.url
    ) AS poster,
    JSON_OBJECT(
        'id',
        p.id,
        'first_name',
        p.first_name,
        'last_name',
        p.last_name
    ) AS director
FROM
    Movie m
    JOIN File f ON m.poster_id = f.id
    JOIN Person p ON m.director_id = p.id
    JOIN Movie_Genre mg ON m.id = mg.movie_id
    JOIN Genre g ON mg.genre_id = g.id
WHERE
    m.country_id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration > 135
    AND (
        g.name = 'Action'
        OR g.name = 'Drama'
    )
GROUP BY
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    poster,
    director;