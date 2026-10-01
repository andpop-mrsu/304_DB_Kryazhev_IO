# Лабораторная работа 2. ETL-скрипт для SQLite

## Описание работы

Утилита `make_db_init.py` выполняет ETL-процесс: читает исходные данные
из каталога `Task02`, генерирует SQL-скрипт `db_init.sql` и загружает
его в базу данных SQLite `movies_rating.db`.

## Файлы в каталоге Task02

### Скрипты
- `make_db_init.py` — Python-скрипт. Читает данные и создаёт `db_init.sql`
  с командами `CREATE TABLE` и `INSERT INTO`.
- `db_init.bat` — shell-скрипт запуска:
  1. `python make_db_init.py`
  2. `sqlite3 movies_rating.db < db_init.sql`

### Генерируемые файлы
- `db_init.sql` — SQL-скрипт (создаётся автоматически).
- `movies_rating.db` — база данных SQLite (создаётся автоматически).

### Исходные данные
- `movies.csv` — фильмы. Колонки: `movieId`, `title`, `genres`.
- `ratings.csv` — оценки. Колонки: `userId`, `movieId`, `rating`, `timestamp`.
- `tags.csv` — теги. Колонки: `userId`, `movieId`, `tag`, `timestamp`.
- `users.txt` — пользователи. Разделитель `|`. Поля: `userId`, `name`, `email`, `gender`, `register_date`, `occupation`.
- `genres.txt` — справочник жанров (в ETL не используется).
- `occupation.txt` — справочник профессий (в ETL не используется).

## Структура базы данных movies_rating.db

### movies
- id INTEGER PRIMARY KEY
- title TEXT
- year INTEGER
- genres TEXT

### ratings
- id INTEGER PRIMARY KEY AUTOINCREMENT
- user_id INTEGER
- movie_id INTEGER
- rating REAL
- timestamp INTEGER

### tags
- id INTEGER PRIMARY KEY AUTOINCREMENT
- user_id INTEGER
- movie_id INTEGER
- tag TEXT
- timestamp INTEGER

### users
- id INTEGER PRIMARY KEY
- name TEXT
- email TEXT
- gender TEXT
- register_date TEXT
- occupation TEXT

## Требования к окружению

Для работы `db_init.bat` должны быть установлены:

| Компонент | Проверка |
|-----------|----------|
| Python 3 | `python --version` (или `python3 --version`) |
| SQLite (утилита `sqlite3`) | `sqlite3 --version` |

Утилита `sqlite3` должна быть доступна в `PATH`.

## Как запустить

Из каталога `Task02`:

```bash
./db_init.bat
```

или

```bash
bash db_init.bat
```

После выполнения появится заполненная база данных `movies_rating.db`.

## Проверка результата

```bash
sqlite3 movies_rating.db
```

```sql
.tables
SELECT COUNT(*) FROM movies;
SELECT COUNT(*) FROM ratings;
SELECT COUNT(*) FROM tags;
SELECT COUNT(*) FROM users;
.quit
```
