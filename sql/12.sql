/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
WITH CustomerRentals AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        f.film_id,
        r.rental_date,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY r.rental_date DESC) AS recent_rank
    FROM
        customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
),
ActionRentals AS (
    SELECT
        cr.customer_id,
        COUNT(*) FILTER (WHERE cat.name = 'Action') AS action_count,
        COUNT(*) AS total_count
    FROM
        CustomerRentals cr
    JOIN film_category fc ON cr.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    WHERE
        cr.recent_rank <= 5
    GROUP BY
        cr.customer_id
    HAVING
        COUNT(*) FILTER (WHERE cat.name = 'Action') >= 4
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    customer c
JOIN ActionRentals ar ON c.customer_id = ar.customer_id
ORDER BY
    c.customer_id;
