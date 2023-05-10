/*
	Створення таблиць
*/
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';
DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `population` int(10) unsigned DEFAULT NULL,
  `region` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
INSERT INTO `cities` (`id`, `name`, `population`, `region`) VALUES
(1,	'Київ',	2888470,	'N'),
(2,	'Харків',	1444540,	'E'),
(3,	'Одеса',	1010000,	'S'),
(4,	'Дніпро',	984423,	'C'),
(5,	'Донецьк',	932562,	'E'),
(6,	'Запоріжжя',	758011,	'E'),
(7,	'Львів',	728545,	'W'),
(8,	'Кривий Ріг',	646748,	'S'),
(9,	'Миколаїв',	494381,	'S'),
(10,	'Маріуполь',	458533,	'S'),
(11,	'Луганськ',	417990,	'E'),
(12,	'Севастополь',	412630,	'S'),
(13,	'Вінниця',	372432,	'W'),
(14,	'Макіївка',	348173,	'E'),
(15,	'Сімферополь',	332608,	'S'),
(16,	'Херсон',	296161,	'S'),
(17,	'Полтава',	294695,	'E'),
(18,	'Чернігів',	294522,	'N'),
(19,	'Черкаси',	284459,	'C'),
(20,	'Суми',	268409,	'E'),
(21,	'Житомир',	268000,	'N'),
(22,	'Хмельницький',	267891,	'W'),
(23,	'Чернівці',	264427,	'W'),
(24,	'Горлівка',	250991,	'E'),
(25,	'Рівне',	249477,	'W'),
(26,	'Кам\'янське',	240477,	'C'),
(27,	'Кропивницький',	232052,	'C'),
(28,	'Івано-Франківськ',	229447,	'W'),
(29,	'Кременчук',	224997,	'C'),
(30,	'Тернопіль',	217950,	'W'),
(31,	'Луцьк',	217082,	'W'),
(32,	'Біла Церква',	211080,	'N'),
(33,	'Краматорськ',	160895,	'E'),
(34,	'Мелітополь',	156719,	'S'),
(35,	'Керч',	147668,	'S'),
(36,	'Сєвєродонецьк',	130000,	'E'),
(37,	'Хрустальний',	124000,	'E'),
(38,	'Нікополь',	119627,	'C'),
(39,	'Бердянськ',	115476,	'S'),
(40,	'Слов\'янськ',	115421,	'E'),
(41,	'Ужгород',	115195,	'W'),
(42,	'Алчевськ',	111360,	'E'),
(43,	'Павлоград',	110144,	'E'),
(44,	'Євпаторія',	106115,	'S'),
(45,	'Лисичанськ',	103459,	'E'),
(46,	'Кам\'янець-Подільський',	101590,	'W'),
(47,	'Бровари',	100374,	'N'),
(48,	'Дрогобич',	98015,	'W'),
(49,	'Кадіївка',	92132,	'E'),
(50,	'Конотоп',	92000,	'E');
DROP TABLE IF EXISTS `regions`;
CREATE TABLE `regions` (
  `uuid` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `area_quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
INSERT INTO `regions` (`uuid`, `name`, `area_quantity`) VALUES
('C',	'Center',	5),
('E',	'East',	3),
('N',	'Nord',	4),
('S',	'South',	5),
('W',	'West',	8);

/*
	Отримати назву міста і назву регіону в якому знаходиться місто
	У результат мають потрапити міста з населенням більше ніж 350 000
*/
SELECT name, region
FROM cities
WHERE population > 350000;

/*
	За допомогою поєднань двох таблиць отримати міста яки знаходяться у регіоні з назвою Nord
*/
SELECT cities.name, cities.region
FROM cities
JOIN regions ON cities.region = regions.uuid
WHERE regions.name = 'Nord';

/*
	Створити структуру таблиць яка б дозволяла зберігати та однозначно відтворювати мапу будь якого метро світу
	Для прикладу наведено мапу харківського метрополітену
*/
DROP TABLE IF EXISTS `connections`;
DROP TABLE IF EXISTS `stations`;
DROP TABLE IF EXISTS `lines`;
CREATE TABLE `lines` (							/*	Таблиця ліній					*/
	`id` INTEGER PRIMARY KEY,					/*	Ідентифікатор лінії				*/
	`name` TEXT NOT NULL,						/*	Назва лінії						*/
	`color` TEXT NOT NULL						/*	Колір лінії						*/
);
CREATE TABLE `stations` (						/*	Таблиця станцій					*/
	`id` INTEGER PRIMARY KEY,					/*	Ідентифікатор станції			*/
	`name` TEXT NOT NULL,						/*	Назва станції					*/
	`line_id` INTEGER NOT NULL,					/*	Ідентифікатор зв'язаної лінії	*/
	FOREIGN KEY (`line_id`) REFERENCES `lines`(`id`)
);
CREATE TABLE `connections` (					/*	Таблиця зв'язків				*/	
	`id` INTEGER PRIMARY KEY,					/*	Ідентифікатор зв'язку			*/	
	`left_station_id` INTEGER NOT NULL,			/*	Станція "праворуч" зв'язку		*/
	`right_station_id` INTEGER NOT NULL,		/*	Станція "ліворуч" зв'язку		*/
	FOREIGN KEY (`left_station_id`) REFERENCES `stations`(`id`),
	FOREIGN KEY (`right_station_id`) REFERENCES `stations`(`id`)
);
/*
	Вхідні дані для формування системи Харківського метрополітену
*/
INSERT INTO `lines` (id, name, color) VALUES
(1, 'Олексіївська', 'зелений'),
(2, 'Салтівська', 'синій'),
(3, 'Холодногірсько-Заводська', 'червоний');
INSERT INTO stations (id, name, line_id) VALUES
(1, 'Перемога', 1),
(2, 'Олексіївка', 1),
(3, '23 серпня', 1),
(4, 'Ботанічний сад', 1),
(5, 'Наукова', 1),
(6, 'Держпром', 1),
(7, 'Архітектора Бекетова', 1),
(8, 'Захисників України', 1),
(9, 'Метробудівників', 1),
(10, 'Героїв праці', 2),
(11, 'Студентська', 2),
(12, 'Академіка Павлова', 2),
(13, 'Академіка Барабашова', 2),
(14, 'Київська', 2),
(15, 'Пушкінська', 2),
(16, 'Університет', 2),
(17, 'Історичний музей', 2),
(18, 'Холодна гора', 3),
(19, 'Південний вокзал', 3),
(20, 'Центральний ринок', 3),
(21, 'Майдан конституції', 3),
(22, 'Проспект Гагаріна', 3),
(23, 'Спортивна', 3),
(24, 'Завод ім. Малишева', 3),
(25, 'Турбоатом', 3),
(26, 'Палац спорту', 3),
(27, 'Армійська', 3),
(28, 'ім. О.С.Масельського', 3),
(29, 'Тракторний завод', 3),
(30, 'Індустріальна', 3);
INSERT INTO connections (id, left_station_id, right_station_id) VALUES
(1, 6, 16),
(2, 21, 17),
(3, 9, 23);
/*
	Запити на виведення інформації про метрополітен
*/
/*
	Вивести всі лінії метрополітену з назвами та кольорами
*/
SELECT name, color FROM `lines`;

/*
	Вивести всі станції метрополітену з їх назвами та назвами ліній, до яких вони належать
*/
SELECT stations.name, lines.name AS line_name
FROM stations
JOIN `lines` ON stations.line_id = `lines`.id;

/*
	Вивести всі зв'язки між станціями
*/
SELECT left_station.name AS left_station_name, right_station.name AS right_station_name
FROM connections
JOIN stations AS left_station ON connections.left_station_id = left_station.id
JOIN stations AS right_station ON connections.right_station_id = right_station.id;
