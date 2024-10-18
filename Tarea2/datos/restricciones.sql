/*******************************************************************************
   Create Foreign Keys
********************************************************************************/


ALTER TABLE Album ADD CONSTRAINT "FK_AlbumArtistId"
    FOREIGN KEY (Artist_Id) REFERENCES Artist (Artist_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_AlbumArtistId" ON Album (Artist_Id);

ALTER TABLE Customer ADD CONSTRAINT "FK_CustomerSupportRepId"
    FOREIGN KEY (Support_Rep_Id) REFERENCES Employee (Employee_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_CustomerSupportRepId" ON Customer (Support_Rep_Id);

ALTER TABLE Employee ADD CONSTRAINT "FK_EmployeeReportsTo"
    FOREIGN KEY (Reports_To) REFERENCES Employee (Employee_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_EmployeeReportsTo" ON Employee (Reports_To);

ALTER TABLE Invoice ADD CONSTRAINT "FK_InvoiceCustomerId"
    FOREIGN KEY (Customer_Id) REFERENCES Customer (Customer_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_InvoiceCustomerId" ON Invoice (Customer_Id);

ALTER TABLE Invoice_Line ADD CONSTRAINT "FK_InvoiceLineInvoiceId"
    FOREIGN KEY (Invoice_Id) REFERENCES Invoice (Invoice_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_InvoiceLineInvoiceId" ON Invoice_Line (Invoice_Id);

ALTER TABLE Invoice_Line ADD CONSTRAINT "FK_InvoiceLineTrackId"
    FOREIGN KEY (Track_Id) REFERENCES Track (Track_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_InvoiceLineTrackId" ON Invoice_Line (Track_Id);

ALTER TABLE Playlist_Track ADD CONSTRAINT "FK_PlaylistTrackPlaylistId"
    FOREIGN KEY (Playlist_Id) REFERENCES Playlist (Playlist_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE Playlist_Track ADD CONSTRAINT "FK_PlaylistTrackTrackId"
    FOREIGN KEY (Track_Id) REFERENCES Track (Track_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_PlaylistTrackTrackId" ON Playlist_Track (Track_Id);

ALTER TABLE Track ADD CONSTRAINT "FK_TrackAlbumId"
    FOREIGN KEY (Album_Id) REFERENCES Album (Album_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_TrackAlbumId" ON Track (Album_Id);

ALTER TABLE Track ADD CONSTRAINT "FK_TrackGenreId"
    FOREIGN KEY (Genre_Id) REFERENCES Genre (Genre_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_TrackGenreId" ON Track (Genre_Id);

ALTER TABLE Track ADD CONSTRAINT "FK_TrackMediaTypeId"
    FOREIGN KEY (Media_Type_Id) REFERENCES Media_Type (Media_Type_Id) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_TrackMediaTypeId" ON Track (Media_Type_Id);
