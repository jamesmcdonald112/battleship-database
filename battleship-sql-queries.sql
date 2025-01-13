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