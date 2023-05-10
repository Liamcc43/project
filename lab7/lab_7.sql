/*
	Створення таблиць
*/
DROP TABLE IF EXISTS `comments`;
DROP TABLE IF EXISTS `news`;
DROP TABLE IF EXISTS `categories`;
CREATE TABLE categories (											/*	Таблиця категорій											*/
    id INT AUTO_INCREMENT PRIMARY KEY,								/*	Номер категорії												*/
    name VARCHAR(255) NOT NULL										/*	Назва категорії												*/
);
CREATE TABLE news (													/*	Таблиця новин												*/
    id INT AUTO_INCREMENT PRIMARY KEY,								/*	Номер новини												*/
    category_id INT NOT NULL,										/*	Номер категорії												*/
    title VARCHAR(255) NOT NULL,									/*	Назва новини												*/
    content TEXT NOT NULL,											/*	Текст новини												*/
    publish_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,				/*	Дата публікації												*/
    FOREIGN KEY (category_id) REFERENCES categories(id)				/*	Зв'язування таблиці категорій з таблицею новин				*/	
);
CREATE TABLE comments (												/*	Таблиця коментарів											*/
    id INT AUTO_INCREMENT PRIMARY KEY,								/*	Номер коментаря												*/
    news_id INT NOT NULL,											/*	Номер новини												*/
    ip_address VARCHAR(255) NOT NULL,								/*	ІП адреса відправника										*/	
    sender_name VARCHAR(255) NOT NULL,								/*	Ім'я відправника											*/
    content TEXT NOT NULL,											/*	Текст коментаря												*/
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),		/*	Оцінка від 1 до 5											*/
    FOREIGN KEY (news_id) REFERENCES news(id)						/*	Зв'язування таблиці новин з таблицею коментарів				*/
);
ALTER TABLE comments ADD UNIQUE unique_index (news_id, ip_address);	/*	Лише один коментар з однієї іп адреси для кожної новини		*/

/*
	Заповнення бази даних
*/
INSERT INTO categories (name) VALUES
	('Політика'), 
	('Спорт'),
	('Технології');
INSERT INTO news (category_id, title, content) VALUES 
	(1, 'Новини про політику', 'Сьогодні відбулась зустріч президента з лідерами опозиції.'),
	(2, 'Футбольні новини', 'Сьогоднішній матч завершився нічиєю з рахунком 1:1.'),
	(3, 'Новітні технології', 'Компанія X анонсувала випуск нового смартфона з трьома камерами.'),
	(3, 'Нова технологія', 'Цікава новина про нову технологію.');
INSERT INTO comments (news_id, ip_address, sender_name, content, rating) VALUES
	(1, '192.168.1.1', 'Віктор', 'Цікава стаття, але я не згоден зі деякими думками автора.', 4),
	(1, '192.168.1.2', 'Олександра', 'Дуже цікава стаття, дякую за детальний опис події.', 5),
	(2, '192.168.1.3', 'Микола', 'Дуже добрий матч, я думаю, що обидві команди зробили свій кращий внесок.', 3),
	(3, '192.168.1.4', 'Анна', 'Дякую за статтю! Дуже цікаво.', 5),
	(2, '192.168.1.5', 'Ігор', 'Я бачив цей матч вживу, і могу сказати, що було дуже напружено.', 4),
	(4, '192.168.1.6', 'Ольга', 'Вражаюча новина. Сподіваюсь, що все закінчиться гладко.', 5);

/*
	Запити до бази даних
*/
/*
	Виведення усіх категорій
*/
SELECT * FROM categories;

/*
	Виведення усіх новин та інформації про них
*/
SELECT 
    categories.name AS 'Категорія',
    news.title 'Заголовок',
    news.content 'Текст',
    news.publish_date 'Дата публікації',
    COUNT(comments.id) AS 'Кількість коментарів',
    AVG(comments.rating) AS 'Середня оцінка'
FROM 
    news
    INNER JOIN categories ON news.category_id = categories.id
    LEFT JOIN comments ON news.id = comments.news_id
GROUP BY 
    news.id
ORDER BY 
    news.publish_date DESC;

/*
	Виведення усіх коментарів для кожної новини
*/
SELECT 
    news.title AS 'Новина',
    comments.ip_address AS 'ІП адреса',
    comments.sender_name AS 'Ім\'я відправника',
    comments.content AS 'Коментар',
    comments.rating AS 'Оцінка'
FROM 
    news
    INNER JOIN comments ON news.id = comments.news_id
ORDER BY 
    news.title ASC;
