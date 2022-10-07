WITH S AS (SELECT (Bidders.BidderID) UserID
            FROM Bidders
            WHERE Bidders.Country = "New York"
            UNION ALL
            SELECT (Sellers.SellerID) UserID
            FROM Sellers
            WHERE Sellers.Location = "New York")
SELECT COUNT(DISTINCT UserID)
FROM S;