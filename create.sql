CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    PhoneNumber NVARCHAR(20) UNIQUE,
    PasswordHash NVARCHAR(255),
    City NVARCHAR(100),
    IsVerified BIT DEFAULT 0,
    Role NVARCHAR(20) CHECK (Role IN ('customer', 'admin')),
    IsActive BIT DEFAULT 1
);


CREATE TABLE Ticket (
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    OriginCity NVARCHAR(100),
    DestinationCity NVARCHAR(100),
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    Capacity INT,
    VehicleType NVARCHAR(20) CHECK (VehicleType IN ('flight', 'train', 'bus')),
    CarrierCompany NVARCHAR(100),
    TravelClass NVARCHAR(20) CHECK (TravelClass IN ('economy', 'business', 'VIP')),
    RemainingSeats INT
);

CREATE TABLE Reservation (
    ReservationID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    TicketID INT,
    ReservationStatus NVARCHAR(20) CHECK (ReservationStatus IN ('reserved', 'paid', 'cancelled')),
    ReservedAt DATETIME DEFAULT GETDATE(),
    ExpiryTime DATETIME,
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);


CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    ReservationID INT,
    UserID INT,
    Amount DECIMAL(10,2),
    PaymentMethod NVARCHAR(20) CHECK (PaymentMethod IN ('card', 'crypto', 'wallet')),
    PaymentStatus NVARCHAR(20) CHECK (PaymentStatus IN ('success', 'failed', 'pending')),
    PaidAt DATETIME,
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
);

CREATE TABLE Report (
    ReportID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    ReservationID INT,
    Category NVARCHAR(30) CHECK (Category IN ('payment', 'delay', 'info_error', 'other')),
    Description NVARCHAR(MAX),
    Status NVARCHAR(20) CHECK (Status IN ('pending', 'reviewed')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
);



