
WITH S AS (SELECT MAX(Currently) Currently
            FROM Items
            ORDER BY Currently
            LIMIT 1)
SELECT Items.ItemID
FROM Items, S
WHERE Items.Currently = S.Currently;

