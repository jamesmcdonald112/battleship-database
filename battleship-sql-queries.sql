-- Select the names of ships and their outcomes (results) from the 'Outcomes' table
-- where the battle is 'Pearl Harbor', and order the results by ship names in ascending order.
SELECT 
    ship,
    result
FROM
    Outcomes
WHERE
    battle = 'Pearl Harbor'
ORDER BY 
    ship ASC;



-- Select the class and numGuns of ship classes from the 'Classes' table
-- where the number of guns (numGuns) is equal to the maximum number of guns.
-- The subquery (SELECT MAX(numGuns) FROM Classes) identifies the highest numGuns value in the table.
-- The rows matching this maximum value are included in the result.
-- The result is sorted by the class name in ascending order.
SELECT 
    class, 
    numGuns 
FROM 
    Classes
WHERE 
    numGuns = (SELECT MAX(numGuns) FROM Classes)
ORDER BY 
    class;

-- Query to find the country that produced the highest number of battleship (bb) classes
-- 1. SELECT `country` and the count of rows (battleship classes) grouped by country.
-- 2. COUNT(*) counts all rows in each group where `type` is 'bb' (battleship).
-- 3. Filter the rows to include only battleship classes using the WHERE clause (`type = 'bb'`).
-- 4. GROUP BY groups the results by `country` to calculate the count for each country.
-- 5. ORDER BY sorts the results in descending order based on the count of battleship classes (`num_battleships`).
-- 6. LIMIT 1 ensures only the top country with the maximum number of battleship classes is returned.
SELECT 
    country, 
    COUNT(*) as num_battleships
FROM 
    Classes
WHERE 
    type = 'bb'
GROUP BY
    country
ORDER BY 
    num_battleships DESC
LIMIT 1;



-- Query to find the number of sunken ships attributed to each country
-- 1. SELECT `c.country` and the count of `o.result` where the result is "sunk".
-- 2. JOIN `Classes` (c) with `Ships` (s) on the ship's class to associate ships with their classes.
-- 3. JOIN `Ships` (s) with `Outcomes` (o) on the ship's name to link ships with their outcomes in battles.
-- 4. WHERE clause filters results to include only rows where `o.result = "sunk"`.
-- 5. GROUP BY `c.country` to aggregate the count of sunken ships for each country.
-- 6. ORDER BY `num_sunk_ships DESC` to sort the results from the highest to the lowest number of sunken ships.
SELECT 
    c.country, 
    COUNT(o.result) as num_sunk_ships
FROM 
    Classes c 
JOIN Ships s
    ON c.class = s.class
JOIN Outcomes o
    ON s.name = o.ship 
WHERE 
	o.result = "sunk"
GROUP BY 
    c.country
ORDER BY 
    num_sunk_ships DESC



-- Query to find the ships with the earliest launch dates for each country
-- 1. SELECT the ship name (`s.name`), launch date (`s.launched`), and country of origin (`c.country`).
-- 2. JOIN the `Ships` table (`s`) with the `Classes` table (`c`) on the `class` column 
--    to associate each ship with its respective country.
-- 3. Use a WHERE clause with a subquery to filter ships that match the earliest launch date 
--    for their respective country:
--    a. Subquery retrieves the minimum launch date (`MIN(s2.launched)`) for each country (`c2.country`).
--    b. GROUP BY groups the subquery results by `c2.country` to calculate the earliest launch date for each country.
--    c. The main query filters ships where the combination of country and launch date matches the subquery result.
-- 4. ORDER BY the launch date (`s.launched`) in ascending order for chronological results.

SELECT 
    s.name,       -- Ship name
    s.launched,   -- Launch date
    c.country     -- Country of origin
FROM 
    Ships s
JOIN Classes c 
    ON s.class = c.class -- Join to associate ships with their respective countries
WHERE 
    (c.country, s.launched) IN (
        SELECT 
            c2.country,              -- Country of origin
            MIN(s2.launched)         -- Earliest launch date for that country
        FROM 
            Ships s2
        JOIN Classes c2 
            ON s2.class = c2.class   -- Join for the subquery to link ships and classes
        GROUP BY 
            c2.country               -- Group by country to calculate earliest launch date
    )
ORDER BY 
    s.launched ASC; -- Sort results by launch date in ascending order