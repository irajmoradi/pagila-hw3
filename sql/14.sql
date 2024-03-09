/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
WITH CategoryRentals AS (
    SELECT
        cat.name,
        f.title,
        COUNT(r.rental_id) AS total_rentals
    FROM
        rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    GROUP BY
        cat.name, f.title
),
RankedRentals AS (
    SELECT
        name,
        title,
        total_rentals,
        ROW_NUMBER() OVER (PARTITION BY name ORDER BY total_rentals DESC, title DESC) AS rental_rank
    FROM
        CategoryRentals
)
SELECT
    name,
    title,
    total_rentals as "total rentals"
FROM
    RankedRentals
WHERE
    rental_rank <= 5
ORDER BY
     name, "total rentals" DESC, title;

