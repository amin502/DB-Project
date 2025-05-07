INSERT INTO [User] (FirstName, LastName, PhoneNumber, PasswordHash, City, IsVerified, Role, IsActive) VALUES  
('Ali', 'Rezaei', '09121234567', 'hash1', 'Tehran', 0, 'customer', 1),  
('Sara', 'Ahmadi', '09361234567', 'hash2', 'Mashhad', 1, 'customer', 1),  
('Mohammad', 'Hosseini', '09211234567', 'hash3', 'Isfahan', 0, 'admin', 1),  
('Neda', 'Khanlari', '09091234567', 'hash4', 'Shiraz', 1, 'customer', 1),  
('Mehdi', 'Jafari', '09131234567', 'hash5', 'Karaj', 0, 'customer', 1),  
('Zahra', 'Mousavi', '09391234567', 'hash6', 'Tabriz', 1, 'customer', 1),  
('Reza', 'Fard', '09231234567', 'hash7', 'Kermanshah', 0, 'admin', 1),  
('Farnaz', 'Ebrahimi', '09161234567', 'hash8', 'Yazd', 1, 'customer', 1),  
('Hossein', 'Bakhtiari', '09261234567', 'hash9', 'Kashan', 0, 'customer', 1),  
('Lila', 'Shirazi', '09451234567', 'hash10', 'Qom', 1, 'customer', 1);  



INSERT INTO Ticket (OriginCity, DestinationCity, DepartureTime, ArrivalTime, Capacity, VehicleType, CarrierCompany, TravelClass, RemainingSeats) VALUES  
('Tehran', 'Mashhad', '2025-05-10 08:00', '2025-05-10 10:30', 150, 'flight', 'IranAir', 'economy', 50),  
('Isfahan', 'Shiraz', '2025-05-11 09:00', '2025-05-11 10:45', 100, 'train', 'RAIL', 'business', 20),  
('Tehran', 'Tabriz', '2025-05-12 07:30', '2025-05-12 09:00', 200, 'bus', 'BusCo', 'economy', 150),  
('Kerman', 'Yazd', '2025-05-13 14:00', '2025-05-13 16:00', 80, 'bus', 'BusCo', 'VIP', 10),  
('Mashhad', 'Qom', '2025-05-14 12:00', '2025-05-14 14:00', 120, 'train', 'RAIL', 'economy', 60),  
('Tehran', 'Ahvaz', '2025-05-15 06:30', '2025-05-15 09:00', 180, 'flight', 'IranAir', 'business', 45),  
('Yazd', 'Bushehr', '2025-05-16 11:00', '2025-05-16 13:30', 90, 'bus', 'BusCo', 'economy', 70),  
('Tabriz', 'Ardabil', '2025-05-17 10:00', '2025-05-17 11:30', 50, 'train', 'RAIL', 'VIP', 5),  
('Kish', 'Tehran', '2025-05-18 15:00', '2025-05-18 17:00', 120, 'flight', 'IranAir', 'economy', 80),  
('Mashhad', 'Kerman', '2025-05-19 13:00', '2025-05-19 15:30', 160, 'flight', 'IranAir', 'business', 30);  





INSERT INTO Reservation (UserID, TicketID, ReservationStatus, ReservedAt, ExpiryTime) VALUES  
(1, 1, 'reserved', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(2, 2, 'paid', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(3, 3, 'cancelled', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(4, 4, 'reserved', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(5, 5, 'paid', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(6, 6, 'reserved', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(7, 7, 'paid', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(8, 8, 'cancelled', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(9, 9, 'reserved', GETDATE(), DATEADD(hour, 24, GETDATE())),  
(10, 10, 'paid', GETDATE(), DATEADD(hour, 24, GETDATE()));  

INSERT INTO Payment (ReservationID, UserID, Amount, PaymentMethod, PaymentStatus, PaidAt) VALUES  
(1, 1, 100.00, 'card', 'success', GETDATE()),  
(2, 2, 150.50, 'wallet', 'pending', GETDATE()),  
(3, 3, 75.00, 'crypto', 'failed', GETDATE()),  
(4, 4, 200.00, 'card', 'success', GETDATE()),  
(5, 5, 50.00, 'wallet', 'success', GETDATE()),  
(6, 6, 120.00, 'card', 'pending', GETDATE()),  
(7, 7, 180.00, 'crypto', 'success', GETDATE()),  
(8, 8, 90.00, 'wallet', 'failed', GETDATE()),  
(9, 9, 110.00, 'card', 'success', GETDATE()),  
(10, 10, 130.00, 'crypto', 'pending', GETDATE());


INSERT INTO Report (UserID, ReservationID, Category, Description, Status) VALUES  
(1, 1, 'payment', 'Payment was not processed correctly.', 'pending'),  
(2, 2, 'delay', 'Flight delayed by 2 hours.', 'reviewed'),  
(3, 3, 'info_error', 'Incorrect information in reservation details.', 'pending'),  
(4, 4, 'other', 'Miscellaneous issue reported.', 'reviewed'),  
(5, 5, 'payment', 'Failed to charge the credit card.', 'pending'),  
(6, 6, 'delay', 'Train arrived 30 minutes late.', 'reviewed'),  
(7, 7, 'info_error', 'Wrong departure time displayed.', 'pending'),  
(8, 8, 'other', 'Customer service issue.', 'reviewed'),  
(9, 9, 'payment', 'Refund not received after cancellation.', 'pending'),  
(10, 10, 'delay', 'Bus was rerouted unexpectedly.', 'reviewed');  



-- درج کاربران نمونه
INSERT INTO [User] (FirstName, LastName, PhoneNumber, PasswordHash, City, Role)
VALUES
('Ali', 'Rezaei', '09123000001', 'pass1', 'Tehran', 'customer'),
('Sara', 'Ahmadi', '09123000002', 'pass2', 'Shiraz', 'customer'),
('Reza', 'Karimi', '09123000003', 'pass3', 'Mashhad', 'customer');

-- درج بلیت نمونه
INSERT INTO Ticket (OriginCity, DestinationCity, DepartureTime, ArrivalTime,
                    Capacity, VehicleType, CarrierCompany, TravelClass, RemainingSeats)
VALUES
('Tehran', 'Shiraz', '2025-06-01 08:00', '2025-06-01 10:00', 100, 'flight', 'IranAir', 'economy', 50),
('Mashhad', 'Isfahan', '2025-06-02 09:00', '2025-06-02 12:00', 80, 'train', 'RAJA', 'VIP', 20),
('Tabriz', 'Tehran', '2025-06-03 07:00', '2025-06-03 09:30', 60, 'bus', 'Royal Safar', 'economy', 15);

-- درج رزرو نمونه
INSERT INTO Reservation (UserID, TicketID, ReservationStatus, ExpiryTime)
VALUES
(1, 1, 'paid', DATEADD(HOUR, 2, GETDATE())),
(2, 2, 'reserved', DATEADD(HOUR, 2, GETDATE())),
(3, 3, 'cancelled', DATEADD(HOUR, 2, GETDATE()));

-- درج پرداخت نمونه
INSERT INTO Payment (ReservationID, UserID, Amount, PaymentMethod, PaymentStatus, PaidAt)
VALUES
(1, 1, 1200000, 'card', 'success', GETDATE()),
(3, 3, 1000000, 'wallet', 'success', GETDATE());

-- درج گزارش نمونه
INSERT INTO Report (UserID, ReservationID, Category, Description, Status)
VALUES
(2, 2, 'delay', 'Train was delayed', 'pending'),
(3, 3, 'info_error', 'Wrong name on ticket', 'pending');

