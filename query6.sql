SELECT COUNT(Sellers.SellerID) SellerAndBidder
FROM Sellers, Bidders
WHERE (Sellers.SellerID = Bidders.BidderID);