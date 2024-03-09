/* 
 * You've decided that you don't actually like ACADEMY DINOSAUR and AGENT TRUMAN,
 * and want to focus on more movies that are similar to AMERICAN CIRCUS.
 * This time, however, you don't want to focus only on movies with similar actors.
 * You want to consider instead movies that have similar categories.
 *
 * Write a SQL query that lists all of the movies that share 2 categories with AMERICAN CIRCUS.
 * Order the results alphabetically.
 *
 * NOTE:
 * Recall that the following query lists the categories for the movie AMERICAN CIRCUS:
 * ```
 * SELECT name
 * FROM category
 * JOIN film_category USING (category_id)
 * JOIN film USING (film_id)
 * WHERE title = 'AMERICAN CIRCUS';
 * ```
 * This problem should be solved by a self join on the "film_category" table.
 */
SELECT
    f.title
FROM
    film f
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN (
    SELECT
        fc.category_id
    FROM
        film_category fc
    JOIN
        film f ON fc.film_id = f.film_id
    WHERE
        f.title = 'AMERICAN CIRCUS'
) AS ac_categories ON fc.category_id = ac_categories.category_id
GROUP BY
    f.title
HAVING
    COUNT(f.title) = 2 OR f.title = 'AMERICAN CIRCUS'
ORDER BY
    f.title;

