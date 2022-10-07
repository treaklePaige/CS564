SELECT DISTINCT COUNT(Bidders.BidderID + Sellers.SellerID)
FROM Bidders, Sellers;