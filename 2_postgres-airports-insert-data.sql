-- Data Insert into TABLE Airports: 

INSERT INTO Airports (name, international_code) VALUES 
('Аэропорт Шереметьево', 'SVO'),
('Аэропорт Домодедово', 'DME'),
('Аэропорт Внуково', 'VKO'),
('Аэропорт Кольцово', 'SVX'),
('Аэропорт Пулково', 'LED'),
('Аэропорт Курумоч', 'KUF'),
('Аэропорт Толмачёво', 'OVB'),
('Аэропорт Красноярск', 'KJA'),
('Аэропорт Уфа', 'UFA'),
('Аэропорт Стригино', 'GOJ');


-- Data Insert into TABLE Airlines:

INSERT INTO Airlines (name) VALUES 
('Аэрофлот'),
('Победа'),
('S7 Airlines'),
('Уральские авиалинии'),
('Нордавиа'),
('Якутия'),
('Россия');


-- Data Insert into TABLE Aircrafts:

INSERT INTO Aircrafts (number, brand, model, capacity) VALUES 
('RF-A001', 'Airbus', 'A320', 156),
('RF-A002', 'Airbus', 'A321', 194),
('RF-A003', 'Airbus', 'A330', 277),
('RF-B001', 'Boeing', '737-800', 189),
('RF-B002', 'Boeing', '777-300', 396),
('RF-B003', 'Boeing', '767-300', 218),
('RF-S001', 'Sukhoi', 'Superjet 100', 87),
('RF-I001', 'Irkut', 'MC-21', 163),
('RF-T001', 'Tupolev', 'Tu-204', 210),
('RF-AN01', 'Antonov', 'An-148', 85);


-- Data Insert into TABLE Flights:
INSERT INTO Flights (airline_id, aircraft_id, flight_number, type, range, departure_time, arrival_time, travel_time, frequency) VALUES 
(1, 1, 'SU100', 'Терминальный', 5000, '10:00:00', '15:00:00', '05:00:00', 'Ежедневно'),
(2, 2, 'S7101', 'Терминальный', 3000, '09:00:00', '12:30:00', '03:30:00', 'По будням'),
(1, 1, 'U6250', 'Транзитный', 7000, '21:00:00', '05:00:00', '08:00:00', 'По четным дням'),
(4, 4, 'P2345', 'Терминальный', 2500, '18:00:00', '20:00:00', '02:00:00', 'По выходным'),
(5, 4, 'N7890', 'Транзитный', 4500, '07:00:00', '11:30:00', '04:30:00', 'Каждую среду'),
(6, 4, 'N7890', 'Транзитный', 4500, '07:00:00', '11:30:00', '04:30:00', 'Каждую среду'),
(1, 1, 'SU200', 'Терминальный', 5500, '10:00:00', '17:00:00', '07:00:00', 'Ежедневно'),
(1, 1, 'S7151', 'Терминальный', 3200, '11:00:00', '14:00:00', '03:00:00', 'По нечетным дням'),
(3, 8, 'U6280', 'Транзитный', 8000, '23:00:00', '07:30:00', '08:30:00', 'Каждый понедельник'),
(4, 2, 'P2456', 'Терминальный', 2700, '19:00:00', '21:30:00', '02:30:00', 'По четным дням'),
(5, 1, 'N7901', 'Транзитный', 4800, '08:00:00', '12:45:00', '04:45:00', 'Каждую пятницу'),
(4, 2, 'SU1234', 'Терминальный', 5300, '08:00:00', '14:00:00', '06:00:00', 'Ежедневно'),
(7, 3, 'P7890', 'Транзитный', 4300, '09:30:00', '15:00:00', '05:30:00', 'По будням'),
(4, 2, 'P7890', 'Транзитный', 4300, '09:30:00', '15:00:00', '05:30:00', 'По будням');


-- Data Insert into TABLE Events:

