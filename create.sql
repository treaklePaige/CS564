drop table if exists Items;
drop table if exists Bidders;
drop table if exists Sellers;
drop table if exists Categories;
drop table if exists Bids;

create table Bidders(BidderID        VARCHAR(300)    NOT NULL  PRIMARY KEY,
                      BidderRating   INTEGER         NOT NULL,
                      Location       VARCHAR(300),
                      Country        VARCHAR(300)
                    );
create table Sellers(SellerID        VARCHAR(300)   NOT NULL  PRIMARY KEY,
                      SellerRating   INTEGER         NOT NULL,
                      Location       VARCHAR(300),
                      Country        VARCHAR(300)
                    );
create table Items(ItemID            INTEGER        NOT NULL  PRIMARY KEY,
                   SellerID          VARCHAR(300)   NOT NULL,
                   Name              VARCHAR(300)   NOT NULL,
                   Description       VARCHAR(500)   NOT NULL,
                   Currently         DOUBLE         NOT NULL,
                   Number_of_Bids    INTEGER        NOT NULL,
                   First_Bid         DOUBLE         NOT NULL,
                   Buy_Price         DOUBLE,    
                   Started           TIMESTAMP      NOT NULL,
                   Ends              TIMESTAMP      NOT NULL,
                   FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
                  );
create table Categories(ItemID       INTEGER        NOT NULL,
                        CategoryName VARCHAR(300)   NOT NULL,
                        FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
                        PRIMARY KEY(ItemID, CategoryName)
                    );
create table Bids(ItemID             INTEGER      NOT NULL,
                  BidderID           VARCHAR(300) NOT NULL,
                  Time               TIMESTAMP    NOT NULL,
                  Amount             DOUBLE       NOT NULL,
                  FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
                  FOREIGN KEY (BidderID) REFERENCES Bidders(BidderID),
                  PRIMARY KEY(BidderID, Time)
                  );

