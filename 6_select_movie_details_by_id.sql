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
    ) AS director,
    JSON_OBJECT(
        'id',
        p.id,
        'first_name',
        p.first_name,
        'last_name',
        p.last_name,
        'photo',
        JSON_OBJECT(
            'id',
            fp.id,
            'file_name',
            fp.file_name,
            'mime_type',
            fp.mime_type,
            'key',
            fp.key,
            'url',
            fp.url
        )
    ) AS photo,
    (
        SELECT
            JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id',
                    c.id,
                    'first_name',
                    c.first_name,
                    'last_name',
                    c.last_name,
                    'photo',
                    JSON_OBJECT(
                        'id',
                        fp2.id,
                        'file_name',
                        fp2.file_name,
                        'mime_type',
                        fp2.mime_type,
                        'key',
                        fp2.key,
                        'url',
                        fp2.url
                    )
                )
            )
        FROM
            Character c
            JOIN Person p ON c.actor_id = p.id
            LEFT JOIN File fp2 ON p.primary_photo_id = fp2.id
        WHERE
            c.movie_id = m.id
    ) AS actors,
    (
        SELECT
            JSON_ARRAYAGG(JSON_OBJECT('id', g.id, 'name', g.name))
        FROM
            Movie_Genre mg
            JOIN Genre g ON mg.genre_id = g.id
        WHERE
            mg.movie_id = m.id
    ) AS genres
FROM
    Movie m
    JOIN File f ON m.poster_id = f.id
    JOIN Person p ON m.director_id = p.id
    LEFT JOIN File fp ON p.primary_photo_id = fp.id
WHERE
    m.id = 1;