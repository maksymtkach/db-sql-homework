# Movie Database Design

## ER Diagram

```mermaid
erDiagram
    USER {
        int id PK
        varchar username
        varchar first_name
        varchar last_name
        varchar email
        varchar password
        int avatar_id FK
        datetime created_at
        datetime updated_at
    }
    
    FILE {
        int id PK
        varchar file_name
        varchar mime_type
        varchar key
        varchar url
        datetime created_at
        datetime updated_at
    }

    MOVIE {
        int id PK
        varchar title
        text description
        float budget
        date release_date
        int duration
        int director_id FK
        int country_id FK
        int poster_id FK
        datetime created_at
        datetime updated_at
    }

    CHARACTER {
        int id PK
        varchar name
        text description
        enum role {'leading', 'supporting', 'background'}
        int movie_id FK
        int actor_id FK
        datetime created_at
        datetime updated_at
    }

    PERSON {
        int id PK
        varchar first_name
        varchar last_name
        text biography
        date date_of_birth
        enum gender {'male', 'female', 'other'}
        int country_id FK
        int primary_photo_id FK
        datetime created_at
        datetime updated_at
    }

    COUNTRY {
        int id PK
        varchar name
        datetime created_at
        datetime updated_at
    }

    GENRE {
        int id PK
        varchar name
        datetime created_at
        datetime updated_at
    }

    MOVIE_GENRE {
        int movie_id PK FK
        int genre_id PK FK
        datetime created_at
        datetime updated_at
    }

    FAVORITE_MOVIE {
        int user_id PK FK
        int movie_id PK FK
        datetime created_at
        datetime updated_at
    }

    PERSON_PHOTO {
        int person_id PK FK
        int file_id PK FK
        datetime created_at
        datetime updated_at
    }

    USER ||--|{ FILE : "has"
    MOVIE ||--|{ FILE : "has"
    MOVIE ||--|{ COUNTRY : "belongs to"
    MOVIE ||--o{ GENRE : "has"
    MOVIE ||--o| PERSON : "directed by"
    CHARACTER }o--|| MOVIE : "appears in"
    CHARACTER }o--|| PERSON : "played by"
    PERSON ||--|{ COUNTRY : "belongs to"
    PERSON ||--|{ FILE : "has"
    PERSON }o--|| MOVIE : "directed"
    USER ||--o{ FAVORITE_MOVIE : "has favorite"
    MOVIE ||--o{ FAVORITE_MOVIE : "is favorite in"
    GENRE ||--o{ MOVIE_GENRE : "belongs to"
    MOVIE ||--o{ MOVIE_GENRE : "has"
    PERSON ||--o{ PERSON_PHOTO : "has"
    FILE ||--o{ PERSON_PHOTO : "is used in"

```