drop table if exists Items;
drop table if exists EbayUsers;
drop table if exists Categories;
drop table if exists Bids;

create table Items(ItemID            INTEGER        NOT NULL  PRIMARY KEY,
                   Name              VARCHAR(300)   NOT NULL,
                   Description       VARCHAR(300)   NOT NULL,
                   Currently         VARCHAR(300)   NOT NULL,
                   Number_of_Bids    INTEGER        NOT NULL,
                   First_Bid         VARCHAR(300)   NOT NULL,
                   Buy_Price         VARCHAR(300),    
                   Started           TIMESTAMP      NOT NULL,
                   Ends              TIMESTAMP      NOT NULL
                   );
create table EbayUsers(UserID         VARCHAR(300)   NOT NULL  PRIMARY KEY,
                      Rating         INTEGER         NOT NULL,
                      Country        VARCHAR(300),   
                      Location       VARCHAR(300)
                    );
create table Categories(CategoryName VARCHAR(300)   NOT NULL    PRIMARY KEY,
                        ItemID       INTEGER        NOT NULL,
                        FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
                    );
create table Bids(UserID             VARCHAR(300) NOT NULL,
                  Time               TIMESTAMP    NOT NULL    PRIMARY KEY,
                  Amount             INTEGER      NOT NULL,
                  FOREIGN KEY (UserID) REFERENCES EbayUsers(UserID)
                   );

