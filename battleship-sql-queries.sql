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