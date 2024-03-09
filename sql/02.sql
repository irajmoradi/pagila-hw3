/*
 * Compute the country with the most customers in it. 
 */
SELECT
    c.country
FROM
    customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country c ON ci.country_id = c.country_id
GROUP BY
    c.country
ORDER BY
    COUNT(cu.customer_id) DESC
LIMIT 1;

