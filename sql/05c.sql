/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */
WITH SpecifiedMoviesActors AS (
    SELECT
        fa.actor_id,
        COUNT(fa.actor_id) AS appearance_count -- Counts how many of the specified movies each actor appears in.
    FROM
        film_actor fa
    JOIN
        film f ON fa.film_id = f.film_id
    WHERE
        f.title IN ('ACADEMY DINOSAUR', 'AGENT TRUMAN', 'AMERICAN CIRCUS')
    GROUP BY
        fa.actor_id
),
ActorAppearancesInOtherMovies AS (
    SELECT
        fa.film_id,
        SUM(sma.appearance_count) AS total_appearances -- Sums up the appearances for actors in other movies.
    FROM
        film_actor fa
    JOIN
        SpecifiedMoviesActors sma ON fa.actor_id = sma.actor_id
    GROUP BY
        fa.film_id
    HAVING
        SUM(sma.appearance_count) >= 3 -- Ensures the movie has actors with at least 3 appearances in the specified movies.
),
QualifiedMovies AS (
    SELECT
        f.film_id,
        f.title
    FROM
        film f
    JOIN
        ActorAppearancesInOtherMovies aaom ON f.film_id = aaom.film_id
)
SELECT
    qm.title
FROM
    QualifiedMovies qm
ORDER BY
    qm.title;

