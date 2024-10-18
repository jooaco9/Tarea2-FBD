/*******************************************************************************
   Create Tables
********************************************************************************/
CREATE TABLE Album
(
    Album_Id INT NOT NULL,
    Title VARCHAR(160) NOT NULL,
    Artist_Id INT NOT NULL,
    CONSTRAINT "PK_Album" PRIMARY KEY  (Album_Id)
);

CREATE TABLE Artist
(
    Artist_Id INT NOT NULL,
    Name VARCHAR(120),
    CONSTRAINT "PK_Artist" PRIMARY KEY  (Artist_Id)
);

CREATE TABLE Customer
(
    Customer_Id INT NOT NULL,
    First_Name VARCHAR(40) NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    Company VARCHAR(80),
    Address VARCHAR(70),
    City VARCHAR(40),
    State VARCHAR(40),
    Country VARCHAR(40),
    Postal_Code VARCHAR(10),
    Phone VARCHAR(24),
    Fax VARCHAR(24),
    Email VARCHAR(60) NOT NULL,
    Support_Rep_Id INT,
    CONSTRAINT "PK_Customer" PRIMARY KEY  (Customer_Id)
);

CREATE TABLE Employee
(
    Employee_Id INT NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    First_Name VARCHAR(20) NOT NULL,
    Title VARCHAR(30),
    Reports_To INT,
    Birth_Date TIMESTAMP,
    Hire_Date TIMESTAMP,
    Address VARCHAR(70),
    City VARCHAR(40),
    State VARCHAR(40),
    Country VARCHAR(40),
    Postal_Code VARCHAR(10),
    Phone VARCHAR(24),
    Fax VARCHAR(24),
    Email VARCHAR(60),
    CONSTRAINT "PK_Employee" PRIMARY KEY  (Employee_Id)
);

CREATE TABLE Genre
(
    Genre_Id INT NOT NULL,
    Name VARCHAR(120),
    CONSTRAINT "PK_Genre" PRIMARY KEY  (Genre_Id)
);

CREATE TABLE Invoice
(
    Invoice_Id INT NOT NULL,
    Customer_Id INT NOT NULL,
    Invoice_Date TIMESTAMP NOT NULL,
    Billing_Address VARCHAR(70),
    Billing_City VARCHAR(40),
    Billing_State VARCHAR(40),
    Billing_Country VARCHAR(40),
    Billing_Postal_Code VARCHAR(10),
    Total NUMERIC(10,2) NOT NULL,
    CONSTRAINT "PK_Invoice" PRIMARY KEY  (Invoice_Id)
);

CREATE TABLE Invoice_Line
(
    Invoice_Line_Id INT NOT NULL,
    Invoice_Id INT NOT NULL,
    Track_Id INT NOT NULL,
    Unit_Price NUMERIC(10,2) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT "PK_InvoiceLine" PRIMARY KEY  (Invoice_Line_Id)
);

CREATE TABLE Media_Type
(
    Media_Type_Id INT NOT NULL,
    Name VARCHAR(120),
    CONSTRAINT "PK_MediaType" PRIMARY KEY  (Media_Type_Id)
);

CREATE TABLE Playlist
(
    Playlist_Id INT NOT NULL,
    Name VARCHAR(120),
    CONSTRAINT "PK_Playlist" PRIMARY KEY  (Playlist_Id)
);

CREATE TABLE Playlist_Track
(
    Playlist_Id INT NOT NULL,
    Track_Id INT NOT NULL,
    CONSTRAINT "PK_PlaylistTrack" PRIMARY KEY  (Playlist_Id, Track_Id)
);

CREATE TABLE Track
(
    Track_Id INT NOT NULL,
    Name VARCHAR(200) NOT NULL,
    Album_Id INT,
    Media_Type_Id INT NOT NULL,
    Genre_Id INT,
    Composer VARCHAR(220),
    Milliseconds INT NOT NULL,
    Bytes INT,
    Unit_Price NUMERIC(10,2) NOT NULL,
    CONSTRAINT "PK_Track" PRIMARY KEY  (Track_Id)
);
