JSON_DIR="./ebay_data"
SCRIPT_PATH="./parser.py"
CATEGORY_TB="./Categories.dat"
ITEMS_TB="./Items.dat"
BIDS_TB="./Bids.dat"
Sellers_TB="./Sellers.dat"
Buyers_TB = "./Buyers.dat"
rm -f $CATEGORY_TB
rm -f $ITEMS_TB
rm -f $BIDS_TB
rm -f $Sellers_TB
rm -f $Buyers_TB
for i in $(ls $JSON_DIR); do
  python $SCRIPT_PATH $JSON_DIR/$i
done
sort -u $CATEGORY_TB -o $CATEGORY_TB
sort -u $ITEMS_TB -o $ITEMS_TB
sort -u $BIDS_TB -o $BIDS_TB
sort -u $Sellers_TB -o $Sellers_TB
sort -u $Buyers_TB -o $Buyers_TB
