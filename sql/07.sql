/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
-- Actors with Bacall Number 1
-- -- Actors with Bacall Number 1
WITH BacallNumber1 AS (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film_actor fa2 ON fa.film_id = fa2.film_id
    JOIN actor a ON fa2.actor_id = a.actor_id
    WHERE a.first_name = 'RUSSELL' AND a.last_name = 'BACALL'
),

-- Actors with Bacall Number 2
BacallNumber2 AS (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE EXISTS (
        SELECT 1
        FROM film_actor fa2
        JOIN actor a2 ON fa2.actor_id = a2.actor_id
        WHERE fa2.film_id = f.film_id AND fa2.actor_id IN (SELECT actor_id FROM BacallNumber1)
    ) AND NOT fa.actor_id IN (SELECT actor_id FROM BacallNumber1)
)

SELECT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
WHERE a.actor_id IN (SELECT actor_id FROM BacallNumber2)
ORDER BY "Actor Name";

