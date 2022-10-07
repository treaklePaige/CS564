SELECT COUNT(DISTINCT Categories.CategoryName)
FROM Categories, Items, Bids
WHERE (Categories.ItemID = Items.ItemID) AND (Items.ItemID = Bids.ItemID) AND (Bids.Amount > 100);