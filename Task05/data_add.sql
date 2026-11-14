-- data_add.sql
-- Добавление новых данных в movies_rating.db
-- Запросы НЕ зависят от конкретных ID

BEGIN TRANSACTION;

-- ============================================
-- 1. ПЯТЬ НОВЫХ ПОЛЬЗОВАТЕЛЕЙ
-- ============================================
-- Замените ФИО, email и профессии на свои и соседей по группе
-- Дата регистрации = datetime('now') — системное время

INSERT INTO users (name, email, gender, register_date, occupation_id)
VALUES
    ('Кряжев Иван Олегович', 'kryazhev.ivan06+lab5@mail.ru', 'male', datetime('now'),
        (SELECT id FROM occupations WHERE name = 'engineer')),

    ('Сосед Первый', 'sosed1@example.com', 'male', datetime('now'),
        (SELECT id FROM occupations WHERE name = 'student')),

    ('Сосед Второй', 'sosed2@example.com', 'female', datetime('now'),
        (SELECT id FROM occupations WHERE name = 'student')),

    ('Сосед Третий', 'sosed3@example.com', 'male', datetime('now'),
        (SELECT id FROM occupations WHERE name = 'other')),

    ('Сосед Четвертый', 'sosed4@example.com', 'female', datetime('now'),
        (SELECT id FROM occupations WHERE name = 'other'));


-- ============================================
-- 2. ТРИ НОВЫХ ФИЛЬМА РАЗНЫХ ЖАНРОВ
-- ============================================
-- Жанры: Action, Comedy, Drama
-- Все фильмы 2024 года (не пересекаются с датасетом)

-- Фильм 1: Action
INSERT INTO movies (title, year) VALUES ('Новый боевик', 2024);
INSERT INTO movie_genres (movie_id, genre_id)
VALUES
    (last_insert_rowid(), (SELECT id FROM genres WHERE name = 'Action'));

-- Фильм 2: Comedy
INSERT INTO movies (title, year) VALUES ('Новая комедия', 2024);
INSERT INTO movie_genres (movie_id, genre_id)
VALUES
    (last_insert_rowid(), (SELECT id FROM genres WHERE name = 'Comedy'));

-- Фильм 3: Drama
INSERT INTO movies (title, year) VALUES ('Новая драма', 2024);
INSERT INTO movie_genres (movie_id, genre_id)
VALUES
    (last_insert_rowid(), (SELECT id FROM genres WHERE name = 'Drama'));


-- ============================================
-- 3. ТРИ НОВЫХ ОТЗЫВА ОТ СЕБЯ
-- ============================================
-- user_id = id Кряжева Ивана (по email)
-- timestamp = текущее Unix-время

INSERT INTO ratings (user_id, movie_id, rating, timestamp)
VALUES
    ((SELECT id FROM users WHERE email = 'kryazhev.ivan06+lab5@mail.ru'),
     (SELECT id FROM movies WHERE title = 'Новый боевик' AND year = 2024),
     5.0, strftime('%s', 'now')),

    ((SELECT id FROM users WHERE email = 'kryazhev.ivan06+lab5@mail.ru'),
     (SELECT id FROM movies WHERE title = 'Новая комедия' AND year = 2024),
     4.5, strftime('%s', 'now')),

    ((SELECT id FROM users WHERE email = 'kryazhev.ivan06+lab5@mail.ru'),
     (SELECT id FROM movies WHERE title = 'Новая драма' AND year = 2024),
     4.0, strftime('%s', 'now'));


COMMIT;
