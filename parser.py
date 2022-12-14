
"""
FILE: skeleton_parser.py
------------------
Author: Firas Abuzaid (fabuzaid@stanford.edu)
Author: Perth Charernwattanagul (puch@stanford.edu)
Modified: 04/21/2014

Skeleton parser for CS564 programming project 1. Has useful imports and
functions for parsing, including:

1) Directory handling -- the parser takes a list of eBay json files
and opens each file inside of a loop. You just need to fill in the rest.
2) Dollar value conversions -- the json files store dollar value amounts in
a string like $3,453.23 -- we provide a function to convert it to a string
like XXXXX.xx.
3) Date/time conversions -- the json files store dates/ times in the form
Mon-DD-YY HH:MM:SS -- we wrote a function (transformDttm) that converts to the
for YYYY-MM-DD HH:MM:SS, which will sort chronologically in SQL.

Your job is to implement the parseJson function, which is invoked on each file by
the main function. We create the initial Python dictionary object of items for
you; the rest is up to you!
Happy parsing!
"""

import sys
from json import loads
from re import sub

columnSeparator = "|"
alreadyAddedBidderIDs = []
alreadyAddedSellerIDs = []
Quote = '"'


# Dictionary of months used for date transformation
MONTHS = {'Jan':'01','Feb':'02','Mar':'03','Apr':'04','May':'05','Jun':'06',\
        'Jul':'07','Aug':'08','Sep':'09','Oct':'10','Nov':'11','Dec':'12'}

"""
Returns true if a file ends in .json
"""
def isJson(f):
    return len(f) > 5 and f[-5:] == '.json'

"""
Converts month to a number, e.g. 'Dec' to '12'
"""
def transformMonth(mon):
    if mon in MONTHS:
        return MONTHS[mon]
    else:
        return mon

"""
Transforms a timestamp from Mon-DD-YY HH:MM:SS to YYYY-MM-DD HH:MM:SS
""" 
def transformDttm(dttm):
    dttm = dttm.strip().split(' ')
    dt = dttm[0].split('-')
    date = '20' + dt[2] + '-'
    date += transformMonth(dt[0]) + '-' + dt[1]
    return date + ' ' + dttm[1]

"""
Transform a dollar value amount from a string like $3,453.23 to XXXXX.xx
"""

def transformDollar(money):
    if money == None or len(money) == 0:
        return money
    return sub(r'[^\d.]', '', money)

"""
Parses a single json file. Currently, there's a loop that iterates over each
item in the data set. Your job is to extend this functionality to create all
of the necessary SQL tables for your database.
"""
def parseJson(json_file):
    with open(json_file, 'r') as f:
        items = loads(f.read())['Items'] # creates a Python dictionary of Items for the supplied json file
        ItemDB = open("ItemsWithDuplicates.dat", 'a')
        CategoryDB = open("CategoriesWithDuplicates.dat", 'a')
        BidDB = open("BidsWithDuplicates.dat", 'a')
        BuyerDB = open("BiddersWithDuplicates.dat", 'a')
        SellerDB = open("SellersWithDuplicates.dat", 'a')
        
        # Starting by creating a local value of all of the attributes in items that 
        # we are going to need right away
        for item in items:
            ItemID = item['ItemID']
            Name = item['Name'].replace('"', '""')
            Description = item['Description'].replace('"', '""') if item['Description'] is not None else ""
            Currently = transformDollar(item['Currently'])
            NumBids = item['Number_of_Bids']
            FirstBid = transformDollar(item['First_Bid'])
            BuyPrice = transformDollar(item.get('Buy_Price', 'NULL'))
            Started = transformDttm(item['Started'])
            Ends = transformDttm(item['Ends'])
            Location = item.get('Location', 'NULL').replace('"', '""') if item.get('Location', 'NULL') is not None else ""
            Country = item.get('Country', 'NULL')
            Categories = item['Category']
            Bids = item["Bids"]
            SellingUser = item['Seller']
            SellID = SellingUser['UserID']
            Rating = SellingUser['Rating']

            #Load into the files
            #Item File Data Loading:
            AddToItem = '|'.join([ItemID, Quote+SellID+Quote, Quote+Name+Quote, Quote+Description+Quote, Currently, NumBids, FirstBid, BuyPrice, Started, Ends]) + '\n'
            ItemDB.write(AddToItem)
            
            #Category File Data Loading
            for cat in Categories:
                # AddToCat = ('"' + ItemID + '"|"' +str(cat)+ '"\n') 
                AddToCat = '|'.join([ItemID, Quote+str(cat)+Quote]) + '\n' 
                CategoryDB.write(AddToCat)
                
            #Bid File Data Loading (since already parsing bids, also adding bidders to userDB)
            if item["Bids"] is not None:
                for i in range(len(Bids)):
                    thisBid = Bids[i]["Bid"]

                    AddToBids = '|'.join([ItemID, Quote+thisBid["Bidder"]["UserID"]+Quote, transformDttm(thisBid["Time"]), transformDollar(thisBid.get("Amount"))]) + '\n'
                    BidDB.write(AddToBids)

                    thisBidUserID = thisBid["Bidder"]["UserID"]
                    if thisBidUserID not in alreadyAddedBidderIDs:
                        alreadyAddedBidderIDs.append(thisBidUserID)
                        AddToBidder = '|'.join([Quote+thisBid["Bidder"]["UserID"]+Quote, thisBid["Bidder"]["Rating"], Quote+Location+Quote, Quote+Country+Quote]) + '\n'
                        BuyerDB.write(AddToBidder)
                        
                
            
            #User file Data Loading this is for sellers because we already covered bidders
            if SellID not in alreadyAddedSellerIDs:
                alreadyAddedSellerIDs.append(SellID)
                AddtoSeller = '|'.join([Quote+SellID+Quote, Rating, Quote+Location+Quote, Quote+Country+Quote]) + '\n'
                SellerDB.write(AddtoSeller)
    
            
            
        ItemDB.close()
        CategoryDB.close()
        BidDB.close()
        BuyerDB.close()
        SellerDB.close()
            
            

"""
Loops through each json files provided on the command line and passes each file
to the parser
"""
def main(argv):
    if len(argv) < 2:
        print >> sys.stderr, 'Usage: python parser.py <path to json files>'
        sys.exit(1)
    # loops over all .json files in the argument
    for f in argv[1:]:
        if isJson(f):
            parseJson(f)
            print("Success parsing " + f)

if __name__ == '__main__':
    main(sys.argv)
