/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */
-- Movies with actors from AMERICAN CIRCUS
SELECT DISTINCT
    f.title
FROM
    film f
WHERE
    EXISTS (
        SELECT 1
        FROM film_actor fa
        JOIN film f2 ON fa.film_id = f2.film_id
        WHERE f2.title = 'AMERICAN CIRCUS' AND fa.actor_id IN (
            SELECT fa2.actor_id FROM film_actor fa2 WHERE fa2.film_id = f.film_id
        )
    )
AND EXISTS (
        SELECT 1
        FROM film_actor fa
        JOIN film f3 ON fa.film_id = f3.film_id
        WHERE f3.title = 'ACADEMY DINOSAUR' AND fa.actor_id IN (
            SELECT fa2.actor_id FROM film_actor fa2 WHERE fa2.film_id = f.film_id
        )
    )
AND EXISTS (
        SELECT 1
        FROM film_actor fa
        JOIN film f4 ON fa.film_id = f4.film_id
        WHERE f4.title = 'AGENT TRUMAN' AND fa.actor_id IN (
            SELECT fa2.actor_id FROM film_actor fa2 WHERE fa2.film_id = f.film_id
        )
    )
ORDER BY f.title;

