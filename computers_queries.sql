-- Задание 1
-- Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. 
-- Вывести: model, speed и hd
SELECT model, speed, hd
FROM PC
WHERE price < 500;

-- Задание 2
-- Найдите производителей принтеров. 
-- Вывести: maker
SELECT DISTINCT maker 
FROM Product  
WHERE type = 'Printer';

-- Задание 3
-- Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
SELECT model, ram, screen
FROM laptop
WHERE price > 1000;

-- Задание 4
-- Найдите все записи таблицы Printer для цветных принтеров.
SELECT *
FROM Printer
WHERE color = 'y';

-- Задание 5
-- Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
SELECT model, speed, hd
FROM pc
WHERE
	cd IN ('12x', '24x')
	AND price < 600;

-- Задание 6
-- Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, 
-- найти скорости таких ПК-блокнотов. 
-- Вывод: производитель, скорость.
SELECT DISTINCT product.maker, laptop.speed
FROM product, laptop
WHERE product.model = laptop.model
	AND laptop.hd >= 10;

-- Второй вариант решения.
SELECT DISTINCT Product.maker, Laptop.speed
FROM Product JOIN 
 Laptop ON Product.model = Laptop.model 
WHERE Laptop.hd >= 10;

-- Задание 7
-- Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B.
SELECT DISTINCT product.model, price
FROM product
JOIN laptop ON product.model = laptop.model
WHERE product.maker = 'B'

UNION ALL

SELECT DISTINCT product.model, price
FROM product
JOIN pc ON product.model = pc.model
WHERE product.maker = 'B'

UNION ALL

SELECT DISTINCT product.model, price
FROM product
JOIN printer ON product.model = printer.model
WHERE product.maker = 'B';

-- Задание 8
-- Найдите производителя, выпускающего ПК, но не ПК-блокноты.
SELECT DISTINCT maker
FROM product
WHERE type = 'PC' 
EXCEPT
SELECT DISTINCT maker
FROM product
WHERE type = 'Laptop';

-- Решение 2. Чрезмерно заумное
select maker
from (
select maker, 
sum(case type when 'PC' then 1 else 0 end) as pc,
sum(case type when 'Laptop' then 1 else 0 end) as laptop
 from 
Product
group by maker
) a
where a.pc > 0 and a.laptop = 0;

-- Задание 9
-- Найдите производителей ПК с процессором не менее 450 Мгц. 
-- Вывести: Maker
SELECT DISTINCT product.maker
FROM product
JOIN pc ON pc.model = product.model
WHERE speed >= 450;

-- Задание 10
-- Найдите модели принтеров, имеющих самую высокую цену. 
-- Вывести: model, price
SELECT uq.model, uq.price
FROM
	(
	SELECT p.model, p.price, rank() OVER (ORDER BY price DESC) AS price_rank
	FROM printer p
	) uq
WHERE uq.price_rank = 1

-- Задание 11
-- 