INSERT INTO Events (airport_id, flight_id, type, date, del_adv_time, status) VALUES 
(1, 1, 'Вылет', '2023-12-21', '10:00:00', 'Отменен'),
(5, 1, 'Посадка', '2023-12-22', '15:00:00', 'Отменен'),
(2, 1, 'Вылет', '2023-12-19', '09:00:00', 'Отменен'),
(6, 2, 'Посадка', '2023-12-16', '12:30:00', 'Ожидается'),
(3, 3, 'Вылет', '2023-12-16', '21:00:00', 'Ожидается'),
(7, 3, 'Посадка', '2023-12-16', '05:00:00', 'Состоялся'),
(4, 4, 'Вылет', '2023-12-16', '18:00:00', 'Ожидается'),
(8, 4, 'Посадка', '2023-12-15', '20:00:00', 'Ожидается'),
(5, 5, 'Вылет', '2023-12-22', '07:00:00', 'Отменен'),
(9, 5, 'Посадка', '2023-11-01', '11:30:00', 'Отменен'),
(6, 6, 'Вылет', '2023-11-01', '10:00:00', 'Состоялся'),
(10, 6, 'Посадка', '2023-11-01', '17:00:00', 'Отменен'),
(7, 7, 'Вылет', '2023-12-15', '11:00:00', 'Состоялся'),
(1, 7, 'Посадка', '2023-12-14', '14:00:00', 'Ожидается'),
(8, 5, 'Вылет', '2023-11-01', '23:00:00', 'Отменен'),
(2, 8, 'Посадка', '2023-11-02', '07:00:00', 'Состоялся'),
(9, 9, 'Вылет', '2023-12-14', '19:00:00', 'Ожидается'),
(3, 9, 'Посадка', '2023-12-14', '21:30:00', 'Ожидается'),
(10, 10, 'Вылет', '2023-11-01', '08:00:00', 'Состоялся'),
(4, 10, 'Посадка', '2023-11-01', '12:45:00', 'Ожидается'),
(1, 11, 'Вылет', '2023-12-21', '08:00:00', 'Отменен'),
(5, 11, 'Посадка', '2023-12-22', '14:00:00', 'Отменен'),
(2, 12, 'Вылет', '2023-11-01', '09:30:00', 'Состоялся'),
(6, 12, 'Посадка', '2023-11-01', '15:00:00', 'Ожидается'),
(6, 13, 'Посадка', '2023-12-16', '15:00:00', 'Состоялся');


-- Data Insert into TABLE Airports_Flights:

INSERT INTO Airports_Flights (airport_id, flight_id) VALUES 
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);


-- Data Insert into TABLE Crews:

INSERT INTO Crews (flight_id, name, time_of_flight) VALUES 
(1, 'Экипаж 1', '2 months 15 days'),
(2, 'Экипаж 2', '1 month 20 days'),
(3, 'Экипаж 3', '3 months 5 days'),
(4, 'Экипаж 4', '1 month 10 days'),
(5, 'Экипаж 5', '4 months 2 days'),
(6, 'Экипаж 6', '2 months 25 days'),
(7, 'Экипаж 7', '1 month 15 days'),
(8, 'Экипаж 8', '3 months 10 days'),
(9, 'Экипаж 9', '2 months 0 days'),
(10, 'Экипаж 10', '5 months 5 days'),
(11, 'Экипаж 11', '5 months 5 days'),
(12, 'Экипаж 12', '5 months 5 days'),
(13, 'Экипаж 13', '5 months 5 days'),
(14, 'Экипаж 14', '5 months 5 days');


-- Data Insert into TABLE Crew_members:

INSERT INTO Crew_members (name, position, number_of_flights) VALUES 
('Иванов Алексей Сергеевич', 'Командир воздушного судна', 120),
('Петрова Мария Ивановна', 'Второй пилот', 95),
('Смирнов Иван Николаевич', 'Бортпроводник', 150),
('Кузнецова Елена Дмитриевна', 'Бортпроводник', 130),
('Попов Сергей Александрович', 'Второй пилот', 80),
('Васильева Ольга Петровна', 'Бортпроводник', 110),
('Соколов Николай Иванович', 'Командир воздушного судна', 140),
('Михайлова Анна Васильевна', 'Бортпроводник', 120),
('Новиков Дмитрий Сергеевич', 'Второй пилот', 100),
('Федорова Ирина Николаевна', 'Бортпроводник', 90);


-- Data Insert into TABLE Crews_Crew_members:

INSERT INTO Crews_Crew_members (crew_id, crew_member_id) VALUES 
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 7),
(2, 9),
(3, 5),
(3, 6),
(3, 2),
(3, 9),
(4, 7),
(4, 8),
(4, 9),
(5, 9),
(5, 1),
(5, 10);
