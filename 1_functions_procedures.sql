/* 
 Тема: Написание функций и процедур
*/


CREATE FUNCTION find_number_of_film(actorId int)
    RETURNS numeric(4,0) -- говорим, что будем возращать целочисленную переменную
    LANGUAGE plpgsql
AS
$$
DECLARE
    numFilm numeric(4,0); -- заводим переменную, которую будем использовать
begin
	SELECT COUNT(film_id) INTO numFilm -- инициализуруем переменную numFilm
	FROM film_actor
	WHERE actor_id=actorId;
    RETURN numFilm; -- возвращаем найденное число
end;
$$;

SELECT find_number_of_film(21);


-- 1. Реализуйте функцию, определяющую сумму покупок клиента по его id

CREATE FUNCTION buySum_customer(customerID int)
	RETURNS numeric(4,0)
	language plpgsql
AS
$$
DECLARE
	buySum numeric(4,0);
begin 
	SELECT SUM(amount) INTO buySum 
	FROM payment 
	WHERE customer_id = customerID;
	RETURN buySum;
end;
$$;

SELECT buySum_customer(1);


-- Изучите пример функции, возвращающей названия фильма заданного жанра
CREATE OR REPLACE FUNCTION get_movies_by_genre(p_genre_name VARCHAR)
    RETURNS TABLE (
        title VARCHAR,
        genre_name VARCHAR)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        f.title,
		cat.name
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    WHERE cat.name = p_genre_name;
END;
$$ LANGUAGE plpgsql;

-- Сравните вывод
SELECT get_movies_by_genre('Animation');
SELECT * FROM get_movies_by_genre('Animation');

-- 2. Напишите функцию, возвращающую названия фильма по фамилии актёра
CREATE OR REPLACE FUNCTION get_movies_actor(lastName VARCHAR)
	RETURNS TABLE(
		title VARCHAR,
		last_name VARCHAR
	)
AS $$
BEGIN 
	RETURN QUERY
	SELECT
		f.title,
		a.last_name
	FROM film f
	JOIN film_actor fa ON f.film_id = fa.film_id
	JOIN actor a ON fa.actor_id = a.actor_id
	WHERE a.last_name = lastName;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM get_movies_actor('DAVIS');
/*
3. Напишите функцию get_customer_status, возвращающую Best, если клиент арендовал 30 или более фильмов, иначе - "Ordinary". 
Входные данные id клиента.
*/

CREATE OR REPLACE FUNCTION get_customer_status(customerId int) 
RETURNS VARCHAR AS $$
DECLARE
    rental_count int;
    customer_status VARCHAR;
BEGIN
    SELECT count(rental_id) INTO rental_count
    FROM rental
    WHERE customer_id = customerId;
    
    IF rental_count >= 30 THEN
        customer_status = 'Best';
    ELSE
        customer_status = 'Ordinary';
    END IF;
    
    RETURN customer_status;
END;
$$ LANGUAGE plpgsql;
	
SELECT get_customer_status(14);


-- Проверьте работу своей функции следующим запросом:
SELECT get_customer_status(480);
-- Ordinary

SELECT get_customer_status(64);
-- Best



-- напишите процедуры, обрабатывающей ошибки при изменении email покупателя
CREATE OR REPLACE PROCEDURE update_customer_details(
    p_customer_id INT,
    p_new_email VARCHAR
)
AS $$
BEGIN
    -- Проверяем, существует ли указанный покупатель
    IF NOT EXISTS (SELECT 1 FROM customer WHERE customer_id = p_customer_id) THEN
        RAISE EXCEPTION 'Нет покупателя с ID %', p_customer_id;
    END IF;
	
	IF EXISTS (SELECT 1 FROM customer WHERE email = p_new_email) THEN
        RAISE EXCEPTION 'Пользователь с таким email (%) уже существует', p_new_email;
    END IF;

    -- Для обработки ошибок используется блок TRY...EXCEPTION
    BEGIN
        -- Обновляем данные о покупателе
        UPDATE customer
        SET email = p_new_email
        WHERE customer_id = p_customer_id;

        -- Если произошла в блоке TRY произошла какая-то другая ошибка, то выведем информацию об этом
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION 'Произошла ошибка: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;


CALL update_customer_details(601, 'MARI2.SMITH@sakilacustomer.org');
CALL update_customer_details(1, 'MARI.SMITH@sakilacustomer.org');
CALL update_customer_details(1, 'BARBARA.JONES@sakilacustomer.org');


/* 
4. Напишите процедуру, изменяющую rental_duraction и rental_rate по названию фильма.
Необходимо выдавать ошибки в случаях:
- если фильма с указанным названием не существует;
- если rental_duraction и rental_rate равны нулю;
- если rental_duraction больше 14;
- если rental_rate больше 7.
*/

CREATE OR REPLACE PROCEDURE update_film_rental_info(
    IN p_film_title VARCHAR,
    IN p_rental_duration NUMERIC,
    IN p_rental_rate NUMERIC
)
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM film WHERE title = p_film_title) THEN
        RAISE EXCEPTION 'Фильм с указанным названием не существует';
    END IF;

    IF p_rental_duration = 0 THEN
        RAISE EXCEPTION 'Значение для rental_duraction должно быть больше нуля';
    END IF;

    IF p_rental_duration > 14 THEN
        RAISE EXCEPTION 'Значение для rental_duraction не может быть больше 14';
    END IF;

    IF p_rental_rate = 0 THEN
        RAISE EXCEPTION 'Значение для rental_rate должно быть больше нуля';
    END IF;

    IF p_rental_rate > 7 THEN
        RAISE EXCEPTION 'Значение для rental_rate не может быть больше 7';
    END IF;
	BEGIN
    	UPDATE film
    	SET rental_duration = p_rental_duration,
        	rental_rate = p_rental_rate
    	WHERE title = p_film_title;
	
	EXCEPTION 
		WHEN others THEN 
			RAISE EXCEPTION 'Произошла ошибка: %', SQLERRM;
	END;
END;
$$ LANGUAGE plpgsql;


CALL update_film_rental_info('ACADEMY DINOSAUR', 15, 2);
CALL update_film_rental_info('ACE GOLDFINGER', 11, 8);
CALL update_film_rental_info('ACADEMY DINOSAUR', 11, 2);
CALL update_film_rental_info('ACE GOLDFINGER', 0, 2);
CALL update_film_rental_info('LITLE HOME', 5, 4);
CALL update_film_rental_info('AIRPLANE SIERRA', 9, 0);