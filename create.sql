drop table if exists Items;
drop table if exists EbayUsers;
drop table if exists Categories;
drop table if exists Bids;

create table Items(ItemID            INTEGER        NOT NULL  PRIMARY KEY,
                   FOREIGN KEY (SellerID) REFERENCES Seller(SellerID) 
                   Name              VARCHAR(300)   NOT NULL,
                   Description       VARCHAR(500)   NOT NULL,
                   Currently         VARCHAR(300)   NOT NULL,
                   Number_of_Bids    INTEGER        NOT NULL,
                   First_Bid         VARCHAR(300)   NOT NULL,
                   Buy_Price         VARCHAR(300),    
                   Started           TIMESTAMP      NOT NULL,
                   Ends              TIMESTAMP      NOT NULL
                   );
create table Bidder(BidderID         VARCHAR(300)   NOT NULL  PRIMARY KEY,
                      BidderRating         INTEGER         NOT NULL,
                      Country        VARCHAR(300),   
                      Location       VARCHAR(300)
                      
create table Seller(SellerID         VARCHAR(300)   NOT NULL  PRIMARY KEY,
                      SellerRating         INTEGER         NOT NULL,
                      Country        VARCHAR(300), 
                      Location       VARCHAR(300)  
                    );
create table Categories(CategoryName VARCHAR(300)   NOT NULL,
                        ItemID       INTEGER        NOT NULL,
                        FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
                        PRIMARY KEY(ItemID, CategoryName)
                    );
create table Bids(BidderID             VARCHAR(300) NOT NULL,
                  Time               TIMESTAMP    NOT NULL,
                  Amount             INTEGER      NOT NULL,
                  FOREIGN KEY (BidderID) REFERENCES Bidder(BidderID)
                  PRIMARY KEY(BidderID, Time)
                   );

