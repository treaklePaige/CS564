WITH S AS (SELECT (Bidders.BidderID) UserID
            FROM Bidders
            UNION ALL
            SELECT (Sellers.SellerID) UserID
            FROM Sellers)
SELECT COUNT(DISTINCT UserID)
FROM S;
