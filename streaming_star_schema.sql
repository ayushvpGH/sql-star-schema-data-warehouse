-- ==========================================
-- DIMENSION TABLES
-- ==========================================

CREATE TABLE Customer_Dim (
    Customer_key INT NOT NULL,
    Customer_ID VARCHAR(20) NOT NULL,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email_Address VARCHAR(100) NOT NULL,
    Account_Creation_Date DATE NOT NULL,
    Subscription_Tier VARCHAR(30) NOT NULL,
    Payment_Method VARCHAR(30) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Postal_Code VARCHAR(20) NOT NULL,
    Customer_Age INT NOT NULL,
    Account_Status VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Customer_Dim PRIMARY KEY (Customer_key)
);

CREATE TABLE Video_Dim (
    Video_key INT NOT NULL,
    Video_ID VARCHAR(20) NOT NULL,
    Video_Title VARCHAR(150) NOT NULL,
    Content_Type VARCHAR(30) NOT NULL, -- Movie or TV Show
    Genre VARCHAR(50) NOT NULL,
    Release_Year INT NOT NULL,
    Maturity_Rating VARCHAR(10) NOT NULL,
    Duration_Minutes INT NOT NULL,
    Original_Language VARCHAR(30) NOT NULL,
    Studio_Provider VARCHAR(100) NOT NULL,
    Is_4K_Available VARCHAR(5) NOT NULL,
    CONSTRAINT PK_Video_Dim PRIMARY KEY (Video_key)
);

CREATE TABLE Time_Dim (
    Time_key INT NOT NULL,
    Full_Date DATE NOT NULL,
    Day_Of_Week VARCHAR(15) NOT NULL,
    Calendar_Month VARCHAR(15) NOT NULL,
    Calendar_Quarter INT NOT NULL,
    Calendar_Year INT NOT NULL,
    Is_Weekend VARCHAR(5) NOT NULL,
    Is_Holiday VARCHAR(5) NOT NULL,
    Day_Of_Month INT NOT NULL,
    Week_Of_Year INT NOT NULL,
    Fiscal_Year INT NOT NULL,
    CONSTRAINT PK_Time_Dim PRIMARY KEY (Time_key)
);

-- ==========================================
-- FACT TABLES (ASSIGNMENT 3 & 4)
-- ==========================================

CREATE TABLE Video_Streaming_Transaction_Fact (
    Customer_key INT NOT NULL,
    Video_key INT NOT NULL,
    Time_key INT NOT NULL,
    Minutes_Streamed INT NOT NULL, 
    Pause_Count INT NOT NULL,
    CONSTRAINT PK_Video_Streaming_Fact PRIMARY KEY (Customer_key, Video_key, Time_key),
    CONSTRAINT FK_Streaming_Fact_Customer FOREIGN KEY (Customer_key) REFERENCES Customer_Dim(Customer_key),
    CONSTRAINT FK_Streaming_Fact_Video FOREIGN KEY (Video_key) REFERENCES Video_Dim(Video_key),
    CONSTRAINT FK_Streaming_Fact_Time FOREIGN KEY (Time_key) REFERENCES Time_Dim(Time_key)
);

CREATE TABLE Streaming_Quality_Anomaly_Fact (
    Customer_key INT NOT NULL,
    Video_key INT NOT NULL,
    Time_key INT NOT NULL,
    Buffering_Delay_Seconds INT NOT NULL, 
    Dropped_Frames_Count INT NOT NULL,
    CONSTRAINT PK_Streaming_Quality_Fact PRIMARY KEY (Customer_key, Video_key, Time_key),
    CONSTRAINT FK_Quality_Fact_Customer FOREIGN KEY (Customer_key) REFERENCES Customer_Dim(Customer_key),
    CONSTRAINT FK_Quality_Fact_Video FOREIGN KEY (Video_key) REFERENCES Video_Dim(Video_key),
    CONSTRAINT FK_Quality_Fact_Time FOREIGN KEY (Time_key) REFERENCES Time_Dim(Time_key)
);

CREATE TABLE Video_Watchlist_Event_Fact (
    Customer_key INT NOT NULL,
    Video_key INT NOT NULL,
    Time_key INT NOT NULL,
    CONSTRAINT PK_Video_Watchlist_Fact PRIMARY KEY (Customer_key, Video_key, Time_key),
    CONSTRAINT FK_Watchlist_Fact_Customer FOREIGN KEY (Customer_key) REFERENCES Customer_Dim(Customer_key),
    CONSTRAINT FK_Watchlist_Fact_Video FOREIGN KEY (Video_key) REFERENCES Video_Dim(Video_key),
    CONSTRAINT FK_Watchlist_Fact_Time FOREIGN KEY (Time_key) REFERENCES Time_Dim(Time_key)
);

CREATE TABLE Customer_Promo_Eligibility_Fact (
    Customer_key INT NOT NULL,
    Video_key INT NOT NULL,
    Start_Time_key INT NOT NULL,
    End_Time_key INT NOT NULL,
    CONSTRAINT PK_Customer_Promo_Fact PRIMARY KEY (Customer_key, Video_key, Start_Time_key, End_Time_key),
    CONSTRAINT FK_Promo_Fact_Customer FOREIGN KEY (Customer_key) REFERENCES Customer_Dim(Customer_key),
    CONSTRAINT FK_Promo_Fact_Video FOREIGN KEY (Video_key) REFERENCES Video_Dim(Video_key),
    CONSTRAINT FK_Promo_Fact_StartTime FOREIGN KEY (Start_Time_key) REFERENCES Time_Dim(Time_key),
    CONSTRAINT FK_Promo_Fact_EndTime FOREIGN KEY (End_Time_key) REFERENCES Time_Dim(Time_key)
);