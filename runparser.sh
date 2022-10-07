rm -f *.dat
python parser.py ebay_data/items-*.json
sort ItemsWithDuplicates.dat | uniq > Items.dat
sort CategoriesWithDuplicates.dat | uniq > Categories.dat
sort BidsWithDuplicates.dat | uniq > Bids.dat
sort BiddersWithDuplicates.dat | uniq > Bidders.dat
sort SellersWithDuplicates.dat | uniq > Sellers.dat
rm -f *WithDuplicates.dat