WITH F AS (SELECT COUNT(CategoryName) CategoryNum
    FROM Categories
    GROUP BY ItemID)
SELECT COUNT(F.CategoryNum)
FROM F
WHERE F.CategoryNum = 4;