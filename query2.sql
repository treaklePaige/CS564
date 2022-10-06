SELECT COUNT(Bidders.BidderID + Sellers.SellerID)
FROM Bidders, Sellers
WHERE Bidders.Location = "New York" AND Sellers.Location = "New York";