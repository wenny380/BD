-- 1. Список ФИО членов экипажа с их летным стажем.

SELECT cm.name AS ФИО,
       cm.number_of_flights AS "Число полетов"
      FROM crews_crew_members AS ccm
JOIN crews AS c ON ccm.crew_id = c.crew_id
JOIN crew_members AS cm ON ccm.crew_member_id = cm.crew_member_id;

-- 2. Информация о самолетах, совершивших более 3 рейсов за последнюю неделю.

--SELECT * FROM flights;

SELECT a.aircraft_id, a.number, a.brand, a.model,a.capacity,
       COUNT(*) AS "Количество рейсов"
FROM events AS e
JOIN flights AS f ON e.flight_id = f.flight_id
JOIN aircrafts AS a ON f.aircraft_id = a.aircraft_id
WHERE e.date >= CURRENT_DATE - INTERVAL '7 days' 
GROUP BY a.aircraft_id
HAVING COUNT(*) > 3;

-- SELECT * FROM events;
-- SELECT * FROM airlines;
-- SELECT * FROM flights;

--  3. Рейсы, которые чаще всего отменяются.
SELECT f.flight_id, f.airline_id, f.flight_number, f.type, f.range, f.frequency,
       COUNT(*) AS "Cancellation Count"
FROM events AS e
JOIN flights AS f ON e.flight_id = f.flight_id
WHERE e.status = 'Отменен'
GROUP BY f.flight_id
ORDER BY COUNT(*) DESC;



-- 4. Название авиакомпаний с указанием процента транзитных рейсов по отношению ко всем рейсам этой авиакомпании.

SELECT a.name AS "Название авиакомпании",
       SUM(CASE WHEN f.type = 'Транзитный' THEN 1 ELSE 0 END) AS "Количество транзитных рейсов",
       COUNT(*) AS "Общее количество рейсов",
       (SUM(CASE WHEN f.type = 'Транзитный' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS "Процент транзитных рейсов"
FROM flights AS f
JOIN airlines AS a ON f.airline_id = a.airline_id
GROUP BY a.name;


-- 5. Средний лётный стаж командиров и пилотов в каждой авиакомпании.

SELECT a.name AS "Название авиакомпании",
       AVG(CASE WHEN cm.position LIKE '%Командир%' THEN cm.number_of_flights ELSE 0 END) AS "Средний опыт командиров",
       AVG(CASE WHEN cm.position LIKE '%пилот%' THEN cm.number_of_flights ELSE 0 END) AS "Средний опыт пилотов"
FROM crew_members AS cm
JOIN crews_crew_members AS ccm ON cm.crew_member_id = ccm.crew_member_id
JOIN crews AS c ON ccm.crew_id = c.crew_id
JOIN flights AS f ON c.flight_id = f.flight_id
JOIN airlines AS a ON f.airline_id = a.airline_id
WHERE cm.position LIKE '%Командир%' OR cm.position LIKE '%пилот%'
GROUP BY a.name;

/*Процедуры
1. Напишите функцию, выводящую информацию о всех отмененных рейсах в указанном аэропорту 
за последние сутки. Входные данные: id аэропорта.*/

--DROP FUNCTION IF EXISTS GetCancelledFlightsByAirportId(airport_id INTEGER);

CREATE OR REPLACE FUNCTION GetCancelledFlightsByAirportId(airportId INTEGER)
RETURNS TABLE (
	airport_id INTEGER,
    flight_id INTEGER,
    airline_id INTEGER,
    aircraft_id INTEGER,
    flight_number VARCHAR(50),
	departure_time INTERVAL,
    flight_date DATE,
    flight_type VARCHAR(50),
	flight_status VARCHAR(50)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT e.airport_id, f.flight_id, f.airline_id, f.aircraft_id, f.flight_number, f.departure_time, e.date, f.type, e.status
    FROM flights f
    JOIN events e ON f.flight_id = e.flight_id
    WHERE e.status = 'Отменен'
        AND e.airport_id = airportId
        AND e.date >= CURRENT_DATE - INTERVAL '2 days';
END;
$$ LANGUAGE plpgsql;

SELECT * FROM GetCancelledFlightsByAirportId(5);
-- add canceled flight for today

/*
2. Напишите процедуру, меняющую экипаж, назначенный на определенный рейс. 
Входные данные: id рейса, время рейса, id нового экипажа. */

--DROP PROCEDURE IF EXISTS ChangeCrewForFlight(flight_id_param INTEGER,departure_time_param INTERVAL,new_crew_id_param INTEGER);
CREATE OR REPLACE PROCEDURE ChangeCrewForFlight(
    flight_id_param INTEGER,
    departure_time_param INTERVAL,
    new_crew_id_param INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE crews
    SET crew_id = new_crew_id_param
    WHERE flight_id = flight_id_param
    AND EXISTS (
        SELECT 1
        FROM flights
        WHERE flights.flight_id = flight_id_param
        AND flights.departure_time = departure_time_param
    );

    RAISE NOTICE 'Экипаж для рейса % был изменен на экипаж с ID %', flight_id_param, new_crew_id_param;
END;
$$;

CALL ChangeCrewForFlight(3, '21:00:00', 20);

SELECT * FROM crews;
SELECT * FROM flights;
