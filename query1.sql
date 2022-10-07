SELECT 
    Num1.NumberOfSellers
  + Num2.NumberOfBidders
  - Num3.NumberOfUsersThatAreBiddersAndSellers 
FROM 
  (SELECT COUNT(*) AS NumberOfSellers FROM Sellers) AS Num1, 
  (SELECT COUNT(*) AS NumberOfBidders FROM Bidders) AS Num2, 
  (SELECT COUNT(*) AS NumberOfUsersThatAreBiddersAndSellers FROM Bidders,Sellers WHERE Bidders.BidderID = Sellers.SellerID) AS Num3;
