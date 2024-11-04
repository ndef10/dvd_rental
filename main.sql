-- ================================================================================================================================

--  Construye las siguientes consultas:

-- =============================================================================================================CONSULTA 1=========

--  • Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.

-- =============================================================================INSERTAR=============================================

--  Insertar Staff:
--  1
INSERT INTO country (country, last_update) 
    VALUES ('Chile chico', date_trunc('second',CURRENT_TIMESTAMP));

-- Consultar si se inserto correctamente:
SELECT * FROM country ORDER BY country_id DESC LIMIT 10;

--  2
INSERT INTO city (city, country_id, last_update) 
    VALUES ('Santiago', 110, date_trunc('second',CURRENT_TIMESTAMP));

-- Consultar si se inserto correctamente:
SELECT * FROM city ORDER BY city_id DESC LIMIT 10;

--  3
INSERT INTO address (address, address2, district, city_id, postal_code, phone, last_update)
    VALUES ('227 San Antonio', '.......', 'Provida', 110, 66666, 14033335568, date_trunc('second',CURRENT_TIMESTAMP));

-- Consultar si se inserto correctamente:
SELECT * FROM address ORDER BY address_id DESC LIMIT 10;

--  4
INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, username, password, last_update, picture)
    VALUES ('Pierre', 'Gasly', 606, 'pierreGasly@gmail.com', 1, 't', 'Pierre', '123456', SUBSTRING(CURRENT_TIMESTAMP::TEXT, 1, 25)::TIMESTAMP, 'descarga.jpeg');

--  Comprobar insersion Staff:
SELECT * FROM staff ORDER BY staff_id DESC LIMIT 10;


--  Insertar Customer:
--  5
INSERT INTO store (manager_staff_id, address_id, last_update)
    VALUES (5, 606, date_trunc('second',CURRENT_TIMESTAMP));

-- Consultar si se inserto correctamente:
SELECT * FROM store ORDER BY store_id DESC LIMIT 10;

--  6
INSERT INTO customer (store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active)
    VALUES ('3', 'Fernando', 'Alonso', 'cahrlesLeclerc@gmail.com', 606, 't', now(), SUBSTRING(CURRENT_TIMESTAMP::TEXT, 1, 23)::TIMESTAMP, 1);

--  Comprobar insersion Customer:
SELECT * FROM customer                                                                                                 
    ORDER BY customer_id DESC                                                                                                                 
    LIMIT 10;


--  Insertar Actor:
INSERT INTO actor (first_name, last_name, last_update)
    VALUES ('Matt', 'Damon', SUBSTRING(CURRENT_TIMESTAMP::TEXT, 1, 22)::TIMESTAMP);


--  Comprobar insersion Actor:
SELECT * FROM actor ORDER BY actor_id DESC LIMIT 10;

-- ======================================================================ELIMINAR=================================================


-- Eliminar un Staff:
DELETE FROM store WHERE store_id = 6;
DELETE FROM staff WHERE staff_id = 4;

--  Comprobar eliminacion de Staff:
SELECT * FROM staff;

-- Eliminar un Customer:
DELETE FROM customer WHERE customer_id = 605;

--  Comprobar eliminacion de Customer:
SELECT * FROM customer                                                                                                 
    ORDER BY customer_id DESC                                                                                                                 
    LIMIT 10;

-- Eliminar un actor:
DELETE FROM actor WHERE actor_id = 208;

--  Comprobar eliminacion de Actor:
SELECT * FROM actor
    ORDER BY actor_id DESC
    LIMIT 10;

-- ======================================================================MODIFICAR=================================================

-- Modificar Staff:
UPDATE staff 
SET first_name = 'Maximo'
WHERE staff_id = 3;

-- Modificar Customer:
UPDATE customer 
SET email = 'sergioPerez@gmail.com'
WHERE customer_id = 606;

-- Modificar actor:
UPDATE actor 
SET last_name = 'Achurra'
WHERE first_name = 'Patricio';


-- =============================================================================================================CONSULTA 2=========

--  • Listar todas las “rental” con los datos del “customer” dado un año y mes.
-- SELECT * FROM rental AS R INNER JOIN customer AS C ON R.customer_id = C.customer_id WHERE date_trunc('month', R.rental_date) = '2005-05-01' LIMIT 10;

SELECT rental_date, store_id, first_name, last_name, email, A.address, activebool, create_date, active 
    FROM rental AS R INNER JOIN customer AS C 
    ON R.customer_id = C.customer_id 

    INNER JOIN address AS A
    ON C.address_id = A.address_id

    WHERE EXTRACT(YEAR FROM R.rental_date) = 2005 
    AND EXTRACT(MONTH FROM R.rental_date) = 5 
    LIMIT 10;

-- ===============================================================================================================CONSULTA 3========

--  • Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
SELECT amount, MAX(payment_date) AS last_payment_date, count(*)FROM payment GROUP BY amount ORDER BY amount DESC;

-- ===============================================================================================================CONSULTA 4========

--  • Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.

SELECT release_year, title, rental_rate FROM film WHERE release_year = 2006 AND rental_rate > '4.0' LIMIT 10;

-- ===============================================================================================================CONSULTA 5========

-- Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si
-- éstas pueden ser nulas, y su tipo de dato correspondiente.

SELECT table_name, column_name, is_nullable, data_type FROM information_schema.columns WHERE table_schema = 'public' ORDER BY table_name, column_name;
