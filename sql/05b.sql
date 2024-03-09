/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
SELECT
    f.title
FROM
    film_actor fa
JOIN film f ON fa.film_id = f.film_id
WHERE fa.actor_id IN (
    SELECT
        fa2.actor_id
    FROM
        film_actor fa2
    JOIN film f2 ON fa2.film_id = f2.film_id
    WHERE f2.title = 'AMERICAN CIRCUS'
)
GROUP BY f.title
HAVING COUNT(DISTINCT fa.actor_id) >= 2
ORDER BY f.title;

